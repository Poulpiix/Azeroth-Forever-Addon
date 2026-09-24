<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

const WF_COMMENT_MAX = 1500;
const WF_COMMENT_LINES = 30;

try {
    if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
        header('Allow: POST');
        wf_error('Méthode non autorisée.', 405);
    }
    wf_check_origin();
    $in = json_decode((string) file_get_contents('php://input', false, null, 0, 16384), true);
    if (!is_array($in)) {
        wf_error('Données invalides.');
    }
    $user = wf_current_user();
    switch ($in['action'] ?? '') {
        case 'list':     list_comments($in, $user); break;
        case 'create':   create_comment($in, need_user($user)); break;
        case 'delete':   delete_own($in, need_user($user)); break;
        case 'vote':     vote($in, need_user($user)); break;
        case 'report':   report($in, need_user($user)); break;
        case 'moderate': moderate($in, $user); break;
        case 'toggle':   toggle($in, $user); break;
        case 'queue':    queue($in, $user); break;
        case 'ban':      ban($in, $user); break;
    }
    wf_error('Action inconnue.');
} catch (Throwable $e) {
    error_log('[wf-comments] ' . $e->getMessage());
    wf_error('Erreur serveur, réessaie dans un instant.', 500);
}


function need_user(?array $user): array
{
    if (!$user) {
        wf_error('Connecte-toi avec Twitch pour faire ça.', 401);
    }
    if ($user['banned']) {
        wf_error('Ton compte ne peut plus participer aux commentaires.', 403);
    }
    return $user;
}

function load_build($id): array
{
    if (!wf_valid_id($id)) {
        wf_error('Build introuvable.', 404);
    }
    $stmt = wf_db()->prepare('SELECT id, name, class, is_public, owner_user_id, comments_enabled, token_hash FROM builds WHERE id = ?');
    $stmt->execute([$id]);
    $b = $stmt->fetch();
    if (!$b) {
        wf_error('Build introuvable.', 404);
    }
    return $b;
}

function load_comment($id): array
{
    if (!is_string($id) || !preg_match('/^[A-Za-z0-9]{10}$/', $id)) {
        wf_error('Commentaire introuvable.', 404);
    }
    $stmt = wf_db()->prepare('SELECT * FROM build_comments WHERE id = ?');
    $stmt->execute([$id]);
    $c = $stmt->fetch();
    if (!$c) {
        wf_error('Commentaire introuvable.', 404);
    }
    return $c;
}

function can_moderate(array $build, ?array $user, array $in): bool
{
    if (wf_is_moderator_admin($user, $in['admin_key'] ?? null)) {
        return true;
    }
    if ($user && $build['owner_user_id'] && $build['owner_user_id'] === $user['id']) {
        return true;
    }
    $tok = $in['owner_token'] ?? null;
    return is_string($tok) && preg_match('/^[a-f0-9]{32}$/', $tok) && hash_equals($build['token_hash'], hash('sha256', $tok));
}

function recount(string $buildId): void
{
    wf_db()->prepare("UPDATE builds SET comment_count = (SELECT COUNT(*) FROM build_comments WHERE build_id = ? AND status = 'visible') WHERE id = ?")
        ->execute([$buildId, $buildId]);
}

function comment_out(array $r, ?array $user, bool $mod): array
{
    $admins = wf_config()['admins'];
    return [
        'id'       => $r['id'],
        'author'   => [
            'name'         => $r['display_name'],
            'avatar'       => $r['avatar'],
            'build_author' => $r['owner_user_id'] !== null && $r['owner_user_id'] === $r['user_id'],
            'admin'        => in_array(strtolower($r['login']), $admins, true),
            'id'           => $mod ? $r['user_id'] : null,
            'login'        => $mod ? $r['login'] : null,
        ],
        'html'     => wf_render_rich($r['body']),
        'score'    => (int) $r['score'],
        'my_vote'  => (int) ($r['my_vote'] ?? 0),
        'reported' => (bool) ($r['my_report'] ?? false),
        'status'   => $r['status'],
        'reports'  => $mod ? (int) $r['reports'] : null,
        'mine'     => $user && $user['id'] === $r['user_id'],
        'created'  => (int) $r['created_at'],
    ];
}


function list_comments(array $in, ?array $user): void
{
    $build = load_build($in['build'] ?? null);
    $mod = can_moderate($build, $user, $in);
    $uid = $user['id'] ?? '';
    $order = ($in['sort'] ?? '') === 'recent' ? 'c.created_at DESC' : 'c.score DESC, c.created_at ASC';
    $stmt = wf_db()->prepare(
        "SELECT c.*, u.display_name, u.avatar, u.login, b.owner_user_id,
                (SELECT value FROM comment_votes v WHERE v.comment_id = c.id AND v.user_id = ?) AS my_vote,
                (SELECT 1 FROM comment_reports r WHERE r.comment_id = c.id AND r.user_id = ?) AS my_report
           FROM build_comments c
           JOIN users u ON u.id = c.user_id
           JOIN builds b ON b.id = c.build_id
          WHERE c.build_id = ? AND (c.status = 'visible' OR ? = 1 OR c.user_id = ?)
          ORDER BY $order LIMIT 300"
    );
    $stmt->execute([$uid, $uid, $build['id'], $mod ? 1 : 0, $uid]);
    $out = array_map(static fn($r) => comment_out($r, $user, $mod), $stmt->fetchAll());
    $cfg = wf_config();
    wf_json([
        'ok'       => true,
        'comments' => $out,
        'build'    => [
            'public'           => (bool) $build['is_public'],
            'comments_enabled' => (bool) $build['comments_enabled'],
            'can_moderate'     => $mod,
        ],
        'me'       => wf_public_user($user),
        'rules'    => ['min_account_days' => (int) $cfg['min_account_days'], 'report_threshold' => (int) $cfg['report_threshold']],
    ]);
}

function create_comment(array $in, array $user): void
{
    $build = load_build($in['build'] ?? null);
    if (!$build['is_public']) {
        wf_error('Les commentaires sont réservés aux builds publics.');
    }
    if (!$build['comments_enabled']) {
        wf_error('L\'auteur a désactivé les commentaires sur ce build.');
    }
    $days = (int) wf_config()['min_account_days'];
    if ($days > 0 && ((int) $user['twitch_created'] === 0 || time() - (int) $user['twitch_created'] < $days * 86400)) {
        wf_error("Ton compte Twitch doit avoir au moins $days jours pour commenter.", 403);
    }

    $body = wf_clean_multiline($in['body'] ?? '', WF_COMMENT_MAX, WF_COMMENT_LINES);
    if (mb_strlen($body) < 2 || !wf_has_letters($body)) {
        wf_error('Ton commentaire est vide.');
    }
    $problem = wf_moderation_problem($body);
    if ($problem) {
        wf_error($problem);
    }

    $db = wf_db();
    $now = time();
    $q = $db->prepare('SELECT COUNT(*) AS n, MAX(created_at) AS last FROM build_comments WHERE user_id = ? AND created_at > ?');
    $q->execute([$user['id'], $now - 86400]);
    $day = $q->fetch();
    if ((int) $day['n'] >= 50) {
        wf_error('Limite de commentaires atteinte pour aujourd\'hui.', 429);
    }
    if ($day['last'] !== null && $now - (int) $day['last'] < 20) {
        wf_error('Patiente quelques secondes avant de commenter à nouveau.', 429);
    }
    $q->execute([$user['id'], $now - 600]);
    if ((int) $q->fetch()['n'] >= 10) {
        wf_error('Trop de commentaires en peu de temps, réessaie dans quelques minutes.', 429);
    }
    $dup = $db->prepare('SELECT 1 FROM build_comments WHERE user_id = ? AND body = ? AND created_at > ?');
    $dup->execute([$user['id'], $body, $now - 86400]);
    if ($dup->fetchColumn()) {
        wf_error('Tu as déjà posté ce commentaire.');
    }

    $id = wf_new_id() . substr(wf_new_id(), 0, 2);
    $db->prepare('INSERT INTO build_comments (id, build_id, user_id, body, status, score, reports, created_at) VALUES (?, ?, ?, ?, \'visible\', 0, 0, ?)')
       ->execute([$id, $build['id'], $user['id'], $body, $now]);
    recount($build['id']);
    $db->prepare('UPDATE users SET last_seen = ? WHERE id = ?')->execute([$now, $user['id']]);

    $stmt = $db->prepare('SELECT c.*, u.display_name, u.avatar, u.login, b.owner_user_id FROM build_comments c JOIN users u ON u.id = c.user_id JOIN builds b ON b.id = c.build_id WHERE c.id = ?');
    $stmt->execute([$id]);
    wf_json(['ok' => true, 'comment' => comment_out($stmt->fetch(), $user, false)], 201);
}

function delete_own(array $in, array $user): void
{
    $c = load_comment($in['id'] ?? null);
    if ($c['user_id'] !== $user['id']) {
        wf_error('Tu ne peux supprimer que tes propres commentaires.', 403);
    }
    wf_db()->prepare('DELETE FROM build_comments WHERE id = ?')->execute([$c['id']]);
    recount($c['build_id']);
    wf_json(['ok' => true]);
}

function vote(array $in, array $user): void
{
    $c = load_comment($in['id'] ?? null);
    if ($c['user_id'] === $user['id']) {
        wf_error('Tu ne peux pas voter pour ton propre commentaire.');
    }
    $value = (int) ($in['value'] ?? 0);
    $value = max(-1, min(1, $value));
    $db = wf_db();
    if ($value === 0) {
        $db->prepare('DELETE FROM comment_votes WHERE comment_id = ? AND user_id = ?')->execute([$c['id'], $user['id']]);
    } else {
        $db->prepare('INSERT INTO comment_votes (comment_id, user_id, value) VALUES (?, ?, ?)
                      ON CONFLICT(comment_id, user_id) DO UPDATE SET value = excluded.value')
           ->execute([$c['id'], $user['id'], $value]);
    }
    $db->prepare('UPDATE build_comments SET score = (SELECT COALESCE(SUM(value), 0) FROM comment_votes WHERE comment_id = ?) WHERE id = ?')
       ->execute([$c['id'], $c['id']]);
    $s = $db->prepare('SELECT score FROM build_comments WHERE id = ?');
    $s->execute([$c['id']]);
    wf_json(['ok' => true, 'score' => (int) $s->fetchColumn(), 'my_vote' => $value]);
}

function report(array $in, array $user): void
{
    $c = load_comment($in['id'] ?? null);
    if ($c['user_id'] === $user['id']) {
        wf_error('Tu ne peux pas signaler ton propre commentaire.');
    }
    $reason = wf_clean_text($in['reason'] ?? '', 120);
    $db = wf_db();
    $db->prepare('INSERT OR IGNORE INTO comment_reports (comment_id, user_id, reason, created_at) VALUES (?, ?, ?, ?)')
       ->execute([$c['id'], $user['id'], $reason, time()]);
    $db->prepare('UPDATE build_comments SET reports = (SELECT COUNT(*) FROM comment_reports WHERE comment_id = ?) WHERE id = ?')
       ->execute([$c['id'], $c['id']]);
    $threshold = max(1, (int) wf_config()['report_threshold']);
    $db->prepare("UPDATE build_comments SET status = 'reported' WHERE id = ? AND status = 'visible' AND reports >= ?")
       ->execute([$c['id'], $threshold]);
    recount($c['build_id']);
    wf_json(['ok' => true]);
}

function moderate(array $in, ?array $user): void
{
    $c = load_comment($in['id'] ?? null);
    $build = load_build($c['build_id']);
    if (!can_moderate($build, $user, $in)) {
        wf_error('Seul l\'auteur du build ou un administrateur peut faire ça.', 403);
    }
    $admin = wf_is_moderator_admin($user, $in['admin_key'] ?? null);
    $db = wf_db();
    switch ($in['do'] ?? '') {
        case 'hide':
            $db->prepare("UPDATE build_comments SET status = 'hidden' WHERE id = ?")->execute([$c['id']]);
            break;
        case 'show':
            if ($c['status'] === 'reported' && !$admin) {
                wf_error('Ce commentaire a été signalé par la communauté : seul un administrateur peut le rétablir.', 403);
            }
            $db->prepare('DELETE FROM comment_reports WHERE comment_id = ?')->execute([$c['id']]);
            $db->prepare("UPDATE build_comments SET status = 'visible', reports = 0 WHERE id = ?")->execute([$c['id']]);
            break;
        case 'delete':
            $db->prepare('DELETE FROM build_comments WHERE id = ?')->execute([$c['id']]);
            break;
        default:
            wf_error('Action inconnue.');
    }
    recount($c['build_id']);
    wf_json(['ok' => true]);
}

function toggle(array $in, ?array $user): void
{
    $build = load_build($in['build'] ?? null);
    if (!can_moderate($build, $user, $in)) {
        wf_error('Seul l\'auteur du build ou un administrateur peut faire ça.', 403);
    }
    $on = !empty($in['enabled']) ? 1 : 0;
    wf_db()->prepare('UPDATE builds SET comments_enabled = ? WHERE id = ?')->execute([$on, $build['id']]);
    wf_json(['ok' => true, 'comments_enabled' => (bool) $on]);
}

function queue(array $in, ?array $user): void
{
    if (!wf_is_moderator_admin($user, $in['admin_key'] ?? null)) {
        wf_error('Réservé aux administrateurs.', 403);
    }
    $db = wf_db();
    $stmt = $db->query(
        "SELECT c.*, u.display_name, u.avatar, u.login, u.banned, b.owner_user_id, b.name AS build_name, b.class AS build_class, b.build AS build_code,
                (SELECT GROUP_CONCAT(NULLIF(reason, ''), ' · ') FROM comment_reports r WHERE r.comment_id = c.id) AS reasons
           FROM build_comments c JOIN users u ON u.id = c.user_id JOIN builds b ON b.id = c.build_id
          WHERE c.status != 'visible' OR c.reports > 0
          ORDER BY (c.status = 'reported') DESC, c.reports DESC, c.created_at DESC LIMIT 200"
    );
    $items = [];
    foreach ($stmt->fetchAll() as $r) {
        $o = comment_out($r, $user, true);
        $o['build'] = ['id' => $r['build_id'], 'name' => $r['build_name'], 'class' => $r['build_class'], 'code' => $r['build_code']];
        $o['reasons'] = (string) ($r['reasons'] ?? '');
        $o['author']['banned'] = (bool) $r['banned'];
        $items[] = $o;
    }
    $banned = $db->query('SELECT id, login, display_name, avatar FROM users WHERE banned = 1 ORDER BY display_name')->fetchAll();
    $stats = $db->query("SELECT COUNT(*) AS total, SUM(status = 'reported') AS reported FROM build_comments")->fetch();
    wf_json(['ok' => true, 'items' => $items, 'banned' => $banned, 'stats' => [
        'total' => (int) $stats['total'], 'reported' => (int) $stats['reported'],
    ]]);
}

function ban(array $in, ?array $user): void
{
    if (!wf_is_moderator_admin($user, $in['admin_key'] ?? null)) {
        wf_error('Réservé aux administrateurs.', 403);
    }
    $uid = $in['user_id'] ?? '';
    if (!is_string($uid) || !preg_match('/^\d{1,20}$/', $uid)) {
        wf_error('Utilisateur introuvable.', 404);
    }
    $db = wf_db();
    $on = !empty($in['ban']);
    $db->prepare('UPDATE users SET banned = ? WHERE id = ?')->execute([$on ? 1 : 0, $uid]);
    if ($on) {
        $b = $db->prepare('SELECT DISTINCT build_id FROM build_comments WHERE user_id = ?');
        $b->execute([$uid]);
        $builds = $b->fetchAll(PDO::FETCH_COLUMN);
        $db->prepare('DELETE FROM build_comments WHERE user_id = ?')->execute([$uid]);
        $db->prepare('DELETE FROM sessions WHERE user_id = ?')->execute([$uid]);
        $db->prepare('DELETE FROM guilds WHERE owner_user_id = ?')->execute([$uid]);
        foreach ($builds as $bid) {
            recount($bid);
        }
    }
    wf_json(['ok' => true, 'banned' => $on]);
}
