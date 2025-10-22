from datetime import datetime
import requests
import json

with open("config.json","r")as f:
    config=json.load(f)

mac_adress="f4:4d:30:ee:c9:1d"
BASE_URL ="https://www.unistudious.com"
TOKEN= config["serverConfig"]["TOKEN"]

def change_release_token(entityID,entityName):
    try:
        url=f"{BASE_URL}/slc/reset-special-slc-token-detail-by-id"
        headers={"Authorisation": f"Bearer {TOKEN}"}
        payload={
            'enityID':entityID,
            'entityName':entityName
        }
        response=requests.post(url,headers=headers,data=payload)
        response.raise_for_status()

        print("response_code",response.status_code)
        if(response.status_code == 200):
            print("the releasToken updated")
    except Exception as err:
        print(f"error is form function reset entity {err}")

def update_attendance(conn,attendance_data):
    result = {
        "success_count":0,
        "error_count":0,
        "errors":[],
        "total_processed":0
    }

    cursor = None
    try:
        cursor = conn.cursor()

        updated_attendance = attendance_data.get("updated",[])
        result["total_processed"] = len (updated_attendance)

        if result["total_processed"] == 0:
            print("No attendance records to update")
            return result

        print(f"Updating {len(updated_attendance)} attendance record(s)")

        def format_date(date_str):
            """Format date string to MySQL datetime format"""
            if not date_str:
                return None
            try:
                if 'T' in date_str:
                    return datetime.fromisoformat(date_str.replace('Z', '+00:00')).strftime("%Y-%m-%d %H:%M:%S")
                else:
                    return datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S").strftime("%Y-%m-%d %H:%M:%S")
            except (ValueError, TypeError) as e:
                print(f"Warning: Invalid date format '{date_str}', using NULL: {e}")
                return None

        print("attendance datato update from function update attendance :", updated_attendance)

        for i,attendance in enumerate(updated_attendance,1):
            try:
                attendance_id = attendance.get("id")
                if not attendance_id:
                    raise ValueError("Missking required fiels: id ")

                attendance_id = attendance.get("id")
                account_id