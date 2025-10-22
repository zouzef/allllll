--- code sql for the data base e-learning ---


DELIMITER $$

CREATE TRIGGER trg_after_update
AFTER UPDATE ON attendance
FOR EACH ROW
BEGIN
    -- Only insert if slc_edit = 1 AND something actually changed
    IF NEW.slc_edit = 1 AND
       JSON_OBJECT(
           'attendanceID', OLD.id,
           'userID', OLD.user_id,
           'calander_id', OLD.calander_id,
           'is_present', OLD.is_present,
           'note', OLD.note
       ) <> JSON_OBJECT(
           'attendanceID', NEW.id,
           'userID', NEW.user_id,
           'calander_id', NEW.calander_id,
           'is_present', NEW.is_present,
           'note', NEW.note
       )
    THEN
        INSERT INTO attendance_audit
        (
            action_type,
            old_data,
            new_data,
            changed_at,
            is_synced,
            id_attendance
        ) VALUES
        (
            'UPDATE',
            JSON_OBJECT(
                'attendanceID', OLD.id,
                'userID', OLD.user_id,
                'calander_id', OLD.calander_id,
                'is_present', OLD.is_present,
                'note', OLD.note
            ),
            JSON_OBJECT(
                'attendanceID', NEW.id,
                'userID', NEW.user_id,
                'calander_id', NEW.calander_id,
                'is_present', NEW.is_present,
                'note', NEW.note
            ),
            NOW(),
            0,
            NEW.id
        );
    END IF;
END$$

DELIMITER ;


CREATE TABLE attendance_audit(
	audit_id INT PRIMARY KEY AUTO_INCREMENT,
    action_type VARCHAR(255) NOT NULL,
    old_data JSON,
    new_data JSON,
    changed_at DATE(),
    is_synced int DEFAULT 0
);





        )

