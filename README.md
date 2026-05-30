# Clinic Management System 🏥

## 1. Project Overview
The **Clinic Management System** is a relational database solution built for the **CBIO204: Fundamentals of Databases** course under the supervision of Dr. Mohamed Mahmoud Elsayeh. 

This system is engineered to help clinical healthcare facilities digitally transition away from manual paperwork. It optimizes daily medical operations by providing a centralized database architecture to manage patients, doctors, departments, scheduled appointments, and dynamic medical diagnoses efficiently. 

### Key Features Applied:
* **Relational Schema Enforcements:** Primary and foreign keys to secure data integrity.
* **Advanced Data Retrieval:** Multi-table Inner/Left Joins, Aggregations, and conditional groupings (`GROUP BY` & `HAVING`).
* **Database Objects:** Custom database Views for dynamic scheduling and triggers to automate validation checks.
* **User-Friendly Access:** Interfaced with a Graphical User Interface (GUI) to remove the barrier of manually writing SQL queries for clinic receptionists.

---

## 2. Repo Structure Explanation
The repository is organized to separate database definition blueprints, data assets, query configurations, and presentation materials clearly:

```text
├── Clinicsystem database.sql     # DDL Script: Schema creation, tables layout, and entity constraints.
├── Load data.sql                 # DML Script: Mock datasets used to populate the tables.
├── queries.sql                  # Production Queries: Joins, Views, updates, and testing scenarios.
├── Clinic management system (2).pptx # Presentation deck summarizing system architecture.
└── README.md                     # Documentation guidelines (This file).

## 3. Installation steps:
-Prerequisites
Ensure you have an SQL Database Server installed (e.g., MySQL Workbench or a local server instance like XAMPP/WAMP).

Step 1: Initialize the Database Structure (DDL)
Open your SQL workbench or database terminal and connect to your local server.

Open the file Clinicsystem database.sql.

Execute the entire script. This will automatically execute the Data Definition commands:

Create the ClinicSystem schema environment.

Generate the core empty structural entities: Department, Clinic, Doctor, Patient, and Appointment.

Step 2: Populate the Database with Core Assets (DML)
Open the file Load data.sql in your workspace editor.

Ensure you are targeting the right schema environment by making sure USE ClinicSystem; is active.

Run the script. This inserts your pre-configured mock data records smoothly into the system structures.

Step 3: Run Testing & Production Queries
Open the queries.sql script file.

From here, you can run and inspect specific query scenarios line by line to verify structural performance, including:

Query 1 (Inner Join): Fetching specific doctors paired side-by-side with their textual department names.

Query 2 (Left Join): Auditing a master tracking sheet displaying all registered system patients alongside any appointments booked.

Advanced Views & Aggregates: Tracking upcoming monthly doctor rosters and billing metrics over 3-year timelines.
