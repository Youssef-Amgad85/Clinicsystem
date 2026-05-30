Use clinicsystem;
INSERT INTO Department (DepartmentID, Name) VALUES
(1, 'Cardiology'),
(2, 'Pediatrics'),
(3, 'Dermatology'),
(4, 'Neurology'),
(5, 'Orthopedics'),
(6, 'Ophthalmology'),
(7, 'Gastroenterology'),
(8, 'Psychiatry'),
(9, 'Endocrinology'),
(10, 'General Medicine');

INSERT INTO Doctor (DoctorID, Name, PhoneNumber, Address, DepartmentID) VALUES
(101, 'Dr. Alice Smith', '555-0101', '123 Maple St', 1),
(102, 'Dr. Bob Johnson', '555-0102', '456 Oak Ave', 2),
(103, 'Dr. Charlie Brown', '555-0103', '789 Pine Rd', 3),
(104, 'Dr. Diana Prince', '555-0104', '321 Elm Blvd', 4),
(105, 'Dr. Edward Norton', '555-0105', '654 Cedar Ln', 5),
(106, 'Dr. Fiona Gallagher', '555-0106', '987 Birch Dr', 6),
(107, 'Dr. George Miller', '555-0107', '159 Walnut Ct', 7),
(108, 'Dr. Hannah Abbott', '555-0108', '753 Willow Way', 8),
(109, 'Dr. Ian Wright', '555-0109', '852 Aspen Dr', 9),
(110, 'Dr. Jane Foster', '555-0110', '951 Cherry St', 10);

INSERT INTO Patient (PatientID, Name, PhoneNumber, Address, BirthDate, Job) VALUES
(12527, 'John Doe', '555-2001', '101 Apple St', '1985-05-12', 'Software Engineer'),
(2002, 'Mary Poppins', '555-2002', '202 Cherry Ln', '1970-11-23', 'Teacher'),
(2003, 'Bruce Wayne', '555-2003', '1007 Wayne Manor', '1980-02-19', 'CEO'),
(2004, 'Clark Kent', '555-2004', '344 Clinton St', '1978-06-18', 'Journalist'),
(2005, 'Peter Parker', '555-2005', '20 Ingram St', '2001-08-10', 'Photographer'),
(2006, 'Diana Prince', '555-2006', 'Gateway City', '1984-03-05', 'Antiquities Dealer'),
(2007, 'Tony Stark', '555-2007', '10880 Malibu Pt', '1970-05-29', 'Inventor'),
(2008, 'Steve Rogers', '555-2008', '569 Lefferts Ave', '1918-07-04', 'Artist'),
(2009, 'Natasha Romanoff', '555-2009', 'Classified', '1984-11-22', 'Special Agent'),
(2010, 'Wanda Maximoff', '555-2010', '616 Hex Dr', '1989-02-10', 'None'),
(2011, 'Stephen Strange', '555-2011', '177A Bleecker St', '1930-11-18', 'Neurosurgeon');

INSERT INTO Appointment (AppointmentID, Date, StartTime, EndTime, Cost, Status, Diagnosis, PatientID, DoctorID) VALUES
(501, '2026-05-01', '09:00:00', '09:30:00', 150.00, 'Scheduled', 'Routine Checkup', 12527, 101),
(502, '2026-05-02', '10:00:00', '10:45:00', 200.00, 'In Progress', 'High Blood Pressure', 2002, 101),
(503, '2025-12-15', '11:00:00', '11:30:00', 350.00, 'Postponed', 'Joint Pain', 2003, 105),
(504, '2026-05-10', '14:00:00', '14:30:00', 120.00, 'Scheduled', 'Flu Symptoms', 2004, 110),
(505, '2024-03-20', '08:30:00', '09:00:00', 500.00, 'Scheduled', 'Chest Pain', 12527, 101),
(506, '2026-05-11', '13:00:00', '13:30:00', 95.00,  'Scheduled', 'Skin Rash', 2005, 103),
(507, '2026-06-05', '15:30:00', '16:00:00', 250.00, 'Scheduled', 'Anxiety', 2008, 108),
(508, '2023-01-10', '09:00:00', '10:00:00', 1000.00, 'Scheduled', 'Surgery Consult', 12527, 105),
(509, '2026-05-12', '10:30:00', '11:00:00', 180.00, 'Scheduled', 'Eye Exam', 2006, 106),
(510, '2026-05-13', '12:00:00', '12:45:00', 220.00, 'Scheduled', 'Diabetes Follow-up', 2009, 109),
(511, '2026-05-14', '09:00:00', '09:30:00', 300.00, 'Scheduled', 'Migraine', 2011, 104);

INSERT INTO Clinic (ClinicID, Name, Address, DepartmentID) VALUES
(10, 'Heart Center A', '123 Maple St, Suite 1', 1),
(11, 'Kids Care Clinic', '456 Oak Ave, Suite 2', 2),
(12, 'Skin Health Specialists', '789 Pine Rd, Suite 1', 3),
(13, 'Neuro Research Unit', '321 Elm Blvd, Wing B', 4),
(14, 'Joint & Bone Clinic', '654 Cedar Ln, Floor 1', 5),
(15, 'Vision Care Center', '987 Birch Dr, Suite 5', 6),
(16, 'Digestive Health Plus', '159 Walnut Ct, Suite 3', 7),
(17, 'Wellness Mind Clinic', '753 Willow Way, Suite 10', 8),
(18, 'Hormone Specialist Group', '852 Aspen Dr, Floor 2', 9),
(19, 'City General Clinic', '951 Cherry St, Wing A', 10),
(20, 'Cardiology Annex', '123 Maple St, Suite 2', 1);

