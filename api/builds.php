<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

try {
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

    if ($method === 'GET') {
        if (isset($_GET['health'])) {
            wf_db();
            wf_admin_key();
            wf_json(['ok' => true, 'php' => PHP_VERSION, 'sqlite' => true]);
        }
        if (isset($_GET['id'])) {
            handle_get((string) $_GET['id']);
        }
        if (isset($_GET['list'])) {
            handle_list();
        }
        if (isset($_GET['ids'])) {
            handle_ids((string) $_GET['ids']);
        }
        wf_error('Requête invalide.');
    }

    if ($method === 'POST') {
        handle_post();
    }

    header('Allow: GET, POST');
    wf_error('Méthode non autorisée.', 405);
} catch (Throwable $e) {
    error_log('[wf-builds] ' . $e->getMessage());
    wf_error('Erreur serveur, réessaie dans un instant.', 500);
}

function handle_get(string $id): void
{
    if (!wf_valid_id($id)) {
        wf_error('Build introuvable.', 404);
    }
    $db = wf_db();
    $stmt = $db->prepare('SELECT * FROM builds WHERE id = ?');
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) {
        wf_error('Build introuvable.', 404);
    }

    $day = intdiv(time(), 86400);
    $ins = $db->prepare('INSERT OR IGNORE INTO build_views (build_id, visitor, day) VALUES (?, ?, ?)');
    $ins->execute([$id, wf_visitor(), $day]);
    if ($ins->rowCount() > 0) {
        $db->prepare('UPDATE builds SET views = views + 1 WHERE id = ?')->execute([$id]);
        $row['views'] = (int) $row['views'] + 1;
        if (random_int(1, 200) === 1) {
            $db->prepare('DELETE FROM build_views WHERE day < ?')->execute([$day - 2]);
        }
    }

    $liked = $db->prepare('SELECT 1 FROM build_likes WHERE build_id = ? AND visitor = ?');
    $liked->execute([$id, wf_visitor()]);
    wf_json(['ok' => true, 'build' => wf_public_build($row, true) + ['liked' => (bool) $liked->fetchColumn()]]);
}

function handle_list(): void
{
    $class = (string) ($_GET['class'] ?? '');
    $sort = (string) ($_GET['sort'] ?? 'views');
    $limit = max(1, min(50, (int) ($_GET['limit'] ?? 20)));
    $offset = max(0, (int) ($_GET['offset'] ?? 0));

    $where = 'is_public = 1';
    $params = [];
    if ($class !== '') {
        if (!in_array($class, WF_CLASSES, true)) {
            wf_error('Classe inconnue.');
        }
        $where .= ' AND class = ?';
        $params[] = $class;
    }
    $orders = [
        'recent' => 'created_at DESC',
        'likes'  => 'likes DESC, views DESC, created_at DESC',
        'views'  => 'views DESC, likes DESC, created_at DESC',
    ];
    $order = $orders[$sort] ?? $orders['views'];

    $fetch = $limit + 1;
    $stmt = wf_db()->prepare("SELECT * FROM builds WHERE $where ORDER BY $order LIMIT $fetch OFFSET $offset");
    $stmt->execute($params);
    $rows = $stmt->fetchAll();
    $hasMore = count($rows) > $limit;
    $builds = array_map('wf_public_build', array_slice($rows, 0, $limit));

    header('Cache-Control: public, max-age=30');
    http_response_code(200);
    header('Content-Type: application/json; charset=utf-8');
    header('X-Robots-Tag: noindex, nofollow');
    echo json_encode(['ok' => true, 'builds' => $builds, 'hasMore' => $hasMore], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function link_owner(string $id): void
{
    $user = wf_current_user();
    if ($user && !$user['banned']) {
        wf_db()->prepare('UPDATE builds SET owner_user_id = ? WHERE id = ? AND (owner_user_id IS NULL OR owner_user_id = ?)')
            ->execute([$user['id'], $id, $user['id']]);
    }
}

function handle_like($id, bool $like): void
{
    if (!wf_valid_id($id)) {
        wf_error('Build introuvable.', 404);
    }
    $db = wf_db();
    $stmt = $db->prepare('SELECT id FROM builds WHERE id = ?');
    $stmt->execute([$id]);
    if (!$stmt->fetchColumn()) {
        wf_error('Build introuvable.', 404);
    }
    $visitor = wf_visitor();
    $now = time();
    if ($like) {
        $recent = $db->prepare('SELECT COUNT(*) FROM build_likes WHERE visitor = ? AND created_at > ?');
        $recent->execute([$visitor, $now - 3600]);
        if ((int) $recent->fetchColumn() >= 60) {
            wf_error('Doucement ! Réessaie dans un moment.', 429);
        }
        $db->prepare('INSERT OR IGNORE INTO build_likes (build_id, visitor, created_at) VALUES (?, ?, ?)')
           ->execute([$id, $visitor, $now]);
    } else {
        $db->prepare('DELETE FROM build_likes WHERE build_id = ? AND visitor = ?')->execute([$id, $visitor]);
    }
    $db->prepare('UPDATE builds SET likes = (SELECT COUNT(*) FROM build_likes WHERE build_id = ?) WHERE id = ?')
       ->execute([$id, $id]);
    $count = $db->prepare('SELECT likes FROM builds WHERE id = ?');
    $count->execute([$id]);
    wf_json(['ok' => true, 'liked' => $like, 'likes' => (int) $count->fetchColumn()]);
}

function handle_ids(string $ids): void
{
    $list = array_values(array_unique(array_filter(explode(',', $ids), 'wf_valid_id')));
    $list = array_slice($list, 0, 100);
    if (!$list) {
        wf_json(['ok' => true, 'builds' => []]);
    }
    $marks = implode(',', array_fill(0, count($list), '?'));
    $stmt = wf_db()->prepare("SELECT * FROM builds WHERE id IN ($marks) ORDER BY updated_at DESC");
    $stmt->execute($list);
    wf_json(['ok' => true, 'builds' => array_map('wf_public_build', $stmt->fetchAll())]);
}

function handle_post(): void
{
    $raw = file_get_contents('php://input', false, null, 0, 32768);
    $in = json_decode((string) $raw, true);
    if (!is_array($in)) {
        wf_error('Données invalides.');
    }

    if (!empty($in['website'])) {
        wf_error('Données invalides.');
    }

    if (($in['action'] ?? '') === 'like') {
        handle_like($in['id'] ?? null, !empty($in['like']));
    }

    if (($in['action'] ?? '') === 'verify') {
        $id = $in['id'] ?? null;
        $token = $in['token'] ?? null;
        if (!wf_valid_id($id) || !is_string($token) || preg_match('/^[a-f0-9]{32}$/', $token) !== 1) {
            wf_error('Lien de modification invalide.', 403);
        }
        $stmt = wf_db()->prepare('SELECT token_hash FROM builds WHERE id = ?');
        $stmt->execute([$id]);
        $hash = $stmt->fetchColumn();
        if (!$hash || !hash_equals((string) $hash, hash('sha256', $token))) {
            wf_error('Lien de modification invalide.', 403);
        }
        wf_json(['ok' => true]);
    }

    if (($in['action'] ?? '') === 'admin-check') {
        if (!wf_is_admin($in['token'] ?? null)) {
            wf_error('Clé admin refusée.', 403);
        }
        wf_json(['ok' => true]);
    }

    if (($in['action'] ?? '') === 'preview') {
        $body = wf_clean_multiline($in['body'] ?? '', WF_DESC_MAX, WF_DESC_LINES);
        wf_json(['ok' => true, 'html' => wf_render_rich($body)]);
    }

    $db = wf_db();
    $id = $in['id'] ?? null;
    $token = $in['token'] ?? null;

    if (($in['action'] ?? '') === 'delete') {
        $row = owned_build($db, $id, $token);
        $db->prepare('DELETE FROM builds WHERE id = ?')->execute([$row['id']]);
        wf_json(['ok' => true, 'deleted' => $row['id']]);
    }

    $class = (string) ($in['class'] ?? '');
    if (!in_array($class, WF_CLASSES, true)) {
        wf_error('Classe inconnue.');
    }
    $build = $in['build'] ?? '';
    $points = wf_build_points($build);
    if ($points === null) {
        wf_error('Build invalide : place au moins un point (51 maximum).');
    }
    $name = wf_clean_text($in['name'] ?? '', WF_NAME_MAX);
    if (mb_strlen($name) < 3 || !wf_has_letters($name)) {
        wf_error('Donne un nom d\'au moins 3 caractères à ton build.');
    }
    $author = wf_clean_text($in['author'] ?? '', WF_AUTHOR_MAX);
    if ($author !== '' && !wf_has_letters($author, 1)) {
        $author = '';
    }
    if (wf_has_link($name) || wf_has_link($author)) {
        wf_error('Les liens et adresses ne sont pas autorisés dans le nom ou l\'auteur.');
    }
    $description = wf_clean_multiline($in['description'] ?? '', WF_DESC_MAX, WF_DESC_LINES);
    if (preg_match_all('~(https?://|www\.)~i', $description) > 3) {
        wf_error('Trop de liens dans la description (3 maximum).');
    }
    $public = !empty($in['public']) ? 1 : 0;
    $path = wf_clean_path($in['path'] ?? '', $points);
    $now = time();

    if ($id !== null) {
        $row = owned_build($db, $id, $token);
        if ($row['class'] !== $class) {
            wf_error('Ce build appartient à une autre classe.');
        }
        $db->prepare(
            'UPDATE builds SET build = ?, path = ?, points = ?, name = ?, author = ?, description = ?, is_public = ?, updated_at = ? WHERE id = ?'
        )->execute([$build, $path, $points, $name, $author, $description, $public, $now, $row['id']]);
        link_owner($row['id']);

        $stmt = $db->prepare('SELECT * FROM builds WHERE id = ?');
        $stmt->execute([$row['id']]);
        wf_json(['ok' => true, 'updated' => true, 'build' => wf_public_build($stmt->fetch(), true)]);
    }

    $visitor = wf_visitor();
    $count = $db->prepare('SELECT COUNT(*) FROM builds WHERE ip_hash = ? AND created_at > ?');
    $count->execute([$visitor, $now - WF_RATE_WINDOW]);
    if ((int) $count->fetchColumn() >= WF_RATE_LIMIT) {
        wf_error('Trop de sauvegardes en peu de temps, réessaie dans un moment.', 429);
    }

    $newToken = bin2hex(random_bytes(16));
    $insert = $db->prepare(
        'INSERT INTO builds (id, class, build, path, points, name, author, description, is_public, token_hash, ip_hash, views, created_at, updated_at)
         VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0, ?, ?)'
    );
    for ($attempt = 0; ; $attempt++) {
        $newId = wf_new_id();
        try {
            $insert->execute([
                $newId, $class, $build, $path, $points, $name, $author, $description, $public,
                hash('sha256', $newToken), $visitor, $now, $now,
            ]);
            break;
        } catch (PDOException $e) {
            if ($attempt >= 4) {
                throw $e;
            }
        }
    }

    link_owner($newId);
    $stmt = $db->prepare('SELECT * FROM builds WHERE id = ?');
    $stmt->execute([$newId]);
    wf_json(['ok' => true, 'created' => true, 'token' => $newToken, 'build' => wf_public_build($stmt->fetch(), true)], 201);
}

function owned_build(PDO $db, $id, $token): array
{
    if (!wf_valid_id($id) || !is_string($token) || preg_match('/^[a-f0-9]{32}([a-f0-9]{8})?$/', $token) !== 1) {
        wf_error('Build introuvable.', 404);
    }
    $stmt = $db->prepare('SELECT * FROM builds WHERE id = ?');
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) {
        wf_error('Build introuvable.', 404);
    }
    if (!hash_equals($row['token_hash'], hash('sha256', $token)) && !wf_is_admin($token)) {
        wf_error('Tu ne peux modifier que tes propres builds.', 403);
    }
    return $row;
}
