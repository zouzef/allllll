import mysql.connector
import requests
import json
import time

# Config
with open("config.json") as f:
    config = json.load(f)

db_config = config["databaseConfig"]
TOKEN = config["serverConfig"]["TOKEN"]
API_URL = "https://unistudious.com/slc/update-attendance-note/"

def send_to_remote(attendance_record,attendance_id):
    """Send attendance record to remote API"""
    payload = {
        'note':"youssefkasmi"
    }  # Map fields if needed
    headers = {"Authorization": f"Bearer {TOKEN}"}
    try:
        url=f"{API_URL}{attendance_id}"
        print(url)
        response=requests.post(url, data=payload, headers=headers)
        response.raise_for_status()
        print(response.status_code)

        return response.status_code == 200
    except Exception as e:
        print(f"❌ Error sending to remote: {e}")
        return False

def process_audit():
    try:
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)

        # Select only rows that have releaseToken = 1 AND useToken not NULL
        cursor.execute("""
            SELECT id, record_id, new_data, releaseToken, useToken
            FROM attendance_audit
            WHERE releaseToken = 1 AND useToken IS NOT NULL
        """)
        rows = cursor.fetchall()

        for row in rows:
            new_data = json.loads(row['new_data'])
            if send_to_remote(new_data,row['record_id']):
                # After successful push, reset releaseToken and useToken in main table
                cursor.execute("""
                    UPDATE attendance
                    SET releaseToken = 0, useToken = NULL
                    WHERE id = %s
                """, (row['record_id'],))
                # Also reset releaseToken and useToken in audit table
                cursor.execute("""
                    UPDATE attendance_audit
                    SET releaseToken = 0, useToken = NULL
                    WHERE id = %s
                """, (row['id'],))
                print(f"✔ Attendance ID {row['record_id']} synced successfully")
            else:
                print(f"⚠️ Failed to sync Attendance ID {row['record_id']}")

        conn.commit()

    except Exception as e:
        print(f"💥 Database error: {e}")

    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals() and conn.is_connected():
            conn.close()

# Continuous monitoring
while True:
    process_audit()
    time.sleep(10)  # Check every 10 seconds
