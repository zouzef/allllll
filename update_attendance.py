from datetime import datetime
import requests
import json

with open("config.json","r") as f:
    config=json.load(f)



mac_adress="f4:4d:30:ee:c9:1d"
BASE_URL="https://www.unistudious.com"
TOKEN= config["serverConfig"]["TOKEN"]
def change_release_token(entityID,entityName):
    try:

        url=f"{BASE_URL}/slc/reset-special-slc-token-detail-by-id"

        headers={"Authorization": f"Bearer {TOKEN}"}
        payload={
            'entityId':entityID,
            'entityName':entityName
        }
        response=requests.post(url,headers=headers,data=payload)
        response.raise_for_status()

        print("response_code",response.status_code)
        if(response.status_code==200):
            print("the releaseToken updated")


    except Exception as err:
        print(f"error is from functio reset entity:{f}")

def update_attendance(conn, attendance_data):
    """
    Update 'attendance' data in the MariaDB attendance table.
    This function handles only the 'updated' records.
    """
    result = {
        "success_count": 0,
        "error_count": 0,
        "errors": [],
        "total_processed": 0
    }

    cursor = None
    try:
        cursor = conn.cursor()

        # Extract updated records
        updated_attendance = attendance_data.get("updated", [])
        result["total_processed"] = len(updated_attendance)

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
        print("attendance datato update from function update attendance :",updated_attendance)
        for i, attendance in enumerate(updated_attendance, 1):
            try:
                # Validate required fields
                attendance_id = attendance.get("id")
                if not attendance_id:
                    raise ValueError("Missing required field: id")

                # Extract data for update
                attendance_id=attendance.get("id")
                account_id = attendance.get("accountId")
                session_id = attendance.get("sessionId")
                user_id = attendance.get("userId")
                group_id = attendance.get("groupId")
                present = 1 if attendance.get("present", False) else 0  # Convert boolean to tinyint
                day = format_date(attendance.get("day"))
                note = attendance.get("note")
                editable = 1 if attendance.get("editable", True) else 0  # Convert boolean to tinyint
                enabled = 1 if attendance.get("enabled", True) else 0  # Convert boolean to tinyint
                release_Token=attendance.get("releaseToken")
                use_Token= attendance.get("useToken")


                print("releaseToken: ",release_Token)
                print("use_token: ",use_Token)

                if(release_Token==True and use_Token==mac_adress):
                    print("you cannot add to data base and you must change the release token")
                    change_release_token(attendance_id,"Attendance")

                else:
                    # Format dates
                    updated_at = format_date(attendance.get("createdAt"))
                    timestamp = format_date(attendance.get("timestamp"))

                    print(f"Updating attendance {i}/{len(updated_attendance)} - ID {attendance_id}")

                    # Execute update query
                    cursor.execute("""
                        UPDATE attendance SET
                            account_id = %s,
                            session_id = %s,
                            user_id = %s,
                            group_session_id = %s,
                            is_present = %s,
                            day = %s,
                            note = %s,
                            is_editable = %s,
                            enabled = %s,
                            updated_at = %s,
                            timestamp = %s
                        WHERE id = %s
                    """, (
                        account_id, session_id, user_id, group_id, present, day,
                        note, editable, enabled, updated_at, timestamp, attendance_id
                    ))


                    # Check if any row was actually updated
                    if cursor.rowcount > 0:
                        result["success_count"] += 1
                        print(f"✔ Attendance ID {attendance_id} updated successfully")
                    else:
                        print(f"⚠️  Attendance ID {attendance_id} not found (no rows updated)")

            except Exception as err:
                error_msg = f"❌ Error updating attendance ID {attendance.get('id', 'unknown')}: {err}"
                print(error_msg)
                result["error_count"] += 1
                result["errors"].append({
                    "attendance_id": attendance.get("id", "unknown"),
                    "error": str(err),
                    "record_number": i
                })
                continue

        conn.commit()
        print(f"✅ Successfully updated {result['success_count']}/{result['total_processed']} attendance record(s)")

        if result["error_count"] > 0:
            print(f"⚠️  {result['error_count']} record(s) had errors")

    except Exception as err:
        print(f"💥 Unexpected database error: {err}")
        result["errors"].append({"type": "Database Error", "error": str(err)})
        try:
            conn.rollback()
            print("🔄 Transaction rolled back")
        except:
            pass
    finally:
        if cursor:
            cursor.close()

    return result