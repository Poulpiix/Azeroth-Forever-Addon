<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

/*
 * Azeroth Forever : annuaire de guildes (Phase 5).
 * Schéma et règles : packages/schema/GUILDS.md.
 *
 * GET  ?list=1        fiches publiques (status = visible)
 * GET  ?id=<id>        une fiche publique
 * POST action=mine     la fiche du compte connecté, quel que soit son statut
 * POST action=save     créer / mettre à jour sa fiche (upsert, 1 par compte)
 * POST action=delete   supprimer sa fiche
 * POST action=report   signaler une fiche
 * POST action=queue    (admin) fiches signalées / masquées
 * POST action=moderate (admin) do: show | hide | delete
 */

try {
    $method = $_SERVER['REQUEST_METHOD'] ?? 'GET';

    if ($method === 'GET') {
        if (isset($_GET['id'])) {
            handle_get((string) $_GET['id']);
        }
        if (isset($_GET['list'])) {
            handle_list();
        }
        wf_error('Requête invalide.');
    }

    if ($method === 'POST') {
        wf_check_origin();
        $in = json_decode((string) file_get_contents('php://input', false, null, 0, 16384), true);
        if (!is_array($in)) {
            wf_error('Données invalides.');
        }
        $user = wf_current_user();
        switch ($in['action'] ?? '') {
            case 'mine':     handle_mine(need_user($user)); break;
            case 'save':     handle_save($in, need_user($user)); break;
            case 'delete':   handle_delete(need_user($user)); break;
            case 'report':   handle_report($in, need_user($user)); break;
            case 'queue':    handle_queue($in, $user); break;
            case 'moderate': handle_moderate($in, $user); break;
        }
        wf_error('Action inconnue.');
    }

    header('Allow: GET, POST');
    wf_error('Méthode non autorisée.', 405);
} catch (Throwable $e) {
    error_log('[wf-guilds] ' . $e->getMessage());
    wf_error('Erreur serveur, réessaie dans un instant.', 500);
}

function need_user(?array $user): array
{
    if (!$user) {
        wf_error('Connecte-toi avec Twitch pour faire ça.', 401);
    }
    if ($user['banned']) {
        wf_error('Ton compte ne peut plus publier de fiche de guilde.', 403);
    }
    return $user;
}

function handle_get(string $id): void
{
    if (!wf_valid_id($id)) {
        wf_error('Guilde introuvable.', 404);
    }
    $stmt = wf_db()->prepare('SELECT * FROM guilds WHERE id = ? AND status = \'visible\'');
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) {
        wf_error('Guilde introuvable.', 404);
    }
    wf_json(['ok' => true, 'guild' => wf_public_guild($row)]);
}

function handle_list(): void
{
    $stmt = wf_db()->query("SELECT * FROM guilds WHERE status = 'visible' ORDER BY updated_at DESC LIMIT 500");
    $guilds = array_map('wf_public_guild', $stmt->fetchAll());
    header('Cache-Control: public, max-age=30');
    http_response_code(200);
    header('Content-Type: application/json; charset=utf-8');
    header('X-Robots-Tag: noindex, nofollow');
    echo json_encode(['ok' => true, 'guilds' => $guilds], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES);
    exit;
}

function handle_mine(array $user): void
{
    $stmt = wf_db()->prepare('SELECT * FROM guilds WHERE owner_user_id = ?');
    $stmt->execute([$user['id']]);
    $row = $stmt->fetch();
    wf_json(['ok' => true, 'guild' => $row ? wf_public_guild($row, true) : null]);
}

/** Slugs d'instances connus (data/instances/_index.json), pour valider `progression`. */
function known_instance_slugs(): array
{
    static $slugs = null;
    if ($slugs !== null) {
        return $slugs;
    }
    $slugs = [];
    $file = dirname(__DIR__) . '/data/instances/_index.json';
    if (is_file($file)) {
        $json = json_decode((string) file_get_contents($file), true);
        foreach ((array) ($json['instances'] ?? []) as $inst) {
            if (isset($inst['slug']) && is_string($inst['slug'])) {
                $slugs[] = $inst['slug'];
            }
        }
    }
    return $slugs;
}

function clean_closed(string $field, $label, array $allowed): string
{
    $v = is_string($label) ? $label : '';
    if (!in_array($v, $allowed, true)) {
        wf_error("Valeur invalide pour « $field ».");
    }
    return $v;
}

/** Sous-ensemble d'une liste fermée, dédupliqué, dans l'ordre de la liste. */
function clean_closed_set($values, array $allowed): array
{
    if (!is_array($values)) {
        return [];
    }
    $set = array_values(array_unique(array_filter($values, static fn($v) => is_string($v) && in_array($v, $allowed, true))));
    return array_values(array_intersect($allowed, $set));
}

function clean_officers($value): string
{
    if (!is_string($value)) {
        return '';
    }
    $parts = preg_split('/[,\n]+/u', $value) ?: [];
    $out = [];
    foreach ($parts as $p) {
        $p = wf_clean_text($p, WF_GUILD_OFFICER_MAX);
        if ($p !== '') {
            $out[] = $p;
        }
        if (count($out) >= WF_GUILD_OFFICERS_LIMIT) {
            break;
        }
    }
    return implode(', ', $out);
}

function handle_save(array $in, array $user): void
{
    if (!empty($in['website'])) {
        wf_error('Données invalides.');
    }

    $name = wf_clean_text($in['name'] ?? '', WF_GUILD_NAME_MAX);
    if (mb_strlen($name) < 3 || !wf_has_letters($name)) {
        wf_error('Donne un nom de guilde d\'au moins 3 caractères.');
    }

    $faction = clean_closed('faction', $in['faction'] ?? '', WF_GUILD_FACTIONS);
    $region = clean_closed('région', $in['region'] ?? '', WF_GUILD_REGIONS);
    $language = clean_closed('langue', $in['language'] ?? '', WF_GUILD_LANGS);
    $size = clean_closed('effectif', $in['size'] ?? '', WF_GUILD_SIZES);
    $recruitment = clean_closed('recrutement', $in['recruitment'] ?? '', WF_GUILD_RECRUIT);

    $officers = clean_officers($in['officers'] ?? '');
    $schedule = wf_clean_text($in['schedule'] ?? '', WF_GUILD_SCHEDULE_MAX);
    $description = wf_clean_multiline($in['description'] ?? '', WF_GUILD_DESC_MAX, WF_GUILD_DESC_LINES);

    $roles = clean_closed_set($in['roles'] ?? [], array_merge(WF_CLASSES, WF_GUILD_ROLES));
    $vibes = clean_closed_set($in['vibes'] ?? [], WF_GUILD_VIBES);
    $known = known_instance_slugs();
    $progression = is_array($in['progression'] ?? null)
        ? array_values(array_intersect($known, array_filter($in['progression'], 'is_string')))
        : [];

    $battletag = is_string($in['battletag'] ?? null) ? trim($in['battletag']) : '';
    if (!wf_valid_battletag($battletag)) {
        wf_error('BattleTag invalide : format attendu Nom#1234.');
    }

    foreach ([$name, $officers, $schedule, $description] as $text) {
        $problem = wf_guild_forbidden($text);
        if ($problem) {
            wf_error($problem);
        }
    }

    $db = wf_db();
    $now = time();
    $stmt = $db->prepare('SELECT id FROM guilds WHERE owner_user_id = ?');
    $stmt->execute([$user['id']]);
    $existingId = $stmt->fetchColumn();

    $cols = [
        'name' => $name, 'faction' => $faction, 'region' => $region, 'language' => $language,
        'size_range' => $size, 'officers' => $officers, 'recruitment' => $recruitment,
        'roles_wanted' => json_encode($roles, JSON_UNESCAPED_UNICODE),
        'vibe_tags' => json_encode($vibes, JSON_UNESCAPED_UNICODE),
        'schedule' => $schedule,
        'progression' => json_encode($progression, JSON_UNESCAPED_UNICODE),
        'description' => $description, 'battletag' => $battletag,
    ];

    if ($existingId) {
        $set = implode(', ', array_map(static fn($c) => "$c = ?", array_keys($cols)));
        $db->prepare("UPDATE guilds SET $set, status = 'visible', reports = 0, updated_at = ? WHERE id = ?")
            ->execute([...array_values($cols), $now, $existingId]);
        $id = $existingId;
    } else {
        $insertCols = array_merge(['id', 'owner_user_id'], array_keys($cols), ['status', 'reports', 'created_at', 'updated_at']);
        $marks = implode(', ', array_fill(0, count($insertCols), '?'));
        $insert = $db->prepare('INSERT INTO guilds (' . implode(', ', $insertCols) . ") VALUES ($marks)");
        for ($attempt = 0; ; $attempt++) {
            $id = wf_new_id();
            try {
                $insert->execute(array_merge([$id, $user['id']], array_values($cols), ['visible', 0, $now, $now]));
                break;
            } catch (PDOException $e) {
                if ($attempt >= 4) {
                    throw $e;
                }
            }
        }
    }

    $stmt = $db->prepare('SELECT * FROM guilds WHERE id = ?');
    $stmt->execute([$id]);
    wf_json(['ok' => true, 'guild' => wf_public_guild($stmt->fetch(), true)], $existingId ? 200 : 201);
}

function handle_delete(array $user): void
{
    wf_db()->prepare('DELETE FROM guilds WHERE owner_user_id = ?')->execute([$user['id']]);
    wf_json(['ok' => true]);
}

function load_guild($id): array
{
    if (!wf_valid_id($id)) {
        wf_error('Guilde introuvable.', 404);
    }
    $stmt = wf_db()->prepare('SELECT * FROM guilds WHERE id = ?');
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    if (!$row) {
        wf_error('Guilde introuvable.', 404);
    }
    return $row;
}

function handle_report(array $in, array $user): void
{
    $g = load_guild($in['id'] ?? null);
    if ($g['owner_user_id'] === $user['id']) {
        wf_error('Tu ne peux pas signaler ta propre fiche.');
    }
    $reason = wf_clean_text($in['reason'] ?? '', 120);
    $db = wf_db();
    $db->prepare('INSERT OR IGNORE INTO guild_reports (guild_id, user_id, reason, created_at) VALUES (?, ?, ?, ?)')
        ->execute([$g['id'], $user['id'], $reason, time()]);
    $db->prepare('UPDATE guilds SET reports = (SELECT COUNT(*) FROM guild_reports WHERE guild_id = ?) WHERE id = ?')
        ->execute([$g['id'], $g['id']]);
    $threshold = max(1, (int) wf_config()['report_threshold']);
    $db->prepare("UPDATE guilds SET status = 'reported' WHERE id = ? AND status = 'visible' AND reports >= ?")
        ->execute([$g['id'], $threshold]);
    wf_json(['ok' => true]);
}

function handle_queue(array $in, ?array $user): void
{
    if (!wf_is_moderator_admin($user, $in['admin_key'] ?? null)) {
        wf_error('Réservé aux administrateurs.', 403);
    }
    $stmt = wf_db()->query(
        "SELECT g.*, u.display_name, u.avatar, u.login, u.banned,
                (SELECT GROUP_CONCAT(NULLIF(reason, ''), ' · ') FROM guild_reports r WHERE r.guild_id = g.id) AS reasons
           FROM guilds g JOIN users u ON u.id = g.owner_user_id
          WHERE g.status != 'visible' OR g.reports > 0
          ORDER BY (g.status = 'reported') DESC, g.reports DESC, g.updated_at DESC LIMIT 200"
    );
    $items = [];
    foreach ($stmt->fetchAll() as $r) {
        $o = wf_public_guild($r, true);
        $o['author'] = ['name' => $r['display_name'], 'login' => $r['login'], 'avatar' => $r['avatar'], 'banned' => (bool) $r['banned']];
        $o['reasons'] = (string) ($r['reasons'] ?? '');
        $items[] = $o;
    }
    wf_json(['ok' => true, 'items' => $items]);
}

function handle_moderate(array $in, ?array $user): void
{
    if (!wf_is_moderator_admin($user, $in['admin_key'] ?? null)) {
        wf_error('Réservé aux administrateurs.', 403);
    }
    $g = load_guild($in['id'] ?? null);
    $db = wf_db();
    switch ($in['do'] ?? '') {
        case 'hide':
            $db->prepare("UPDATE guilds SET status = 'hidden' WHERE id = ?")->execute([$g['id']]);
            break;
        case 'show':
            $db->prepare('DELETE FROM guild_reports WHERE guild_id = ?')->execute([$g['id']]);
            $db->prepare("UPDATE guilds SET status = 'visible', reports = 0 WHERE id = ?")->execute([$g['id']]);
            break;
        case 'delete':
            $db->prepare('DELETE FROM guilds WHERE id = ?')->execute([$g['id']]);
            break;
        default:
            wf_error('Action inconnue.');
    }
    wf_json(['ok' => true]);
}
