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

/* Get mac from url for editing */
$mac = hesk_GET('mac', '');
$computer = [];
if ($mac) {
    $res = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers` WHERE `MAC` = '".hesk_dbEscape($mac)."'");
    $computer = hesk_dbFetchAssoc($res);
}

/* Get required database information for this feature */
$computers = hesk_dbQuery("SELECT c.*, cpu.MODEL AS cpu_model, disk.STORAGE AS disk_storage, font.TENSION AS font_tension, u.NAME AS user_name, 
(SELECT COALESCE(SUM(r.SIZE),0) FROM ".hesk_dbEscape($hesk_settings['db_pfix'])."computers_ram AS r WHERE FIND_IN_SET(r.RAM_ID, c.RAM_ID) ) AS total_ram_size 
FROM ".hesk_dbEscape($hesk_settings['db_pfix'])."computers AS c LEFT JOIN ".hesk_dbEscape($hesk_settings['db_pfix'])."computers_cpu AS cpu ON c.CPU_ID = cpu.CPU_ID 
LEFT JOIN ".hesk_dbEscape($hesk_settings['db_pfix'])."computers_disk AS disk ON c.DISK_ID = disk.DISK_ID 
LEFT JOIN ".hesk_dbEscape($hesk_settings['db_pfix'])."computers_font AS font ON c.FONT_ID = font.FONT_ID 
LEFT JOIN ".hesk_dbEscape($hesk_settings['db_pfix'])."user_clients AS u ON c.USER_ID = u.USER_ID WHERE c.ACTIVE = 1");
$users = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."user_clients` WHERE `ACTIVE` = 1");
$cpus = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers_cpu` WHERE `ACTIVE` = 1");
$rams = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers_ram` WHERE `ACTIVE` = 1");
$mbs = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers_mb` WHERE `ACTIVE` = 1");
$fonts = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers_font` WHERE `ACTIVE` = 1");
$disks = hesk_dbQuery("SELECT * FROM `".hesk_dbEscape($hesk_settings['db_pfix'])."computers_disk` WHERE `ACTIVE` = 1");

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
        <a href="manage_computer.php" class="btn btn btn--blue-border" ripple="ripple">
            <?php echo $hesklang['add_computer']; ?>
        </a></h2>
    </section>
    <div class="table-wrap">
        <table id="default-table" class="table sindu-table">
            <thead>
                <tr>
                    <th><?php echo $hesklang['mac_address']; ?></th>
                    <th><?php echo $hesklang['computer_name']; ?></th>
                    <th><?php echo $hesklang['customer']; ?></th>
                    <th><?php echo $hesklang['cpu']; ?></th>
                    <th><?php echo $hesklang['gpu']; ?></th>
                    <th><?php echo $hesklang['ram']; ?></th>
                    <th><?php echo $hesklang['font']; ?></th>
                    <th><?php echo $hesklang['disk']; ?></th>
                    <th><?php echo $hesklang['internal']; ?></th>
                    <th><?php echo $hesklang['desktop']; ?></th>
                    <th><?php echo $hesklang['protected']; ?></th>
                    <th><?php echo $hesklang['actions']; ?></th>
                </tr>
            </thead>
            <tbody>
                <?php
                if (hesk_dbNumRows($computers) > 0) {
                    while ($row = hesk_dbFetchAssoc($computers)) {
                        echo '
                        <tr>
                            <td>'.htmlspecialchars($row['MAC']).'</td>
                            <td>'.htmlspecialchars($row['NAME']).'</td>
                            <td>'.($row['USER_ID'] ? htmlspecialchars($row['customer']) : $hesklang['empty']).'</td>
                            <td>'.($row['CPU_ID'] ? htmlspecialchars($row['cpu']) : $hesklang['empty']).'</td>
                            <td>'.($row['GPU'] ? $hesklang['dedicated'] : $hesklang['integrated']).'</td>
                            <td>'.(int)$row['total_ram_size'] . 'GB' .'</td>
                            <td>'.($row['FONT_ID'] ? ($row['font_tension']) . 'W' : $hesklang['empty']).'</td>
                            <td>'.($row['DISK_ID'] ? htmlspecialchars($row['disk_size']) . ' GB' : $hesklang['empty']).'</td>
                            <td>'.($row['INTERNAL'] ? $hesklang['yes'] : $hesklang['no']).'</td>
                            <td>'.($row['DESKTOP'] ? $hesklang['yes'] : $hesklang['no']).'</td>
                            <td>'.($row['SECURE'] ? $hesklang['yes'] : $hesklang['no']).'</td>
                            <td>
                                <div class="actions">
                                    <a class="tooltip" href="manage_computer.php?mac='.urlencode($row['MAC']).'"
                                    title="'.$hesklang['edit'].'">
                                        <svg class="icon icon-edit-ticket">
                                            <use xlink:href="'.HESK_PATH.'img/sprite.svg#icon-edit-ticket"></use>
                                        </svg>
                                    </a>
                                    <a class="delete" href="delete_component.php?mac='.urlencode($row['MAC']).'&type=computer&token='.hesk_token_echo(0).'" onclick="return confirm(\''.$hesklang['delete_confirm'].'\');">
                                        <svg class="icon icon-delete">
                                            <use xlink:href="'.HESK_PATH.'img/sprite.svg#icon-delete"></use>
                                        </svg>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        ';
                    }
                } else {
                    echo '<tr><td colspan="12">'.$hesklang['no_data_found'].'</td></tr>';
                }
                ?>
            </tbody>
        </table>
    </div>
</div>

<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
