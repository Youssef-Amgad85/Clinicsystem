
DELIMITER //

CREATE TRIGGER prevent_doctor_overlap
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;

    -- Check if any existing appointment for the same doctor and date overlaps
    -- Overlap Condition: (NewStart < ExistingEnd) AND (NewEnd > ExistingStart)
    SELECT COUNT(*) INTO overlap_count
    FROM Appointment
    WHERE DoctorID = NEW.DoctorID
      AND Date = NEW.Date
      AND NEW.StartTime < EndTime 
      AND NEW.EndTime > StartTime;

    -- If an overlap exists, block the insertion and return an error message
    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Doctor is already booked during this time slot.';
    END IF;
END; //


-- ------------------------------------------------------------
-- 2. AUTOMATIC BILLING UPDATE
-- Inspired by Project 1 requirements 
-- Logic: Ensures that whenever an appointment cost is set, 
-- a basic tax (e.g., 10%) is applied before saving.
-- ------------------------------------------------------------
CREATE TRIGGER apply_appointment_tax
BEFORE INSERT ON Appointment
FOR EACH ROW
BEGIN
    -- Automatically add 10% tax to the cost if it is provided
    IF NEW.Cost IS NOT NULL THEN
        SET NEW.Cost = NEW.Cost * 1.10;
    END IF;
END; //


-- ------------------------------------------------------------
-- 3. STATUS VALIDATION LOGIC
-- Derived from Lab 8 'WITH CHECK OPTION' principles [cite: 110, 111]
-- Logic: Prevents setting an appointment to an invalid status.
-- ------------------------------------------------------------
CREATE TRIGGER validate_appointment_status
BEFORE UPDATE ON Appointment
FOR EACH ROW
BEGIN
    -- Restrict status values to those defined in project [cite: 49]
    IF NEW.Status NOT IN ('scheduled', 'in progress', 'postponed') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Invalid status. Must be scheduled, in progress, or postponed.';
    END IF;
END; //

DELIMITER ;