<?php
declare(strict_types=1);

if (basename($_SERVER['SCRIPT_FILENAME'] ?? '') === '_lib.php') {
    http_response_code(403);
    exit;
}

const WF_CLASSES = ['guerrier', 'paladin', 'chasseur', 'voleur', 'pretre', 'chaman', 'mage', 'demoniste', 'druide'];
const WF_MAX_POINTS = 51;
const WF_NAME_MAX = 60;
const WF_AUTHOR_MAX = 30;
const WF_DESC_MAX = 3000;
const WF_DESC_LINES = 60;
const WF_RATE_LIMIT = 15;
const WF_RATE_WINDOW = 3600;
const WF_DATA_DIR = __DIR__ . '/data';

function wf_db(): PDO
{
    static $pdo = null;
    if ($pdo instanceof PDO) {
        return $pdo;
    }
    if (!is_dir(WF_DATA_DIR)) {
        mkdir(WF_DATA_DIR, 0750, true);
    }
    $pdo = new PDO('sqlite:' . WF_DATA_DIR . '/builds.sqlite');
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $pdo->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    $pdo->exec('PRAGMA busy_timeout = 4000');
    $pdo->exec('PRAGMA journal_mode = WAL');
    $pdo->exec('PRAGMA foreign_keys = ON');
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS builds (
            id          TEXT PRIMARY KEY,
            class       TEXT NOT NULL,
            build       TEXT NOT NULL,
            points      INTEGER NOT NULL,
            name        TEXT NOT NULL,
            author      TEXT NOT NULL DEFAULT \'\',
            is_public   INTEGER NOT NULL DEFAULT 0,
            token_hash  TEXT NOT NULL,
            ip_hash     TEXT NOT NULL,
            views       INTEGER NOT NULL DEFAULT 0,
            created_at  INTEGER NOT NULL,
            updated_at  INTEGER NOT NULL
        )'
    );
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_builds_public ON builds (is_public, class, views)');
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_builds_ip ON builds (ip_hash, created_at)');
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS build_views (
            build_id TEXT NOT NULL REFERENCES builds(id) ON DELETE CASCADE,
            visitor  TEXT NOT NULL,
            day      INTEGER NOT NULL,
            PRIMARY KEY (build_id, visitor, day)
        )'
    );
    $cols = array_column($pdo->query('PRAGMA table_info(builds)')->fetchAll(), 'name');
    if (!in_array('description', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN description TEXT NOT NULL DEFAULT \'\'');
    }
    if (!in_array('likes', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN likes INTEGER NOT NULL DEFAULT 0');
    }
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS build_likes (
            build_id   TEXT NOT NULL REFERENCES builds(id) ON DELETE CASCADE,
            visitor    TEXT NOT NULL,
            created_at INTEGER NOT NULL,
            PRIMARY KEY (build_id, visitor)
        )'
    );
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_likes_visitor ON build_likes (visitor, created_at)');
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_builds_likes ON builds (is_public, likes)');

    if (!in_array('owner_user_id', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN owner_user_id TEXT');
    }
    if (!in_array('comments_enabled', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN comments_enabled INTEGER NOT NULL DEFAULT 1');
    }
    if (!in_array('comment_count', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN comment_count INTEGER NOT NULL DEFAULT 0');
    }
    // Phase 2 : ordre des points (?path=). Vide pour les anciens builds = ordre automatique.
    if (!in_array('path', $cols, true)) {
        $pdo->exec('ALTER TABLE builds ADD COLUMN path TEXT NOT NULL DEFAULT \'\'');
    }
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS users (
            id             TEXT PRIMARY KEY,          -- identifiant Twitch
            login          TEXT NOT NULL,
            display_name   TEXT NOT NULL,
            avatar         TEXT NOT NULL DEFAULT \'\',
            twitch_created INTEGER NOT NULL DEFAULT 0,
            banned         INTEGER NOT NULL DEFAULT 0,
            created_at     INTEGER NOT NULL,
            last_seen      INTEGER NOT NULL
        )'
    );
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS sessions (
            token_hash TEXT PRIMARY KEY,
            user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            created_at INTEGER NOT NULL,
            expires_at INTEGER NOT NULL
        )'
    );
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS build_comments (
            id         TEXT PRIMARY KEY,
            build_id   TEXT NOT NULL REFERENCES builds(id) ON DELETE CASCADE,
            user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            body       TEXT NOT NULL,
            status     TEXT NOT NULL DEFAULT \'visible\',   -- visible | reported | hidden
            score      INTEGER NOT NULL DEFAULT 0,
            reports    INTEGER NOT NULL DEFAULT 0,
            created_at INTEGER NOT NULL
        )'
    );
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_bc_build ON build_comments (build_id, status)');
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_bc_user ON build_comments (user_id, created_at)');
    $pdo->exec('CREATE INDEX IF NOT EXISTS idx_bc_status ON build_comments (status)');
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS comment_votes (
            comment_id TEXT NOT NULL REFERENCES build_comments(id) ON DELETE CASCADE,
            user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            value      INTEGER NOT NULL,
            PRIMARY KEY (comment_id, user_id)
        )'
    );
    $pdo->exec(
        'CREATE TABLE IF NOT EXISTS comment_reports (
            comment_id TEXT NOT NULL REFERENCES build_comments(id) ON DELETE CASCADE,
            user_id    TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
            reason     TEXT NOT NULL DEFAULT \'\',
            created_at INTEGER NOT NULL,
            PRIMARY KEY (comment_id, user_id)
        )'
    );
    return $pdo;
}

function wf_secret(): string
{
    static $secret = null;
    if ($secret !== null) {
        return $secret;
    }
    $file = WF_DATA_DIR . '/secret.key';
    if (!is_file($file)) {
        if (!is_dir(WF_DATA_DIR)) {
            mkdir(WF_DATA_DIR, 0750, true);
        }
        file_put_contents($file, bin2hex(random_bytes(32)), LOCK_EX);
        @chmod($file, 0640);
    }
    $secret = trim((string) file_get_contents($file));
    return $secret;
}

function wf_visitor(): string
{
    $ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
    return substr(hash_hmac('sha256', $ip, wf_secret()), 0, 32);
}

function wf_json($data, int $status = 200): void
{
    http_response_code($status);
    header('Content-Type: application/json; charset=utf-8');
    header('Cache-Control: no-store');
    header('X-Robots-Tag: noindex, nofollow');
    echo json_encode($data, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function wf_error(string $message, int $status = 400): void
{
    wf_json(['ok' => false, 'error' => $message], $status);
}

function wf_new_id(): string
{
    $alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789';
    $max = strlen($alphabet) - 1;
    $id = '';
    for ($i = 0; $i < 8; $i++) {
        $id .= $alphabet[random_int(0, $max)];
    }
    return $id;
}

function wf_valid_id($id): bool
{
    return is_string($id) && preg_match('/^[A-Za-z0-9]{8}$/', $id) === 1;
}

function wf_strip_unsafe(string $value, bool $multiline = false): string
{
    if (!mb_check_encoding($value, 'UTF-8')) {
        $value = mb_convert_encoding($value, 'UTF-8', 'UTF-8');
    }
    $value = str_replace(["\r\n", "\r"], "\n", $value);
    $control = $multiline ? '\x00-\x09\x0B-\x1F\x7F' : '\x00-\x1F\x7F';
    $value = preg_replace(
        '/[' . $control . '\x{00AD}\x{034F}\x{061C}\x{115F}\x{1160}\x{17B4}\x{17B5}\x{180E}\x{200B}-\x{200F}\x{202A}-\x{202E}\x{2060}-\x{206F}\x{3164}\x{FE00}-\x{FE0F}\x{FEFF}\x{FFA0}\x{FFF0}-\x{FFFB}\x{E0000}-\x{E007F}]/u',
        '',
        $value
    ) ?? '';
    $value = preg_replace('/(\p{M}{2})\p{M}+/u', '$1', $value) ?? '';
    return $value;
}

function wf_clean_text($value, int $max): string
{
    if (!is_string($value)) {
        return '';
    }
    $value = wf_strip_unsafe($value);
    $value = str_replace(['<', '>'], '', $value);
    $value = preg_replace('/\s+/u', ' ', $value) ?? '';
    $value = trim($value);
    return mb_substr($value, 0, $max);
}

function wf_has_link(string $value): bool
{
    return preg_match('~(https?:|ftp:|www\.|://|\b[a-z0-9-]{2,}\.(com|net|org|fr|io|gg|xyz|ru|cn|info|tk|ly|me|co|shop|site|online|link)\b|@[a-z0-9-]+\.[a-z]{2,}|discord\.gg)~iu', $value) === 1;
}

function wf_has_letters(string $value, int $min = 2): bool
{
    return preg_match_all('/[\p{L}\p{N}]/u', $value) >= $min;
}

function wf_admin_key(): string
{
    $file = WF_DATA_DIR . '/admin.key';
    if (!is_file($file)) {
        if (!is_dir(WF_DATA_DIR)) {
            mkdir(WF_DATA_DIR, 0750, true);
        }
        file_put_contents($file, bin2hex(random_bytes(20)), LOCK_EX);
        @chmod($file, 0640);
    }
    return trim((string) file_get_contents($file));
}

function wf_is_admin($key): bool
{
    return is_string($key) && strlen($key) === 40 && hash_equals(wf_admin_key(), $key);
}

function wf_render_rich(string $text): string
{
    $text = trim(wf_strip_unsafe($text, true));
    $text = preg_replace("/\n{3,}/", "\n\n", $text) ?? '';
    $lines = explode("\n", $text);

    $html = '';
    $para = [];
    $list = null;
    $quote = [];

    $flushPara = static function () use (&$para, &$html) {
        if ($para) {
            $html .= '<p>' . implode('<br>', array_map('wf_render_inline', $para)) . '</p>';
            $para = [];
        }
    };
    $flushList = static function () use (&$list, &$html) {
        if ($list) {
            $html .= '</' . $list . '>';
            $list = null;
        }
    };
    $flushQuote = static function () use (&$quote, &$html) {
        if ($quote) {
            $html .= '<blockquote>' . implode('<br>', array_map('wf_render_inline', $quote)) . '</blockquote>';
            $quote = [];
        }
    };

    foreach ($lines as $line) {
        $line = rtrim($line);
        if (preg_match('/^\s*[-*•]\s+(.+)$/u', $line, $m)) {
            $flushPara(); $flushQuote();
            if ($list !== 'ul') { $flushList(); $html .= '<ul>'; $list = 'ul'; }
            $html .= '<li>' . wf_render_inline($m[1]) . '</li>';
        } elseif (preg_match('/^\s*\d{1,3}[.)]\s+(.+)$/u', $line, $m)) {
            $flushPara(); $flushQuote();
            if ($list !== 'ol') { $flushList(); $html .= '<ol>'; $list = 'ol'; }
            $html .= '<li>' . wf_render_inline($m[1]) . '</li>';
        } elseif (preg_match('/^\s*>\s?(.*)$/u', $line, $m)) {
            $flushPara(); $flushList();
            $quote[] = $m[1];
        } elseif (trim($line) === '') {
            $flushPara(); $flushList(); $flushQuote();
        } else {
            $flushList(); $flushQuote();
            $para[] = $line;
        }
    }
    $flushPara(); $flushList(); $flushQuote();
    return $html;
}

function wf_render_inline(string $line): string
{
    $s = htmlspecialchars($line, ENT_QUOTES | ENT_SUBSTITUTE | ENT_HTML5, 'UTF-8');

    $codes = [];
    $s = preg_replace_callback('/`([^`]{1,200})`/u', static function ($m) use (&$codes) {
        $codes[] = '<code>' . $m[1] . '</code>';
        return "\u{E000}" . (count($codes) - 1) . "\u{E001}";
    }, $s) ?? $s;

    $rules = [
        '/\*\*(?=\S)(.+?)(?<=\S)\*\*/u'                        => 'strong',
        '/__(?=\S)(.+?)(?<=\S)__/u'                                => 'u',
        '/~~(?=\S)(.+?)(?<=\S)~~/u'                                => 's',
        '/(?<![\*\w])\*(?=\S)([^*]+?)(?<=\S)\*(?![\*\w])/u'  => 'em',
        '/(?<![_\w])_(?=\S)([^_]+?)(?<=\S)_(?![_\w])/u'          => 'em',
    ];
    foreach ($rules as $re => $tag) {
        $s = preg_replace_callback($re, static function ($m) use ($tag) {
            return wf_tags_balanced($m[1]) ? "<$tag>{$m[1]}</$tag>" : $m[0];
        }, $s) ?? $s;
    }

    return preg_replace_callback("/\u{E000}(\d+)\u{E001}/u", static function ($m) use ($codes) {
        return $codes[(int) $m[1]] ?? '';
    }, $s) ?? $s;
}

function wf_build_points($build): ?int
{
    if (!is_string($build) || preg_match('/^[0-5]{1,30}-[0-5]{1,30}-[0-5]{1,30}$/', $build) !== 1) {
        return null;
    }
    $points = array_sum(array_map('intval', str_split(str_replace('-', '', $build))));
    if ($points < 1 || $points > WF_MAX_POINTS) {
        return null;
    }
    return $points;
}

/**
 * Valide un ?path= (voir packages/schema/BUILD_CODEC.md) : version « 1 », chiffre
 * Talentueux 0-7, puis 1 caractère URL-safe par point. Le nombre de points doit être
 * celui du build. Renvoie '' si absent ou incohérent : le build est alors rouvert
 * avec l'ordre automatique (jamais de refus de sauvegarde pour ça).
 */
function wf_clean_path($path, int $points): string
{
    if (!is_string($path) || preg_match('/^1[0-7][A-Za-z0-9_-]{0,51}$/', $path) !== 1) {
        return '';
    }
    return strlen($path) - 2 === $points ? $path : '';
}

function wf_required_level(int $points): int
{
    return $points === 0 ? 1 : min(60, 9 + $points);
}

function wf_clean_multiline($body, int $max, int $maxLines): string
{
    if (!is_string($body)) {
        return '';
    }
    $body = trim(wf_strip_unsafe($body, true));
    $body = preg_replace("/[ \t]+\n/", "\n", $body) ?? '';
    $body = preg_replace("/\n{3,}/", "\n\n", $body) ?? '';
    $lines = explode("\n", $body);
    if (count($lines) > $maxLines) {
        $body = implode("\n", array_slice($lines, 0, $maxLines));
    }
    return mb_substr($body, 0, $max);
}

function wf_public_build(array $row, bool $full = false): array
{
    $parts = array_map(
        static fn($p) => array_sum(array_map('intval', str_split($p))),
        explode('-', $row['build'])
    );
    return [
        'id'      => $row['id'],
        'class'   => $row['class'],
        'build'   => $row['build'],
        'path'    => (string) ($row['path'] ?? ''),
        'points'  => (int) $row['points'],
        'split'   => $parts,
        'level'   => wf_required_level((int) $row['points']),
        'name'    => $row['name'],
        'author'  => $row['author'],
        'public'  => (bool) $row['is_public'],
        'views'   => (int) $row['views'],
        'likes'   => (int) ($row['likes'] ?? 0),
        'comments'=> (int) ($row['comment_count'] ?? 0),
        'comments_enabled' => (bool) ($row['comments_enabled'] ?? 1),
        'created' => (int) $row['created_at'],
        'updated' => (int) $row['updated_at'],
        'url'     => '/b/' . $row['id'],
    ] + ($full ? [
        'description'      => (string) ($row['description'] ?? ''),
        'description_html' => wf_render_rich((string) ($row['description'] ?? '')),
    ] : []);
}

function wf_tags_balanced(string $fragment): bool
{
    preg_match_all('#<(/?)(strong|u|s|em)>#', $fragment, $m, PREG_SET_ORDER);
    $stack = [];
    foreach ($m as $t) {
        if ($t[1] === '') {
            $stack[] = $t[2];
        } elseif (array_pop($stack) !== $t[2]) {
            return false;
        }
    }
    return !$stack;
}

function wf_config(): array
{
    static $cfg = null;
    if ($cfg !== null) {
        return $cfg;
    }
    $cfg = [
        'twitch_client_id'     => '',
        'twitch_client_secret' => '',
        'admins'               => [],
        'min_account_days'     => 7,
        'report_threshold'     => 3,
    ];
    $file = WF_DATA_DIR . '/config.json';
    if (is_file($file)) {
        $json = json_decode((string) file_get_contents($file), true);
        if (is_array($json)) {
            $cfg = array_merge($cfg, $json);
        }
    }
    $cfg['admins'] = array_map('strtolower', array_map('strval', (array) $cfg['admins']));
    return $cfg;
}

function wf_site_url(): string
{
    return 'https://' . ($_SERVER['HTTP_HOST'] ?? 'azerothforever.info');
}

const WF_SESSION_COOKIE = 'wf_session';
const WF_SESSION_DAYS = 30;

function wf_session_start(string $userId): void
{
    $token = bin2hex(random_bytes(32));
    $now = time();
    $exp = $now + WF_SESSION_DAYS * 86400;
    wf_db()->prepare('INSERT INTO sessions (token_hash, user_id, created_at, expires_at) VALUES (?, ?, ?, ?)')
        ->execute([hash('sha256', $token), $userId, $now, $exp]);
    setcookie(WF_SESSION_COOKIE, $token, [
        'expires' => $exp, 'path' => '/', 'secure' => ($_SERVER['HTTPS'] ?? '') !== '' && ($_SERVER['HTTPS'] ?? '') !== 'off',
        'httponly' => true, 'samesite' => 'Lax',
    ]);
    if (random_int(1, 50) === 1) {
        wf_db()->prepare('DELETE FROM sessions WHERE expires_at < ?')->execute([$now]);
    }
}

function wf_session_end(): void
{
    $token = $_COOKIE[WF_SESSION_COOKIE] ?? '';
    if (is_string($token) && $token !== '') {
        wf_db()->prepare('DELETE FROM sessions WHERE token_hash = ?')->execute([hash('sha256', $token)]);
    }
    setcookie(WF_SESSION_COOKIE, '', ['expires' => time() - 3600, 'path' => '/', 'httponly' => true, 'samesite' => 'Lax']);
}

function wf_current_user(): ?array
{
    static $user = false;
    if ($user !== false) {
        return $user;
    }
    $user = null;
    $token = $_COOKIE[WF_SESSION_COOKIE] ?? '';
    if (!is_string($token) || !preg_match('/^[a-f0-9]{64}$/', $token)) {
        return null;
    }
    $stmt = wf_db()->prepare(
        'SELECT u.* FROM sessions s JOIN users u ON u.id = s.user_id WHERE s.token_hash = ? AND s.expires_at > ?'
    );
    $stmt->execute([hash('sha256', $token), time()]);
    $row = $stmt->fetch();
    if ($row) {
        $row['is_admin'] = in_array(strtolower($row['login']), wf_config()['admins'], true);
        $user = $row;
    }
    return $user;
}

function wf_public_user(?array $u): ?array
{
    if (!$u) {
        return null;
    }
    return [
        'id'      => $u['id'],
        'name'    => $u['display_name'],
        'login'   => $u['login'],
        'avatar'  => $u['avatar'],
        'admin'   => !empty($u['is_admin']),
        'banned'  => (bool) $u['banned'],
    ];
}

function wf_is_moderator_admin(?array $user, $adminKey): bool
{
    return ($user && !empty($user['is_admin'])) || wf_is_admin($adminKey);
}

function wf_check_origin(): void
{
    $origin = $_SERVER['HTTP_ORIGIN'] ?? '';
    if ($origin !== '') {
        $host = parse_url($origin, PHP_URL_HOST);
        $self = preg_replace('/:\d+$/', '', (string) ($_SERVER['HTTP_HOST'] ?? ''));
        if (!$host || strcasecmp($host, $self) !== 0) {
            wf_error('Origine refusée.', 403);
        }
    }
    if (stripos((string) ($_SERVER['CONTENT_TYPE'] ?? ''), 'application/json') !== 0) {
        wf_error('Format refusé.', 415);
    }
}

function wf_http(string $method, string $url, array $headers = [], ?string $body = null): array
{
    if (function_exists('curl_init')) {
        $ch = curl_init($url);
        curl_setopt_array($ch, [
            CURLOPT_CUSTOMREQUEST  => $method,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_HTTPHEADER     => $headers,
            CURLOPT_TIMEOUT        => 10,
            CURLOPT_CONNECTTIMEOUT => 5,
        ]);
        if ($body !== null) {
            curl_setopt($ch, CURLOPT_POSTFIELDS, $body);
        }
        $res = curl_exec($ch);
        $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
        curl_close($ch);
        return [$code, $res === false ? '' : (string) $res];
    }
    $ctx = stream_context_create(['http' => [
        'method' => $method, 'header' => implode("\r\n", $headers), 'content' => $body ?? '',
        'timeout' => 10, 'ignore_errors' => true,
    ]]);
    $res = @file_get_contents($url, false, $ctx);
    $code = 0;
    foreach ($http_response_header ?? [] as $h) {
        if (preg_match('#^HTTP/\S+\s+(\d{3})#', $h, $m)) {
            $code = (int) $m[1];
        }
    }
    return [$code, $res === false ? '' : (string) $res];
}


function wf_normalize_words(string $text): string
{
    $t = mb_strtolower($text, 'UTF-8');
    $t = strtr($t, [
        'à' => 'a', 'â' => 'a', 'ä' => 'a', 'á' => 'a', 'ã' => 'a', 'ç' => 'c', 'é' => 'e', 'è' => 'e', 'ê' => 'e',
        'ë' => 'e', 'î' => 'i', 'ï' => 'i', 'í' => 'i', 'ô' => 'o', 'ö' => 'o', 'ó' => 'o', 'û' => 'u', 'ù' => 'u',
        'ü' => 'u', 'ú' => 'u', 'ÿ' => 'y', 'œ' => 'oe', 'æ' => 'ae',
        '0' => 'o', '1' => 'i', '3' => 'e', '4' => 'a', '5' => 's', '7' => 't', '@' => 'a', '$' => 's', '€' => 'e', '!' => 'i',
    ]);
    $t = preg_replace('/(\p{L})\1{2,}/u', '$1', $t) ?? $t;
    return $t;
}

function wf_banned_words(): array
{
    static $list = null;
    if ($list !== null) {
        return $list;
    }
    $words = [
        'con', 'cons', 'conne', 'connes', 'connard', 'connards', 'connasse', 'connasses', 'conard', 'conasse',
        'pute', 'putes', 'putain', 'pd', 'pede', 'pedes', 'pedale', 'tapette', 'tafiole', 'salope', 'salopes',
        'salaud', 'salauds', 'batard', 'batards', 'enfoire', 'enfoires', 'encule', 'encules', 'enculer', 'enculee',
        'fdp', 'ntm', 'tg', 'ftg', 'nique', 'niquer', 'niquez', 'baise', 'baiser', 'bite', 'bites', 'couille', 'couilles',
        'chienne', 'catin', 'trouduc', 'abruti', 'abrutis', 'debile', 'debiles', 'mongol', 'mongole', 'gogol', 'triso',
        'negre', 'negres', 'negro', 'bougnoule', 'bougnoul', 'youpin', 'youpins', 'bamboula',
        'chinetoque', 'bicot', 'nazi', 'nazis', 'hitler', 'gouine', 'travelo', 'suceur', 'suceuse',
        'fuck', 'fucking', 'shit', 'bitch', 'cunt', 'nigger', 'nigga', 'faggot', 'whore', 'slut', 'kys',
    ];
    $stems = [
        'filsdepute', 'fdpute', 'niquetamere', 'nictamere', 'ntamere', 'tamerelapute', 'vatefaire', 'fermetagueule',
        'fermelagueule', 'tagueule', 'enculer', 'connard', 'connasse', 'salope', 'enfoire', 'bougnoul', 'youpin',
        'suicidetoi', 'crevesalope', 'killyourself', 'nigger', 'faggot', 'tapette', 'sieghei',
    ];
    $file = WF_DATA_DIR . '/mots-interdits.txt';
    if (is_file($file)) {
        foreach (file($file, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) ?: [] as $line) {
            $w = trim(wf_normalize_words($line));
            if ($w === '' || $w[0] === '#') {
                continue;
            }
            if (strpos($w, ' ') !== false) {
                $stems[] = preg_replace('/[^a-z]/', '', $w);
            } else {
                $words[] = $w;
            }
        }
    }
    $list = ['words' => array_fill_keys($words, true), 'stems' => array_values(array_filter(array_unique($stems)))];
    return $list;
}

function wf_moderation_problem(string $text): ?string
{
    $norm = wf_normalize_words($text);
    $list = wf_banned_words();

    foreach (preg_split('/[^\p{L}]+/u', $norm, -1, PREG_SPLIT_NO_EMPTY) ?: [] as $w) {
        if (isset($list['words'][$w])) {
            return 'Ton message contient un mot interdit. Reste courtois !';
        }
    }
    if (preg_match_all('/(?:\b\p{L}[\s._\-*,+]+){2,}\p{L}\b/u', $norm, $m)) {
        foreach ($m[0] as $seq) {
            $joined = preg_replace('/[^\p{L}]/u', '', $seq);
            if (isset($list['words'][$joined])) {
                return 'Ton message contient un mot interdit. Reste courtois !';
            }
        }
    }
    $compact = preg_replace('/[^a-z]/', '', $norm) ?? '';
    foreach ($list['stems'] as $stem) {
        if ($stem !== '' && strpos($compact, $stem) !== false) {
            return 'Ton message contient un mot interdit. Reste courtois !';
        }
    }
    if (wf_has_link($text) || preg_match('~\b[a-z0-9-]+\s*(\.|\(dot\)|\[dot\])\s*(com|net|org|fr|gg|io|xyz|ru|tv|be|ch|ca)\b~i', $text)) {
        return 'Les liens ne sont pas autorisés dans les commentaires.';
    }
    return null;
}
