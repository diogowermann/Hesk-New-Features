<?php
define('IN_SCRIPT',1);
define('HESK_PATH','../');

/* Get all the required files and functions */
require(HESK_PATH . 'hesk_settings.inc.php');
require(HESK_PATH . 'inc/common.inc.php');
require(HESK_PATH . 'inc/admin_functions.inc.php');
require(HESK_PATH . 'inc/reporting_functions.inc.php');
hesk_load_database_functions();

hesk_session_start();
hesk_dbConnect();
hesk_isLoggedIn();

// Check permissions for this feature
hesk_checkPermission('can_run_reports');

/* Print header */
require_once(HESK_PATH . 'inc/header.inc.php');

/* Print main manage users page */
require_once(HESK_PATH . 'inc/show_admin_nav.inc.php');

$stats_file = HESK_PATH . 'cache' . DIRECTORY_SEPARATOR . 'ticket_stats.json';
$stats_json = is_readable($stats_file) ? file_get_contents($stats_file) : '';
$stats = json_decode($stats_json, true) ?: [];
?>
<style>
  .statistics-dashboard {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    color: #333;
    padding: 20px;
    min-height: calc(100vh - 100px);
  }

  .dashboard-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
    padding-bottom: 16px;
    border-bottom: 1px solid #e1e4e8;
  }

  .dashboard-header h2 {
    margin: 0;
    font-size: 24px;
    font-weight: 600;
    color: #24292e;
  }

  .last-updated {
    margin: 0;
    font-size: 14px;
    color: #6a737d;
  }

  .kpi-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
  }

  .kpi-card {
    display: flex;
    align-items: center;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.04);
    background: white;
    transition: transform 0.2s ease, box-shadow 0.2s ease;
  }

  .kpi-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.08);
  }

  .kpi-card.primary {
    border-left: 4px solid #4A90E2;
  }

  .kpi-card.success {
    border-left: 4px solid #34A853;
  }

  .kpi-card.warning {
    border-left: 4px solid #FBBC05;
  }

  .kpi-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 48px;
    height: 48px;
    border-radius: 8px;
    margin-right: 16px;
    flex-shrink: 0;
  }

  .kpi-card.primary .kpi-icon {
    background-color: rgba(74, 144, 226, 0.1);
    color: #4A90E2;
  }

  .kpi-card.success .kpi-icon {
    background-color: rgba(52, 168, 83, 0.1);
    color: #34A853;
  }

  .kpi-card.warning .kpi-icon {
    background-color: rgba(251, 188, 5, 0.1);
    color: #FBBC05;
  }

  .kpi-icon svg {
    width: 24px;
    height: 24px;
  }

  .kpi-content {
    flex: 1;
  }

  .kpi-label {
    font-size: 14px;
    color: #6a737d;
    margin-bottom: 4px;
  }

  .kpi-value {
    font-size: 24px;
    font-weight: 700;
    margin-bottom: 4px;
    color: #24292e;
  }

  .kpi-sub {
    font-size: 12px;
    color: #6a737d;
  }

  .chart-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
    gap: 24px;
  }

  .chart-container {
    background: white;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.04);
    padding: 20px;
    height: 380px;
    display: flex;
    flex-direction: column;
  }

  .chart-header {
    margin-bottom: 16px;
  }

  .chart-header h3 {
    margin: 0;
    font-size: 16px;
    font-weight: 600;
    color: #24292e;
  }

  .chart-container canvas {
    flex: 1;
    min-height: 300px;
  }

  .last-updated-container {
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .reload-icon {
    color: #6a737d;
    display: inline-flex;
    align-items: center;
    transition: transform 0.4s ease;
  }

  .reload-icon:hover {
    transform: rotate(180deg);
    color: #24292e;
  }

  @media (max-width: 1100px) {
    .chart-grid {
      grid-template-columns: 1fr;
    }
  }

  @media (max-width: 768px) {
    .dashboard-header {
      flex-direction: column;
      align-items: flex-start;
    }
    
    .last-updated-container {
      margin-top: 8px;
    }
    
    .kpi-cards {
      grid-template-columns: 1fr;
    }
    
    .chart-grid {
      grid-template-columns: 1fr;
    }
    
    .chart-container {
      height: 320px;
    }
  }

  @media (max-width: 576px) {
    .statistics-dashboard {
      padding: 16px;
    }
    
    .kpi-card {
      flex-direction: column;
      text-align: center;
    }
    
    .kpi-icon {
      margin-right: 0;
      margin-bottom: 12px;
    }
    
    .chart-container {
      padding: 16px;
      height: 280px;
    }
  }
</style>

<div class="statistics-dashboard">
  <div class="dashboard-header">
    <h2><?php echo $hesklang['ticket_statistics']; ?></h2>
    <div class="last-updated-container">
      <a href="module_statistics.php" class="reload-icon" title="Reload">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M23 4v6h-6"></path>
            <path d="M20.49 15a9 9 0 1 1-2.12-9.36L23 10"></path>
        </svg>
      </a>
      <p class="last-updated">
        <?php
        if (!empty($stats['_generated_at'])) {
          echo $hesklang['last_updated'] . ': ' . date('F j, Y, g:i a', $stats['_generated_at']);
        } else {
          echo $hesklang['data_not_available'];
        }
        ?>
      </p>
    </div>
  </div>

  <div class="dashboard-content">
    <div class="kpi-cards">
      <div class="kpi-card primary">
        <div class="kpi-icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <polyline points="12 6 12 12 16 14"></polyline>
          </svg>
        </div>
        <div class="kpi-content">
          <div class="kpi-label"><?php echo $hesklang['avg_time_per_ticket']; ?></div>
          <div id="avgTime" class="kpi-value">--:--:--</div>
          <div class="kpi-sub"><?php echo $hesklang['across']; ?> <span id="ticketCount">0</span> <?php echo $hesklang['tickets']; ?></div>
        </div>
      </div>

      <div class="kpi-card success">
        <div class="kpi-icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
            <polyline points="22 4 12 14.01 9 11.01"></polyline>
          </svg>
        </div>
        <div class="kpi-content">
          <div class="kpi-label"><?php echo $hesklang['resolved_tickets']; ?></div>
          <div class="kpi-value"><?php echo isset($stats['ticketOpenAndClosed']['resolved']) ? $stats['ticketOpenAndClosed']['resolved'] : '0'; ?></div>
          <div class="kpi-sub"><?php echo $hesklang['successfully_closed']; ?></div>
        </div>
      </div>

      <div class="kpi-card warning">
        <div class="kpi-icon">
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="8" x2="12" y2="12"></line>
            <line x1="12" y1="16" x2="12.01" y2="16"></line>
          </svg>
        </div>
        <div class="kpi-content">
          <div class="kpi-label"><?php echo $hesklang['unresolved_tickets']; ?></div>
          <div class="kpi-value"><?php echo isset($stats['ticketOpenAndClosed']['unresolved']) ? $stats['ticketOpenAndClosed']['unresolved'] : '0'; ?></div>
          <div class="kpi-sub"><?php echo $hesklang['requiring_attention']; ?></div>
        </div>
      </div>
    </div>

    <div class="chart-grid">
      <div class="chart-container">
        <div class="chart-header">
          <h3><?php echo $hesklang['open_vs_closed_tickets']; ?></h3>
        </div>
        <canvas id="openClosedChart"></canvas>
      </div>

      <div class="chart-container">
        <div class="chart-header">
          <h3><?php echo $hesklang['tickets_per_category']; ?></h3>
        </div>
        <canvas id="perCategoryChart"></canvas>
      </div>

      <div class="chart-container">
        <div class="chart-header">
          <h3><?php echo $hesklang['top_requesters']; ?></h3>
        </div>
        <canvas id="userTicketsChart"></canvas>
      </div>

      <div class="chart-container">
        <div class="chart-header">
          <h3><?php echo $hesklang['avg_tickets_per_week']; ?></h3>
        </div>
        <canvas id="occurrencyChart"></canvas>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4"></script>

<script>
  // Safely expose the backend data to JS
  const stats = <?php
    echo json_encode($stats, JSON_UNESCAPED_UNICODE|JSON_HEX_TAG|JSON_HEX_APOS|JSON_HEX_QUOT|JSON_HEX_AMP);
  ?> || {};

  // Fill KPI
  const avg = (stats.timePerTicket && stats.timePerTicket.avg_time_spent) || '--:--:--';
  document.getElementById('avgTime').textContent = avg;
  document.getElementById('ticketCount').textContent =
    (stats.timePerTicket && stats.timePerTicket.ticket_count) || 0;

  // Common chart options
  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'bottom',
        labels: {
          padding: 20,
          usePointStyle: true,
        }
      }
    }
  };

  // Tickets per Category (horizontal bar)
  (() => {
    const ctx = document.getElementById('perCategoryChart');
    if (!ctx || !stats.ticketPerCategory) return;
    const entries = Object.entries(stats.ticketPerCategory);
    const labels = entries.map(([k]) => k);
    const data = entries.map(([,v]) => v);
    
    new Chart(ctx, {
      type: 'bar',
      data: { 
        labels, 
        datasets: [{ 
          label: '<?php echo $hesklang['tickets']; ?>', 
          data,
          backgroundColor: 'rgba(54, 162, 235, 0.7)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1
        }] 
      },
      options: {
        ...chartOptions,
        indexAxis: 'y',
        plugins: { 
          legend: { display: false }, 
          title: { 
            display: true, 
            text: '<?php echo $hesklang['tickets_per_category']; ?>' 
          } 
        },
        scales: { 
          x: { 
            beginAtZero: true, 
            ticks: { precision: 0 } 
          } 
        }
      }
    });
  })();

  // Open vs. Closed (doughnut)
  (() => {
    const ctx = document.getElementById('openClosedChart');
    if (!ctx || !stats.ticketOpenAndClosed) return;
    const labels = [
      '<?php echo $hesklang['unresolved']; ?>',
      '<?php echo $hesklang['resolved']; ?>'
    ];
    const data = [
      stats.ticketOpenAndClosed.unresolved || 0,
      stats.ticketOpenAndClosed.resolved || 0
    ];
    
    new Chart(ctx, {
      type: 'doughnut',
      data: { 
        labels, 
        datasets: [{ 
          data,
          backgroundColor: [
            'rgba(255, 159, 64, 0.7)',
            'rgba(75, 192, 192, 0.7)'
          ],
          borderColor: [
            'rgba(255, 159, 64, 1)',
            'rgba(75, 192, 192, 1)'
          ],
          borderWidth: 1
        }] 
      },
      options: {
        ...chartOptions,
        plugins: { 
          title: { 
            display: true, 
            text: '<?php echo $hesklang['open_vs_closed_tickets']; ?>' 
          } 
        }
      }
    });
  })();

  // Top Requesters (Top 15, horizontal)
  (() => {
    const ctx = document.getElementById('userTicketsChart');
    if (!ctx || !stats.userTickets) return;
    const all = Object.entries(stats.userTickets);
    const top = all.slice(-15).reverse();
    const labels = top.map(([email]) => email);
    const data = top.map(([,count]) => count);
    
    new Chart(ctx, {
      type: 'bar',
      data: { 
        labels, 
        datasets: [{ 
          label: '<?php echo $hesklang['tickets']; ?>', 
          data,
          backgroundColor: 'rgba(153, 102, 255, 0.7)',
          borderColor: 'rgba(153, 102, 255, 1)',
          borderWidth: 1
        }] 
      },
      options: {
        ...chartOptions,
        indexAxis: 'y',
        plugins: { 
          legend: { display: false }, 
          title: { 
            display: true, 
            text: '<?php echo $hesklang['top_requesters']; ?>' 
          } 
        },
        scales: { 
          x: { 
            beginAtZero: true, 
            ticks: { precision: 0 } 
          } 
        }
      }
    });
  })();

  // Average Tickets per Week (2 bars)
  (() => {
    const ctx = document.getElementById('occurrencyChart');
    if (!ctx || !stats.ticketOccurrency) return;
    const labels = [
      '<?php echo $hesklang['all_weeks']; ?>', 
      '<?php echo $hesklang['observed_weeks']; ?>'
    ];
    const data = [stats.ticketOccurrency.all || 0, stats.ticketOccurrency.observed || 0];
    
    new Chart(ctx, {
      type: 'bar',
      data: { 
        labels, 
        datasets: [{ 
          label: '<?php echo $hesklang['avg_tickets_per_week']; ?>', 
          data,
          backgroundColor: 'rgba(255, 99, 132, 0.7)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        }] 
      },
      options: {
        ...chartOptions,
        plugins: { 
          title: { 
            display: true, 
            text: '<?php echo $hesklang['avg_tickets_per_week']; ?>' 
          } 
        },
        scales: { 
          y: { 
            beginAtZero: true, 
            ticks: { precision: 0 } 
          } 
        }
      }
    });
  })();
</script>
<?php
require_once(HESK_PATH . 'inc/footer.inc.php');
exit();