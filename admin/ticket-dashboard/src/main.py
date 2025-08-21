from pathlib import Path
import json, os, traceback, time, tempfile

HERE = Path(__file__).resolve()
HESK_ROOT = HERE.parents[3]
CACHE_DIR = HESK_ROOT / "cache"
CACHE_DIR.mkdir(exist_ok=True)

TARGET = CACHE_DIR / "ticket_stats.json"
LOG = CACHE_DIR / "ticket_stats.log"

from get_data import (
    ticketPerCategory, ticketOpenAndClosed, timePerTicket,
    userTickets, ticketOccurrency
)

def compute_payload():
    return {
        "ticketPerCategory": ticketPerCategory(),
        "ticketOpenAndClosed": ticketOpenAndClosed(),
        "timePerTicket": timePerTicket(),
        "userTickets": userTickets(),
        "ticketOccurrency": ticketOccurrency(),
        "_generated_at": int(time.time())
    }

def write_atomic(path: Path, data: dict):
    fd, tmp_name = tempfile.mkstemp(prefix=path.name, dir=str(path.parent))
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            json.dump(data, f, ensure_ascii=False, separators=(",", ":"))
        os.replace(tmp_name, path)
    finally:
        if os.path.exists(tmp_name):
            try: os.remove(tmp_name)
            except OSError: pass

def main():
    try:
        payload = compute_payload()
        write_atomic(TARGET, payload)
    except Exception as e:
        with LOG.open("a", encoding="utf-8") as lf:
            lf.write(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] ERROR: {e}\n")
            lf.write(traceback.format_exc() + "\n")

if __name__ == "__main__":
    while True:
        main()
        time.sleep(60)
