<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

function back(string $path, string $error = ''): void
{
    if ($error !== '') {
        $path .= (str_contains($path, '#') ? '&' : '#') . 'connexion=' . rawurlencode($error);
    }
    header('Cache-Control: no-store');
    header('Location: ' . $path, true, 302);
    exit;
}

try {
    $cookie = (string) ($_COOKIE['wf_oauth'] ?? '');
    setcookie('wf_oauth', '', ['expires' => time() - 3600, 'path' => '/api/', 'secure' => true, 'httponly' => true, 'samesite' => 'Lax']);
    $parts = explode('|', $cookie);
    if (count($parts) !== 4) {
        back('/', 'expiree');
    }
    [$state, $exp, $ret64, $sig] = $parts;
    $return = base64_decode($ret64, true) ?: '/';
    if (!hash_equals(hash_hmac('sha256', "$state|$exp|$ret64", wf_secret()), $sig) || (int) $exp < time()) {
        back('/', 'expiree');
    }
    if (!hash_equals($state, (string) ($_GET['state'] ?? ''))) {
        back($return, 'expiree');
    }
    if (isset($_GET['error']) || empty($_GET['code'])) {
        back($return, 'annulee');
    }

    $cfg = wf_config();
    [$code, $body] = wf_http('POST', 'https://id.twitch.tv/oauth2/token', ['Content-Type: application/x-www-form-urlencoded'], http_build_query([
        'client_id'     => $cfg['twitch_client_id'],
        'client_secret' => $cfg['twitch_client_secret'],
        'code'          => (string) $_GET['code'],
        'grant_type'    => 'authorization_code',
        'redirect_uri'  => wf_site_url() . '/api/twitch-callback.php',
    ]));
    $tok = json_decode($body, true);
    if ($code !== 200 || empty($tok['access_token'])) {
        error_log('[wf-twitch] token ' . $code . ' ' . substr($body, 0, 200));
        back($return, 'erreur');
    }

    [$code, $body] = wf_http('GET', 'https://api.twitch.tv/helix/users', [
        'Authorization: Bearer ' . $tok['access_token'],
        'Client-Id: ' . $cfg['twitch_client_id'],
    ]);
    $data = json_decode($body, true);
    $tw = $data['data'][0] ?? null;
    wf_http('POST', 'https://id.twitch.tv/oauth2/revoke', ['Content-Type: application/x-www-form-urlencoded'],
        http_build_query(['client_id' => $cfg['twitch_client_id'], 'token' => $tok['access_token']]));
    if ($code !== 200 || !$tw || empty($tw['id']) || !preg_match('/^\d{1,20}$/', (string) $tw['id'])) {
        back($return, 'erreur');
    }

    $avatar = (string) ($tw['profile_image_url'] ?? '');
    if (!preg_match('#^https://static-cdn\.jtvnw\.net/[\w./-]+$#', $avatar)) {
        $avatar = '';
    }
    $login = preg_replace('/[^a-z0-9_]/', '', strtolower((string) ($tw['login'] ?? ''))) ?: 'inconnu';
    $display = wf_clean_text((string) ($tw['display_name'] ?? $login), 40) ?: $login;
    $twCreated = strtotime((string) ($tw['created_at'] ?? '')) ?: 0;
    $now = time();

    $db = wf_db();
    $db->prepare(
        'INSERT INTO users (id, login, display_name, avatar, twitch_created, banned, created_at, last_seen)
         VALUES (?, ?, ?, ?, ?, 0, ?, ?)
         ON CONFLICT(id) DO UPDATE SET login = excluded.login, display_name = excluded.display_name,
             avatar = excluded.avatar, twitch_created = excluded.twitch_created, last_seen = excluded.last_seen'
    )->execute([$tw['id'], $login, $display, $avatar, $twCreated, $now, $now]);

    wf_session_start((string) $tw['id']);
    back($return);
} catch (Throwable $e) {
    error_log('[wf-twitch] ' . $e->getMessage());
    back('/', 'erreur');
}
