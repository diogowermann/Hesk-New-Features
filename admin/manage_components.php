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
define('IS_ASSET', 1);

require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
require(HESK_PATH . 'inc/database_mysqli.inc.php');
hesk_load_database_functions();

hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();
hesk_checkPermission('can_man_assets');

/* Get required database information for this feature */
// prefix for queries
$dbp = hesk_dbEscape($hesk_settings['db_pfix']);

$cpus  = hesk_dbQuery("SELECT id, model, cores, threads FROM `{$dbp}computers_cpu` WHERE is_active=1 ORDER BY model");
$rams  = hesk_dbQuery("SELECT id, model, size_gb, speed_mhz, ram_type FROM `{$dbp}computers_ram` WHERE is_active=1 ORDER BY model");
$mbs   = hesk_dbQuery("SELECT id, model, ram_slots, ram_type, ram_max_storage_gb, ram_max_speed_mhz, chipset FROM `{$dbp}computers_mb` WHERE is_active=1 ORDER BY model");
$disks = hesk_dbQuery("SELECT id, model, disk_type, interface, speed_rpm, capacity_gb FROM `{$dbp}computers_disk` WHERE is_active=1 ORDER BY model");
$psus  = hesk_dbQuery("SELECT id, model, wattage_w, is_bivolt FROM `{$dbp}computers_ps` WHERE is_active=1 ORDER BY model");
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
        <h2><?php echo $hesklang['components']?></h2>
    </section>

    <div class="component-tables">
        <!-- CPU Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><?php echo $hesklang['cpu'] ?></h3>
                <a class="btn btn--blue-border" href="manage_component.php?type=cpu"><?php echo $hesklang['add_new_component'] ?></a>
            </div>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th><?php echo $hesklang['id'] ?></th>
                            <th><?php echo $hesklang['model'] ?></th>
                            <th><?php echo $hesklang['cores'] ?></th>
                            <th><?php echo $hesklang['threads'] ?></th>
                            <th><?php echo $hesklang['actions'] ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (hesk_dbNumRows($cpus) > 0): ?>
                            <?php while ($cpu = hesk_dbFetchAssoc($cpus)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($cpu['id']); ?></td>
                                <td><?php echo htmlspecialchars($cpu['model']); ?></td>
                                <td><?php echo htmlspecialchars($cpu['cores']); ?></td>
                                <td><?php echo htmlspecialchars($cpu['threads']); ?></td>
                                <td>
                                    <div class="actions">
                                        <a class="action-btn edit" href="manage_component.php?do=edit&type=cpu&id=<?php echo $cpu['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                        <a class="action-btn view" href="manage_component.php?do=view&type=cpu&id=<?php echo $cpu['id'] ?>"><svg class="icon icon-view"><use xlink:href="../img/sprite.svg#icon-eye-open"></use></svg></a>
                                        <a class="action-btn delete" href="manage_component.php?do=delete&type=cpu&id=<?php echo $cpu['id'] ?>" onclick="return confirm('<?php echo $hesklang['delete_confirm'].' '.$cpu['model'].'?' ?>')"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>   
                                    </div>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="5" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- RAM Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><?php echo $hesklang['ram_modules'] ?></h3>
                <a class="btn btn--blue-border"  href="manage_component.php?type=ram"><?php echo $hesklang['add_new_component'] ?></a>
            </div>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th><?php echo $hesklang['id'] ?></th>
                            <th><?php echo $hesklang['model'] ?></th>
                            <th><?php echo $hesklang['size_gb'] ?></th>
                            <th><?php echo $hesklang['speed_mhz'] ?></th>
                            <th><?php echo $hesklang['type'] ?></th>
                            <th><?php echo $hesklang['actions'] ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (hesk_dbNumRows($rams) > 0): ?>
                            <?php while ($ram = hesk_dbFetchAssoc($rams)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($ram['id']); ?></td>
                                <td><?php echo htmlspecialchars($ram['model']); ?></td>
                                <td><?php echo htmlspecialchars($ram['size_gb']); ?></td>
                                <td><?php echo htmlspecialchars($ram['speed_mhz']); ?></td>
                                <td><?php echo htmlspecialchars($ram['ram_type']); ?></td>
                                <td>
                                    <div class="actions">
                                        <a class="action-btn edit" href="manage_component.php?do=edit&type=ram&id=<?php echo $ram['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                        <a class="action-btn view" href="manage_component.php?do=view&type=ram&id=<?php echo $ram['id'] ?>"><svg class="icon icon-view"><use xlink:href="../img/sprite.svg#icon-eye-open"></use></svg></a>
                                        <a class="action-btn delete" href="manage_component.php?do=delete&type=ram&id=<?php echo $ram['id'] ?>" onclick="return confirm('<?php echo $hesklang['delete_confirm'].' '.$ram['model'].'?' ?>')"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>   
                                    </div>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="6" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Motherboard Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><?php echo $hesklang['motherboard'] ?></h3>
                <a class="btn btn--blue-border"  href="manage_component.php?type=motherboard"><?php echo $hesklang['add_new_component'] ?></a>
            </div>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th><?php echo $hesklang['id'] ?></th>
                            <th><?php echo $hesklang['model'] ?></th>
                            <th><?php echo $hesklang['ram_slots'] ?></th>
                            <th><?php echo $hesklang['type'] ?></th>
                            <th><?php echo $hesklang['max_ram_gb'] ?></th>
                            <th><?php echo $hesklang['speed_mhz'] ?></th>
                            <th><?php echo $hesklang['chipset'] ?></th>
                            <th><?php echo $hesklang['actions'] ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (hesk_dbNumRows($mbs) > 0): ?>
                            <?php while ($mb = hesk_dbFetchAssoc($mbs)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($mb['id']); ?></td>
                                <td><?php echo htmlspecialchars($mb['model']); ?></td>
                                <td><?php echo htmlspecialchars($mb['ram_slots']); ?></td>
                                <td><?php echo htmlspecialchars($mb['ram_type']); ?></td>
                                <td><?php echo htmlspecialchars($mb['ram_max_storage_gb']); ?></td>
                                <td><?php echo htmlspecialchars($mb['ram_max_speed_mhz']); ?></td>
                                <td><?php echo htmlspecialchars($mb['chipset']); ?></td>
                                <td>
                                    <div class="actions">
                                        <a class="action-btn edit" href="manage_component.php?do=edit&type=motherboard&id=<?php echo $mb['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                        <a class="action-btn view" href="manage_component.php?do=view&type=motherboard&id=<?php echo $mb['id'] ?>"><svg class="icon icon-view"><use xlink:href="../img/sprite.svg#icon-eye-open"></use></svg></a>
                                        <a class="action-btn delete" href="manage_component.php?do=delete&type=motherboard&id=<?php echo $mb['id'] ?>" onclick="return confirm('<?php echo $hesklang['delete_confirm'].' '.$mb['model'].'?' ?>')"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>   
                                    </div>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="8" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Disk Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><?php echo $hesklang['disks'] ?></h3>
                <a class="btn btn--blue-border"  href="manage_component.php?type=disk"><?php echo $hesklang['add_new_component'] ?></a>
            </div>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th><?php echo $hesklang['id'] ?></th>
                            <th><?php echo $hesklang['model'] ?></th>
                            <th><?php echo $hesklang['type'] ?></th>
                            <th><?php echo $hesklang['interface'] ?></th>
                            <th><?php echo $hesklang['speed_rpm'] ?></th>
                            <th><?php echo $hesklang['capacity_gb'] ?></th>
                            <th><?php echo $hesklang['actions'] ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (hesk_dbNumRows($disks) > 0): ?>
                            <?php while ($disk = hesk_dbFetchAssoc($disks)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($disk['id']); ?></td>
                                <td><?php echo htmlspecialchars($disk['model']); ?></td>
                                <td><?php echo htmlspecialchars($disk['disk_type']); ?></td>
                                <td><?php echo htmlspecialchars($disk['interface']); ?></td>
                                <td><?php echo htmlspecialchars($disk['speed_rpm']); ?></td>
                                <td><?php echo htmlspecialchars($disk['capacity_gb']); ?></td>
                                <td>
                                    <div class="actions">
                                        <a class="action-btn edit" href="manage_component.php?do=edit&type=disk&id=<?php echo $disk['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                        <a class="action-btn view" href="manage_component.php?do=view&type=disk&id=<?php echo $disk['id'] ?>"><svg class="icon icon-view"><use xlink:href="../img/sprite.svg#icon-eye-open"></use></svg></a>
                                        <a class="action-btn delete" href="manage_component.php?do=delete&type=disk&id=<?php echo $disk['id'] ?>" onclick="return confirm('<?php echo $hesklang['delete_confirm'].' '.$disk['model'].'?' ?>')"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>   
                                    </div>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="7" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- PSU Table -->
        <div class="table-wrap">
            <div class="table-header">
                <h3><?php echo $hesklang['power_supplies'] ?></h3>
                <a class="btn btn--blue-border"  href="manage_component.php?type=psu"><?php echo $hesklang['add_new_component'] ?></a>
            </div>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th><?php echo $hesklang['id'] ?></th>
                            <th><?php echo $hesklang['model'] ?></th>
                            <th><?php echo $hesklang['wattage'] ?></th>
                            <th><?php echo $hesklang['bivolt'] ?></th>
                            <th><?php echo $hesklang['actions'] ?></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if (hesk_dbNumRows($psus) > 0): ?>
                            <?php while ($psu = hesk_dbFetchAssoc($psus)): ?>
                            <tr>
                                <td><?php echo htmlspecialchars($psu['id']); ?></td>
                                <td><?php echo htmlspecialchars($psu['model']); ?></td>
                                <td><?php echo htmlspecialchars($psu['wattage_w']); ?></td>
                                <td><?php echo $psu['is_bivolt'] ? 'Yes' : 'No'; ?></td>
                                <td>
                                    <div class="actions">
                                        <a class="action-btn edit" href="manage_component.php?do=edit&type=psu&id=<?php echo $psu['id'] ?>"><svg class="icon icon-edit-ticket"><use xlink:href="../img/sprite.svg#icon-edit-ticket"></use></svg></a>
                                        <a class="action-btn view" href="manage_component.php?do=view&type=psu&id=<?php echo $psu['id'] ?>"><svg class="icon icon-view"><use xlink:href="../img/sprite.svg#icon-eye-open"></use></svg></a>
                                        <a class="action-btn delete" href="manage_component.php?do=delete&type=psu&id=<?php echo $psu['id'] ?>"><svg class="icon icon-delete"><use xlink:href="../img/sprite.svg#icon-delete"></use></svg></a>                                
                                    </div>
                                </td>
                            </tr>
                            <?php endwhile; ?>
                        <?php else: ?>
                            <tr>
                                <td colspan="5" class="no-data"><?php echo $hesklang['no_data_found']; ?></td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
?>