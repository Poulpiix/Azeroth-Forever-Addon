<?php
declare(strict_types=1);

require __DIR__ . '/_lib.php';

$id = (string) ($_GET['id'] ?? '');
$target = '/';

try {
    if (wf_valid_id($id)) {
        $stmt = wf_db()->prepare('SELECT class, build, path FROM builds WHERE id = ?');
        $stmt->execute([$id]);
        $row = $stmt->fetch();
        if ($row && in_array($row['class'], WF_CLASSES, true)) {
            // Un ancien build sans path garde l'URL d'avant : ordre automatique à l'ouverture.
            $path = (string) ($row['path'] ?? '');
            $target = '/' . $row['class'] . '?build=' . rawurlencode($row['build'])
                . ($path !== '' ? '&path=' . rawurlencode($path) : '') . '&b=' . $id;
        }
    }
} catch (Throwable $e) {
    error_log('[wf-builds] ' . $e->getMessage());
}

header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');
header('Location: ' . $target, true, 302);
exit;
