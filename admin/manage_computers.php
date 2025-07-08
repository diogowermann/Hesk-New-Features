<?php
/**
 *
 * This file is NOT part of HESK - PHP Help Desk Software.
 *
 * (c) Copyright Klemen Stirn. All rights reserved to the owner of the software.
 * https://www.hesk.com
 *
 * For the full copyright and license agreement information visit
 * https://www.hesk.com/eula.php
 *
 * This file does not claim ownership for the software.
 */

define('IN_SCRIPT', 1);
define('HESK_PATH', '../');
/* Code for the system to be able to differ if it's content from the original HESK */
define('IS_ASSET', 1);

/* Get all the required files and functions */
require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
hesk_load_database_functions();

hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();

/* Check permissions for this feature */
hesk_checkPermission('can_man_assets');

/* Handle removal of inactive components */
if (isset($_GET['remove_inactive']) && hesk_checkPermission('can_man_assets', 0)) {
    $computer_id = intval($_GET['remove_inactive']);

    // Fetch computer data
    $dbp = hesk_dbEscape($hesk_settings['db_pfix']);
    $sql = "SELECT
        comp.id,
        comp.ps_id,
        comp.customer_id,
        comp.department_id,
        cpu.is_active    AS cpu_is_active,
        mb.is_active     AS mb_is_active,
        ps.is_active     AS psu_is_active,
        ctmr.is_active   AS ctmr_is_active,
        dptmt.is_active  AS dptmt_is_active,
        MAX(CASE WHEN ram.is_active = 0 THEN 1 ELSE 0 END) AS ram_has_inactive,
        MAX(CASE WHEN disk.is_active = 0 THEN 1 ELSE 0 END) AS disk_has_inactive
    FROM `{$dbp}computers` AS comp
    JOIN `{$dbp}computers_cpu`          AS cpu   ON cpu.id = comp.cpu_id
    JOIN `{$dbp}computers_mb`           AS mb    ON mb.id  = comp.mb_id
    LEFT JOIN `{$dbp}computers_ps`      AS ps    ON ps.id = comp.ps_id
    LEFT JOIN `{$dbp}computer_has_ram`  AS chr   ON chr.computer_id = comp.id
    LEFT JOIN `{$dbp}computers_ram`     AS ram   ON ram.id = chr.ram_id
    LEFT JOIN `{$dbp}computer_has_disk` AS cd    ON cd.computer_id = comp.id
    LEFT JOIN `{$dbp}computers_disk`    AS disk  ON disk.id = cd.disk_id
    LEFT JOIN `{$dbp}customers`         AS ctmr  ON ctmr.id = comp.customer_id
    LEFT JOIN `{$dbp}departments`       AS dptmt ON dptmt.id = comp.department_id
    WHERE comp.id = {$computer_id}
    GROUP BY comp.id";

    $res = hesk_dbQuery($sql);
    if (hesk_dbNumRows($res) != 1) {
        hesk_process_messages($hesklang['asset_not_found'], 'NOREDIRECT');
        exit();
    }
    $row = hesk_dbFetchAssoc($res);

    // Update computer record
    $updates = array();
    if ($row['psu_is_active'] == 0) {
        $updates[] = "`ps_id` = NULL";
    }
    if ($row['customer_id'] && $row['ctmr_is_active'] == 0) {
        $updates[] = "`customer_id` = NULL";
    }
    if ($row['department_id'] && $row['dptmt_is_active'] == 0) {
        $updates[] = "`department_id` = NULL";
    }

    if (!empty($updates)) {
        $sql = "UPDATE `{$dbp}computers` SET " . implode(', ', $updates) . " WHERE `id` = {$computer_id}";
        hesk_dbQuery($sql);
    }

    // Remove inactive RAM
    if ($row['ram_has_inactive'] == 1) {
        $sql = "DELETE chr FROM `{$dbp}computer_has_ram` AS chr
                JOIN `{$dbp}computers_ram` AS ram ON chr.ram_id = ram.id
                WHERE chr.computer_id = {$computer_id} AND ram.is_active = 0";
        hesk_dbQuery($sql);
    }

    // Remove inactive Disks
    if ($row['disk_has_inactive'] == 1) {
        $sql = "DELETE cd FROM `{$dbp}computer_has_disk` AS cd
                JOIN `{$dbp}computers_disk` AS disk ON cd.disk_id = disk.id
                WHERE cd.computer_id = {$computer_id} AND disk.is_active = 0";
        hesk_dbQuery($sql);
    }

    hesk_process_messages($hesklang['inactive_removed'], 'NOREDIRECT', 'SUCCESS');
}

/* Get required database information for this feature */
// prefix for queries
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

$sql = "SELECT
  comp.id,
  comp.asset_tag,
  comp.mac_address,
  comp.name,
  comp.os_name,
  comp.os_version,
  comp.purchase_date,
  comp.warranty_until,
  comp.is_internal,
  comp.is_desktop,
  comp.is_secure,
  comp.is_active,
  cpu.model        AS cpu_model,
  cpu.is_active    AS cpu_is_active,
  mb.model         AS mb_model,
  mb.is_active     AS mb_is_active,
  ps.model         AS ps_model,
  ps.wattage_w     AS ps_watts,
  ps.is_active     AS psu_is_active,
  ctmr.name        AS ctmr_name,
  ctmr.is_active   AS ctmr_is_active,
  dptmt.name       AS dptmt_name,
  dptmt.is_active  AS dptmt_is_active,
  GROUP_CONCAT(DISTINCT CONCAT(ram.model, ' ', ram.size_gb, 'GB', ' (', ram.speed_mhz, 'MHz)') SEPARATOR ', ') AS ram_list,
  GROUP_CONCAT(DISTINCT CONCAT(disk.model, ' ', disk.capacity_gb, 'GB', ' [', disk.disk_type, ']') SEPARATOR ', ')  AS disk_list,
  MAX(CASE WHEN ram.is_active = 0 THEN 1 ELSE 0 END) AS ram_has_inactive,
  MAX(CASE WHEN disk.is_active = 0 THEN 1 ELSE 0 END) AS disk_has_inactive
FROM hesk_computers              AS comp
JOIN hesk_computers_cpu          AS cpu   ON cpu.id = comp.cpu_id
JOIN hesk_computers_mb           AS mb    ON mb.id  = comp.mb_id
LEFT JOIN hesk_computers_ps      AS ps    ON ps.id = comp.ps_id
LEFT JOIN hesk_computer_has_ram  AS chr   ON chr.computer_id = comp.id
LEFT JOIN hesk_computers_ram     AS ram     ON ram.id = chr.ram_id
LEFT JOIN hesk_computer_has_disk AS cd    ON cd.computer_id = comp.id
LEFT JOIN hesk_computers_disk    AS disk     ON disk.id = cd.disk_id
LEFT JOIN hesk_customers         AS ctmr  ON ctmr.id = comp.customer_id
LEFT JOIN hesk_departments       AS dptmt ON dptmt.id = comp.department_id
WHERE comp.is_active = 1
GROUP BY comp.id
ORDER BY comp.name";
$computers = hesk_dbQuery($sql);
/* Required database info collected */

/* Print header */
require_once(HESK_PATH . 'inc/header.inc.php');

/* Print main manage users page */
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');

/* This will handle error, success and notice messages */
if (hesk_SESSION('iserror')) {
    hesk_handle_messages();
}
?>
<div class="main__content assets">
    <section class="assets__head">
        <h2>
            <?php echo $hesklang['menu_computers'] ?>
            <div class="tooltype right out-close">
                <svg class="icon icon-info">
                    <use xlink:href="<?php echo HESK_PATH; ?>img/sprite.svg#icon-info"></use>
                </svg>
                <div class="tooltype__content">
                    <div class="tooltype__wrapper">
                        <?php echo $hesklang['asset_intro_computers']; ?>
                    </div>
                </div>
            </div>
        </h2>
        <a href="manage_computer.php" class="btn btn--blue-border" ripple="ripple">
            <?php echo $hesklang['add_computer']; ?>
        </a>
    </section>

    <div class="cards-grid">
        <?php
        if (hesk_dbNumRows($computers) > 0) {
            while ($row = hesk_dbFetchAssoc($computers)) {
                // check for inactive components
                $alerts = [];
                if ($row['cpu_is_active'] == 0) {
                    $alerts[] = $hesklang['cpu_is_inactive'];
                }
                if ($row['mb_is_active'] == 0) {
                    $alerts[] = $hesklang['mb_is_inactive'];
                }
                if ($row['psu_is_active'] == 0) {
                    $alerts[] = $hesklang['psu_is_inactive'];
                }
                if ($row['ram_has_inactive'] == 1) {
                    $alerts[] = $hesklang['ram_has_inactive'];
                }
                if ($row['disk_has_inactive'] == 1) {
                    $alerts[] = $hesklang['disk_has_inactive'];
                }
                if ($row['ctmr_name'] && isset($row['ctmr_is_active']) && $row['ctmr_is_active'] == 0) {
                    $alerts[] = $hesklang['customer_is_inactive'];
                }
                if ($row['dptmt_name'] && isset($row['dptmt_is_active']) && $row['dptmt_is_active'] == 0) {
                    $alerts[] = $hesklang['department_is_inactive'];
                }

                $hasAlerts = !empty($alerts);
                ?>
                <div class="table-wrap">
                    <div class="card computer-card">
                        <div class="mac"><?php echo strtoupper(htmlspecialchars($row['mac_address'])); ?></div>
                        <div class="alert">
                            <?php if ($hasAlerts): ?>
                                <a class="icon alert-icon" href="manage_computers.php?remove_inactive=<?php echo $row['id']; ?>"
                                    onclick="return confirm('<?php echo $hesklang['confirm_remove_inactive']; ?>')">⚠️</a>
                                <div class="alert-tooltip">
                                    <?= implode('<br>', array_map('htmlspecialchars', $alerts)) ?>
                                </div>
                            <?php endif; ?>
                        </div>

                        <div class="name"><strong><?php echo htmlspecialchars($row['name']); ?></strong></div>
                        <div class="os"><?php echo htmlspecialchars($row['os_name'] . ' ' . $row['os_version']); ?></div>

                        <div class="cpu"><strong><?php echo $hesklang['cpu']; ?>:</strong>
                            <?php echo htmlspecialchars($row['cpu_model']); ?></div>
                        <div class="mb"><strong><?php echo $hesklang['motherboard']; ?>:</strong>
                            <?php echo htmlspecialchars($row['mb_model']); ?></div>
                        <div class="psu"><strong><?php echo $hesklang['psu']; ?>:</strong>
                            <?php echo htmlspecialchars($row['ps_model'] . ' ' . $row['ps_watts'] . 'W'); ?></div>
                        <div class="ram"><strong><?php echo $hesklang['rams']; ?>:</strong>
                            <?php echo htmlspecialchars($row['ram_list'] ?: $hesklang['empty']); ?></div>
                        <div class="disk"><strong><?php echo $hesklang['disks']; ?>:</strong>
                            <?php echo htmlspecialchars($row['disk_list'] ?: $hesklang['empty']); ?></div>

                        <div class="purchase"><strong><?php echo $hesklang['purchase_date']; ?>:</strong>
                            <?php echo htmlspecialchars($row['purchase_date']); ?></div>
                        <div class="warranty"><strong><?php echo $hesklang['warranty_until']; ?>:</strong>
                            <?php echo htmlspecialchars($row['warranty_until']); ?></div>
                        <div class="customer"><strong><?php echo $hesklang['customer']; ?>:</strong>
                            <?php echo htmlspecialchars($row['ctmr_name'] ?: $hesklang['empty']); ?></div>
                        <div class="department"><strong><?php echo $hesklang['department']; ?>:</strong>
                            <?php echo htmlspecialchars($row['dptmt_name'] ?: $hesklang['empty']); ?></div>
                        <div class="security"><strong><?php echo $hesklang['security']; ?>:</strong>
                            <?php echo ($row['is_secure'] ? $hesklang['on'] : $hesklang['off']); ?></div>

                        <?php if ($row['asset_tag']): ?>
                            <div class="asset-tag"><?php echo htmlspecialchars($row['asset_tag']); ?></div>
                        <?php endif; ?>

                        <div class="card__actions">
                            <a href="manage_computer.php?do=edit&id=<?php echo $row['id']; ?>"
                                class="btn btn--blue-border btn--primary"><?php echo $hesklang['edit']; ?></a>
                            <a href="manage_computer.php?do=delete&id=<?php echo $row['id']; ?>" class="btn btn--delete"
                                onclick="return confirm('<?php echo $hesklang['delete_confirm'] . ' ' . $row['name'] . '?' ?>')"><?php echo $hesklang['delete']; ?></a>
                        </div>
                    </div>
                </div>
                <?php
            }
        } else {
            echo '<p>' . $hesklang['no_data_found'] . '</p>';
        }
        ?>
    </div>
</div>

<?php
function update_inactive_components(&$row)
{
    // Remove CPU if inactive
    if (isset($row['cpu_is_active']) && $row['cpu_is_active'] == 0) {
        $row['cpu_model'] = '';
    }
    // Remove Motherboard if inactive
    if (isset($row['mb_is_active']) && $row['mb_is_active'] == 0) {
        $row['mb_model'] = '';
    }
    // Remove PSU if inactive
    if (isset($row['psu_is_active']) && $row['psu_is_active'] == 0) {
        $row['ps_model'] = '';
        $row['ps_watts'] = '';
    }
    // Remove RAMs if any inactive
    if (isset($row['ram_has_inactive']) && $row['ram_has_inactive'] == 1) {
        $row['ram_list'] = '';
    }
    // Remove Disks if any inactive
    if (isset($row['disk_has_inactive']) && $row['disk_has_inactive'] == 1) {
        $row['disk_list'] = '';
    }
    // Remove Customer if inactive
    if (isset($row['ctmr_is_active']) && $row['ctmr_is_active'] == 0) {
        $row['ctmr_name'] = '';
    }
    // Remove Department if inactive
    if (isset($row['dptmt_is_active']) && $row['dptmt_is_active'] == 0) {
        $row['dptmt_name'] = '';
    }
}

require_once(HESK_PATH . 'inc/footer.inc.php');