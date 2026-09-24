<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

try {
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

    if ($method === 'GET' && isset($_GET['me'])) {
        wf_json(['ok' => true, 'user' => wf_public_user(wf_current_user()), 'enabled' => twitch_enabled()]);
    }

    if ($method === 'GET' && isset($_GET['login'])) {
        if (!twitch_enabled()) {
            wf_error('La connexion Twitch n\'est pas encore configurée.', 503);
        }
        $return = safe_return((string) ($_GET['return'] ?? '/'));
        $state = bin2hex(random_bytes(16));
        $payload = $state . '|' . (time() + 600) . '|' . base64_encode($return);
        $sig = hash_hmac('sha256', $payload, wf_secret());
        setcookie('wf_oauth', $payload . '|' . $sig, [
            'expires' => time() + 600, 'path' => '/api/', 'secure' => true, 'httponly' => true, 'samesite' => 'Lax',
        ]);
        $url = 'https://id.twitch.tv/oauth2/authorize?' . http_build_query([
            'client_id'     => wf_config()['twitch_client_id'],
            'redirect_uri'  => wf_site_url() . '/api/twitch-callback.php',
            'response_type' => 'code',
            'scope'         => '',
            'state'         => $state,
        ]);
        header('Cache-Control: no-store');
        header('Location: ' . $url, true, 302);
        exit;
    }

    if ($method === 'POST') {
        wf_check_origin();
        $in = json_decode((string) file_get_contents('php://input', false, null, 0, 4096), true);
        $action = is_array($in) ? ($in['action'] ?? '') : '';
        if ($action === 'logout') {
            wf_session_end();
            wf_json(['ok' => true]);
        }
        if ($action === 'forget') {
            $user = wf_current_user();
            if (!$user) {
                wf_error('Tu n\'es pas connecté.', 401);
            }
            forget_user($user['id']);
            wf_session_end();
            wf_json(['ok' => true]);
        }
        wf_error('Action inconnue.');
    }

    wf_error('Requête invalide.');
} catch (Throwable $e) {
    error_log('[wf-auth] ' . $e->getMessage());
    wf_error('Erreur serveur, réessaie dans un instant.', 500);
}

function twitch_enabled(): bool
{
    $c = wf_config();
    return $c['twitch_client_id'] !== '' && $c['twitch_client_secret'] !== '';
}

function safe_return(string $return): string
{
    if ($return === '' || $return[0] !== '/' || str_starts_with($return, '//') || str_contains($return, '\\')
        || preg_match('/[\x00-\x1F]/', $return)) {
        return '/';
    }
    return substr($return, 0, 500);
}

function forget_user(string $userId): void
{
    $db = wf_db();
    $db->beginTransaction();
    $builds = $db->prepare("SELECT DISTINCT build_id FROM build_comments WHERE user_id = ?");
    $builds->execute([$userId]);
    $ids = $builds->fetchAll(PDO::FETCH_COLUMN);
    $db->prepare('UPDATE build_comments SET score = score - COALESCE((SELECT value FROM comment_votes v WHERE v.comment_id = build_comments.id AND v.user_id = ?), 0)')
       ->execute([$userId]);
    $db->prepare('DELETE FROM users WHERE id = ?')->execute([$userId]);
    $db->prepare('UPDATE builds SET owner_user_id = NULL WHERE owner_user_id = ?')->execute([$userId]);
    foreach ($ids as $bid) {
        $db->prepare("UPDATE builds SET comment_count = (SELECT COUNT(*) FROM build_comments WHERE build_id = ? AND status = 'visible') WHERE id = ?")
           ->execute([$bid, $bid]);
    }
    $db->commit();
}
