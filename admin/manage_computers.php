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

define('IN_SCRIPT',1);
define('HESK_PATH','../');
/* Code for the system to be able to differ if it's content from the original HESK */
define('IS_ASSET',1);

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

/* Get required database information for this feature */
// prefix for queries
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

$sql = "SELECT
  c.id,
  c.asset_tag,
  c.mac_address,
  c.name,
  c.os_name,
  c.os_version,
  c.purchase_date,
  c.warranty_until,
  c.is_internal,
  c.is_desktop,
  c.is_secure,
  c.is_active,
  cpu.model       AS cpu_model,
  mb.model        AS mb_model,
  ps.model        AS ps_model,
  ps.wattage_w    AS ps_watts,
  u.name          AS user_name,
  s.name          AS department_name,
  GROUP_CONCAT(DISTINCT CONCAT(r.model, ' ', r.size_gb, 'GB', ' (', r.speed_mhz, 'MHz)') SEPARATOR ', ') AS ram_list,
  GROUP_CONCAT(DISTINCT CONCAT(d.model, ' ', d.capacity_gb, 'GB', ' [', d.disk_type, ']') SEPARATOR ', ')  AS disk_list
FROM hesk_computers AS c
JOIN hesk_computers_cpu AS cpu ON cpu.id = c.cpu_id
JOIN hesk_computers_mb  AS mb  ON mb.id  = c.mb_id
LEFT JOIN hesk_computers_ps AS ps ON ps.id = c.ps_id
LEFT JOIN hesk_computer_has_ram  AS chr ON chr.computer_id = c.id  -- Fixed table name
LEFT JOIN hesk_computers_ram AS r   ON r.id = chr.ram_id
LEFT JOIN hesk_computer_has_disk AS cd  ON cd.computer_id = c.id   -- Fixed table name
LEFT JOIN hesk_computers_disk AS d   ON d.id = cd.disk_id
LEFT JOIN hesk_customers     AS u   ON u.id = c.customer_id
LEFT JOIN hesk_departments   AS s   ON s.id = u.department_id  -- Fixed join condition
WHERE c.is_active = 1
GROUP BY c.id
ORDER BY c.name";
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
        ?>
        <div class="table-wrap">
            <div class="card computer-card">
                <div class="mac"><?php echo htmlspecialchars($row['mac_address']); ?></div>
                <div class="name"><?php echo htmlspecialchars($row['name']); ?></div>
                <div class="os"><strong>OS:</strong> <?php echo htmlspecialchars($row['os_name'] . ' ' . $row['os_version']); ?></div>

                <div class="cpu"><strong>CPU:</strong> <?php echo htmlspecialchars($row['cpu_model']); ?></div>
                <div class="mb"><strong>Motherboard:</strong> <?php echo htmlspecialchars($row['mb_model']); ?></div>
                <div class="psu"><strong>PSU:</strong> <?php echo htmlspecialchars($row['ps_model'] . ' ' . $row['ps_watts'] . 'W'); ?></div>
                <div class="ram"><strong>RAM:</strong> <?php echo htmlspecialchars($row['ram_list'] ?: $hesklang['empty']); ?></div>
                <div class="disk"><strong>Disk:</strong> <?php echo htmlspecialchars($row['disk_list'] ?: $hesklang['empty']); ?></div>

                <div class="purchase"><strong><?php echo $hesklang['purchase_date']; ?>:</strong> <?php echo htmlspecialchars($row['purchase_date']); ?></div>
                <div class="warranty"><strong><?php echo $hesklang['warranty_until']; ?>:</strong> <?php echo htmlspecialchars($row['warranty_until']); ?></div>
                <div class="customer"><strong><?php echo $hesklang['customer']; ?>:</strong> <?php echo htmlspecialchars($row['user_name'] ?: $hesklang['empty']); ?></div>
                <div class="department"><strong><?php echo $hesklang['department']; ?>:</strong> <?php echo htmlspecialchars($row['department_name'] ?: $hesklang['empty']); ?></div>
                <div class="security"><strong>Security:</strong> <?php echo ($row['is_secure'] ? $hesklang['on'] : $hesklang['off']); ?></div>

                <?php if ($row['asset_tag']): ?>
                    <div class="asset-tag"><?php echo htmlspecialchars($row['asset_tag']); ?></div>
                <?php endif; ?>

                <div class="card__actions">
                    <a href="manage_computer.php?id=<?php echo $row['id']; ?>" class="btn btn--blue-border btn--primary"><?php echo $hesklang['edit']; ?></a>
                    <a href="delete_component.php?mac=<?php echo urlencode($row['mac_address']); ?>&amp;type=computer&amp;token=<?php hesk_token_echo(0); ?>" class="btn btn--delete" onclick="return confirm('<?php echo $hesklang['delete_confirm']; ?>')"><?php echo $hesklang['delete']; ?></a>
                </div>
            </div>
        </div>
        <?php
            }
        } else {
            echo '<p>'.$hesklang['no_data_found'].'</p>';
        }
        ?>
    </div>
</div>

<?php
require_once(HESK_PATH . 'inc/footer.inc.php');