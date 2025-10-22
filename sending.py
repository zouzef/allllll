import mysql.connector
import requests
import json
import os
import time
from datetime import datetime, timedelta
from push_data_attendance import push_attendance  # Push new account records
from update_attendance import update_attendance
# === CONFIG ===


with open("config.json", "r") as f:
    config = json.load(f)

server_config = config["serverConfig"]
db_config = config["databaseConfig"]

TOKEN = server_config["TOKEN"]
SYNC_INTERVAL = server_config["SYNC_INTERVAL_MINUTES"]
SYNC_FILE = server_config["SYNC_STATUS_FILE"]
CHECK_URL = server_config["INTERNET_CHECK_URL"]
TIMEOUT = server_config["INTERNET_CHECK_TIMEOUT"]


# === BASIC HELPERS ===
def check_internet():
    try:
        print("Checking internet...")
        r = requests.get(CHECK_URL, timeout=TIMEOUT)
        return r.status_code == 200
    except:
        print("No internet.")
        return False


def connect_db():
    return mysql.connector.connect(**db_config)


def get_last_sync():
    if not os.path.exists(SYNC_FILE):
        return None
    try:
        with open(SYNC_FILE, "r") as f:
            return datetime.fromisoformat(json.load(f)["last_sync_time"])
    except:
        return None


def save_last_sync(dt):
    with open(SYNC_FILE, "w") as f:
        json.dump({"last_sync_time": dt.isoformat()}, f)
    print("Saved sync time:", dt)


# === API FETCH ===
def fetch_data(token, since=None):
    url = "https://unistudious.com/slc/get-whats-news"
    headers = {"Authorization": f"Bearer {token}"}
    payload = {}

    if since:
        payload["date"] = (since - timedelta(hours=1)).strftime("%Y-%m-%d %H:%M")

    r = requests.post(url, headers=headers, data=payload)
    r.raise_for_status()
    return r.json()


# === SYNC LOGIC ===
def sync_account():
    if not check_internet():
        print("No internet connection, skipping sync.")
        return

    conn = connect_db()
    last_sync = get_last_sync()
    now = datetime.now()

    print(f"\n=== Syncing Account at {now} ===")
    data = fetch_data(TOKEN, last_sync)
    account_data = data.get("attendance", {})
    #print(data)
    if not account_data:
        print("No account data to sync.")
        return

    if account_data.get("created"):
        print("Pushing new accounts...")
        push_attendance(conn, {"created": account_data["created"]})

    if account_data.get("updated"):
        print("Pushing updated accounts...")
        update_attendance(conn, {"updated": account_data["updated"]})


    save_last_sync(now)
    conn.close()
    print("✅ Account sync completed.\n")


# === RUN LOOP ===
def main():
    print("Starting single-table sync (account only)")
    while True:
        sync_account()
        print(f"Sleeping {SYNC_INTERVAL} minute(s)...\n")
        time.sleep(SYNC_INTERVAL * 60)


if __name__ == "__main__":
    main()
