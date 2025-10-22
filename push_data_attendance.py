from datetime import datetime


def push_attendance(conn, attendance_data):
    """
    Push 'attendance' data from API into the MariaDB attendance table.
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

        # Extract created and updated records
        created_attendance = attendance_data.get("created", [])
        updated_attendance = attendance_data.get("updated", [])

        all_attendance = created_attendance + updated_attendance
        result["total_processed"] = len(all_attendance)
        print(f"Processing {len(all_attendance)} attendance record(s)")

        def format_date(date_str):
            """Format date string to MySQL datetime format"""
            if not date_str:
                return None  # Let MySQL handle default values
            try:
                if 'T' in date_str:
                    # Handle ISO format with timezone
                    return datetime.fromisoformat(date_str.replace('Z', '+00:00')).strftime("%Y-%m-%d %H:%M:%S")
                else:
                    # Handle already formatted datetime
                    return datetime.strptime(date_str, "%Y-%m-%d %H:%M:%S").strftime("%Y-%m-%d %H:%M:%S")
            except (ValueError, TypeError) as e:
                print(f"Warning: Invalid date format '{date_str}', using NULL: {e}")
                return None

        # Batch processing for better performance
        if len(all_attendance) > 100:
            print("Large dataset detected, consider implementing batch processing")

        for i, attendance in enumerate(all_attendance, 1):
            try:
                # Validate required fields
                attendance_id = attendance.get("id")
                if not attendance_id:
                    raise ValueError("Missing required field: id")

                # Map API fields to DB fields
                user_id = attendance.get("userId")
                account_id = attendance.get("accountId")
                session_id = attendance.get("sessionId")

                is_present = bool(attendance.get("present", False))  # Ensure boolean
                day = attendance.get("day")
                note = attendance.get("note")
                is_editable = bool(attendance.get("editable", True))  # Ensure boolean
                enabled = bool(attendance.get("enabled", True))  # Ensure boolean
                # Fields not in API response - set to NULL
                group_session_id = None
                calander_id = attendance.get("calenderId")
                payment_session_id = None
                releaseToken = 1 if attendance.get("releaseToken", False) else 0
                useToken = attendance.get("useToken")



                # Format dates
                created_at = format_date(attendance.get("createdAt"))
                updated_at = format_date(attendance.get("updatedAt"))
                timestamp = format_date(attendance.get("timestamp"))

                # Handle day field specially
                day_formatted = None
                if day:
                    day_formatted = format_date(day)

                print(
                    f"Processing attendance {i}/{len(all_attendance)} - ID {attendance_id}: present={is_present}, day={day_formatted}")

                # Execute insert with upsert logic
                cursor.execute("""
                    INSERT INTO attendance (
                        id, user_id, account_id, session_id, group_session_id, 
                        calander_id, payment_session_id, is_present, day, note, is_editable,
                        enabled, created_at, timestamp, updated_at,is_sync,releaseToken,
                        useToken
                    )
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,%s,%s)
                    ON DUPLICATE KEY UPDATE
                        user_id = VALUES(user_id),
                        account_id = VALUES(account_id),
                        session_id = VALUES(session_id),
                        group_session_id = VALUES(group_session_id),
                        calander_id = VALUES(calander_id),
                        payment_session_id = VALUES(payment_session_id),
                        is_present = VALUES(is_present),
                        day = VALUES(day),
                        note = VALUES(note),
                        is_editable = VALUES(is_editable),
                        enabled = VALUES(enabled),
                        created_at = VALUES(created_at),
                        timestamp = VALUES(timestamp),
                        updated_at = VALUES(updated_at),
                        is_sync = VALUES(is_sync),
                        releaseToken = VALUES(releaseToken),
                        useToken = VALUES(useToken)
                """, (
                    attendance_id, user_id, account_id, session_id, group_session_id,
                    calander_id, payment_session_id, is_present, day_formatted, note, is_editable,
                    enabled, created_at, timestamp, updated_at,1,
                    releaseToken, useToken
                ))

                result["success_count"] += 1
                print(f"✔ Attendance ID {attendance_id} processed successfully")

            except Exception as err:
                error_msg = f"❌ Error for attendance ID {attendance.get('id', 'unknown')}: {err}"
                print(error_msg)
                result["error_count"] += 1
                result["errors"].append({
                    "attendance_id": attendance.get("id", "unknown"),
                    "error": str(err),
                    "record_number": i
                })
                # Continue processing other records
                continue

        # Commit all changes at once
        conn.commit()
        print(f"✅ Successfully processed {result['success_count']}/{result['total_processed']} attendance record(s)")

        if result["error_count"] > 0:
            print(f"⚠️  {result['error_count']} record(s) had errors")

    except Exception as err:
        print(f"💥 Unexpected database error: {err}")
        result["errors"].append({"type": "Database Error", "error": str(err)})
        # Rollback on unexpected errors
        try:
            conn.rollback()
            print("🔄 Transaction rolled back")
        except:
            pass
    finally:
        if cursor:
            cursor.close()

    return result