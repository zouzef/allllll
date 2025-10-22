--- code sql for the data base e-learning ---


DELIMITER $$

CREATE TRIGGER trg_after_insert_attendance
AFTER INSERT ON attendance
FOR EACH ROW 
BEGIN 
    IF NEW.useToken IS NOT NULL THEN 
        INSERT INTO attendance_audit(
            action_type,
            old_data,
            new_data,
            changed_at
        )
        VALUES
            (
                'INSERT',
                NULL,
                JSON_OBJECT(
                    'attendanceID', NEW.id,
                    'userID', NEW.user_id,
                    'calander_id', NEW.calander_id,
                    'is_present', NEW.is_present,
                    'note', NEW.note
                ),
                NOW()
            );
    END IF;
END$$

DELIMITER ;



