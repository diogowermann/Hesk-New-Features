from db import dbConnect

conn = dbConnect()
cursor = conn.cursor()

def ticketPerCategory() -> dict:
    cursor.execute("SELECT id, name FROM hesk_categories")
    res = cursor.fetchall()
    result = {}
    for cat in res:
        cursor.execute(f"SELECT id FROM hesk_tickets WHERE category={cat[0]}")
        res = cursor.fetchall()
        result[cat[1]] = len(res)

    return dict(sorted(result.items(), key=lambda x: x[1]))

def ticketOpenAndClosed() -> dict:
    cursor.execute("SELECT status FROM hesk_tickets")
    res = cursor.fetchall()
    result = {'resolved': 0, 'unresolved': 0}
    for ticket_status in res:
        if ticket_status[0] == 3:
            result['resolved'] += 1
        else:
            result['unresolved'] += 1
    
    return result
        
def timePerTicket() -> dict:
    cursor.execute("SELECT time_worked FROM hesk_tickets")
    res = cursor.fetchall()
    result = {'avg_time_spent': '', 'ticket_count': 0}

    total_seconds = 0 
    count = len(res)

    for (time_str,) in res:
        total_seconds += time_str.total_seconds()

    avg_seconds = int(total_seconds / count)
    hours = avg_seconds // 3600
    minutes = (avg_seconds % 3600) // 60
    seconds = avg_seconds % 60

    result['avg_time_spent'] = f"{hours:02d}:{minutes:02d}:{seconds:02d}"
    result['ticket_count'] = count

    return result

def userTickets() -> dict:
    cursor.execute("SELECT email FROM hesk_tickets")
    res = cursor.fetchall()
    result = {}

    for (email,) in res:
        result[email] = result.get(email, 0) + 1

    return dict(sorted(result.items(), key=lambda x: x[1]))

def ticketOccurrency() -> dict:
    """
    Average tickets opened per week (both empty and only week that have tickets).
    Rounded to nearest whole number.
    """
    result = {'all': 0, 'observed': 0}
    cursor.execute("""
        SELECT
            CASE WHEN total_weeks = 0 THEN 0
                 ELSE ROUND(total_tickets / total_weeks)
            END AS avg_per_week
        FROM (
            SELECT
              COUNT(*) AS total_tickets,
              TIMESTAMPDIFF(
                WEEK,
                DATE_SUB(DATE(MIN(dt)), INTERVAL WEEKDAY(MIN(dt)) DAY),
                DATE_SUB(DATE(MAX(dt)), INTERVAL WEEKDAY(MAX(dt)) DAY)
              ) + 1 AS total_weeks
            FROM hesk_tickets
        ) x
    """)
    all = cursor.fetchone()
    result['all'] = int(all[0] or 0)

    cursor.execute("""
        SELECT ROUND(AVG(weekly_count)) AS avg_per_week
        FROM (
            SELECT YEARWEEK(dt, 3) AS iso_week, COUNT(*) AS weekly_count
            FROM hesk_tickets
            GROUP BY iso_week
        ) AS w
    """)
    observed = cursor.fetchone()
    result['observed'] = int(observed[0] or 0)

    return result