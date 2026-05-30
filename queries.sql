-- Display all patient names and jobs [cite: 581]
SELECT Name, Job FROM Patient;

-- Find Cardiology clinics (Using a Sub-query as per Lab 8) [cite: 374, 388]
SELECT Name, Address 
FROM Clinic 
WHERE DepartmentID = (SELECT DepartmentID FROM Department WHERE Name = 'Cardiology');

-- Find patients with a specific diagnosis using the LIKE operator [cite: 594]
-- Query: "List patients diagnosed with fatty liver in the last year" [cite: 51]

SELECT Diagnosis FROM appointment;
SELECT Date FROM Appointment WHERE Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
UPDATE Appointment 
SET Diagnosis = 'Patient has fatty liver symptoms', 
    Date = '2026-01-10' 
WHERE AppointmentID = 501;

SELECT DISTINCT p.Name 
FROM Patient p
JOIN Appointment a ON p.PatientID = a.PatientID
WHERE a.Diagnosis LIKE '%fatty liver%' 
  AND a.Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);
  
  

-- ------------------------------------------------------------
-- 2. JOINS (Lab 8 - Part 1)
-- ------------------------------------------------------------

-- Inner Join: Display Doctor names and their Department names [cite: 275, 422]
SELECT Doctor.Name AS Doctor_Name, Department.Name AS Dept_Name
FROM Doctor
INNER JOIN Department ON Doctor.DepartmentID = Department.DepartmentID;

-- Left Join: Display all patients and their appointment dates (including those without appointments) [cite: 306, 425]
SELECT p.Name, a.Date
FROM Patient p
LEFT JOIN Appointment a ON p.PatientID = a.PatientID;

-- ------------------------------------------------------------
-- 3. AGGREGATION & GROUPING (Lab 6)
-- ------------------------------------------------------------

-- Total revenue from patient 12527 in the last 3 years [cite: 53, 604]
SELECT SUM(Cost) AS Total_Paid 
FROM Appointment 
WHERE PatientID = 12527 
  AND Date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);

-- Average appointment cost per department [cite: 634]
SELECT d.Name, AVG(a.Cost) AS Avg_Cost
FROM Department d
JOIN Doctor doc ON d.DepartmentID = doc.DepartmentID
JOIN Appointment a ON doc.DoctorID = a.DoctorID
GROUP BY d.Name
HAVING AVG(a.Cost) > 100; -- Filtering groups with HAVING [cite: 642]

-- ------------------------------------------------------------
-- 4. VIEWS (Lab 8 - Part 2)
-- ------------------------------------------------------------

-- Create a view for upcoming doctor schedules (Next Month) [cite: 81]
-- This fulfills the requirement from your project image.
CREATE VIEW vw_Doctor_Schedule_NextMonth AS
SELECT d.Name AS Doctor_Name, COUNT(a.AppointmentID) AS Appt_Count
FROM Doctor d
LEFT JOIN Appointment a ON d.DoctorID = a.DoctorID
WHERE a.Date BETWEEN '2026-06-01' AND '2026-06-30'
GROUP BY d.DoctorID, d.Name;

-- Retrieve data from the view [cite: 92]
SELECT * FROM vw_Doctor_Schedule_NextMonth;

-- ------------------------------------------------------------
-- 5. UPDATES & DELETIONS (Lab 6)
-- ------------------------------------------------------------

-- Update appointment status [cite: 570]
UPDATE Appointment 
SET Status = 'In Progress' 
WHERE AppointmentID = 502;

-- Increase appointment costs by 10% for a specific department (Sub-query) [cite: 424, 570]
UPDATE Appointment
SET Cost = Cost * 1.10
WHERE DoctorID IN (SELECT DoctorID FROM Doctor WHERE DepartmentID = 1);

-- Delete a specific record [cite: 574]
DELETE FROM Patient WHERE PatientID = 2010;