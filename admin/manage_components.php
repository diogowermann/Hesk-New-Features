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
<style>
.table-scroll {
    max-height: 500px;
    overflow-y: auto;
}
.table-scroll table {
    width: 100%;
    border-collapse: collapse;
}
</style>

<div class="main__content assets">
    <section class="assets__head">
        <h2><?php echo $hesklang['component_visualization'] ?? 'Component Visualization'; ?></h2>
    </section>

    <div class="component-tables">
        <!-- CPU Table -->
        <div class="table-wrap">
            <h3>CPUs</h3>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model</th>
                            <th>Cores</th>
                            <th>Threads</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($cpu = hesk_dbFetchAssoc($cpus)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($cpu['id']); ?></td>
                            <td><?php echo htmlspecialchars($cpu['model']); ?></td>
                            <td><?php echo htmlspecialchars($cpu['cores']); ?></td>
                            <td><?php echo htmlspecialchars($cpu['threads']); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- RAM Table -->
        <div class="table-wrap">
            <h3>RAM Modules</h3>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model</th>
                            <th>Size (GB)</th>
                            <th>Speed (MHz)</th>
                            <th>Type</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($ram = hesk_dbFetchAssoc($rams)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($ram['id']); ?></td>
                            <td><?php echo htmlspecialchars($ram['model']); ?></td>
                            <td><?php echo htmlspecialchars($ram['size_gb']); ?></td>
                            <td><?php echo htmlspecialchars($ram['speed_mhz']); ?></td>
                            <td><?php echo htmlspecialchars($ram['ram_type']); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Motherboard Table -->
        <div class="table-wrap">
            <h3>Motherboards</h3>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model</th>
                            <th>RAM Slots</th>
                            <th>Type</th>
                            <th>Max RAM (GB)</th>
                            <th>Max Speed (MHz)</th>
                            <th>Chipset</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($mb = hesk_dbFetchAssoc($mbs)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($mb['id']); ?></td>
                            <td><?php echo htmlspecialchars($mb['model']); ?></td>
                            <td><?php echo htmlspecialchars($mb['ram_slots']); ?></td>
                            <td><?php echo htmlspecialchars($mb['ram_type']); ?></td>
                            <td><?php echo htmlspecialchars($mb['ram_max_storage_gb']); ?></td>
                            <td><?php echo htmlspecialchars($mb['ram_max_speed_mhz']); ?></td>
                            <td><?php echo htmlspecialchars($mb['chipset']); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Disk Table -->
        <div class="table-wrap">
            <h3>Disks</h3>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model</th>
                            <th>Type</th>
                            <th>Interface</th>
                            <th>Speed (RPM)</th>
                            <th>Capacity (GB)</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($disk = hesk_dbFetchAssoc($disks)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($disk['id']); ?></td>
                            <td><?php echo htmlspecialchars($disk['model']); ?></td>
                            <td><?php echo htmlspecialchars($disk['disk_type']); ?></td>
                            <td><?php echo htmlspecialchars($disk['interface']); ?></td>
                            <td><?php echo htmlspecialchars($disk['speed_rpm']); ?></td>
                            <td><?php echo htmlspecialchars($disk['capacity_gb']); ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- PSU Table -->
        <div class="table-wrap">
            <h3>Power Supplies</h3>
            <div class="table table-scroll">
                <table class="table sindu-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Model</th>
                            <th>Wattage (W)</th>
                            <th>Bivolt</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($psu = hesk_dbFetchAssoc($psus)): ?>
                        <tr>
                            <td><?php echo htmlspecialchars($psu['id']); ?></td>
                            <td><?php echo htmlspecialchars($psu['model']); ?></td>
                            <td><?php echo htmlspecialchars($psu['wattage_w']); ?></td>
                            <td><?php echo $psu['is_bivolt'] ? 'Yes' : 'No'; ?></td>
                        </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
?>