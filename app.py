from flask import Flask, render_template, request, redirect, url_for, flash, g
import mysql.connector as mysql_driver

app = Flask(__name__)
app.secret_key = 'some_secret_key_for_badges'

app.config['MYSQL_HOST']     = 'localhost'
app.config['MYSQL_USER']     = 'root'
app.config['MYSQL_PASSWORD'] = 'password'  
app.config['MYSQL_DB']       = 'ClinicSystem'       


class MySQLWrapper:
    def __init__(self, app=None):
        self.app = app
    @property
    def connection(self):
        if 'mysql_db' not in g:
            g.mysql_db = mysql_driver.connect(
                host=self.app.config['MYSQL_HOST'],
                user=self.app.config['MYSQL_USER'],
                password=self.app.config['MYSQL_PASSWORD'],
                database=self.app.config['MYSQL_DB']
            )
        return g.mysql_db

mysql = MySQLWrapper(app)

@app.teardown_appcontext
def teardown_db(exception):
    db = g.pop('mysql_db', None)
    if db is not None:
        db.close()



def extract_trigger_message(error: Exception) -> str:
    """Pull a clean message out of a MySQL trigger SIGNAL / error."""
    msg = str(error)
    if 'Error:' in msg:
        try:
            start = msg.index('Error:')
            return msg[start:].rstrip("\"'")
        except ValueError:
            pass
    return "A database error occurred. Please check your input and try again."




@app.route('/')
def dashboard():
    cur = mysql.connection.cursor(dictionary=True)
    cur.execute("""
        SELECT p.Name AS patient_name, a.Date AS appointment_date,
               a.Status, a.AppointmentID
        FROM Patient p
        LEFT JOIN Appointment a ON p.PatientID = a.PatientID
        ORDER BY a.Date DESC
    """)
    rows = cur.fetchall()

    cur.execute("SELECT COUNT(*) AS cnt FROM Patient")
    total_patients = cur.fetchone()['cnt']

    cur.execute("SELECT COUNT(*) AS cnt FROM Doctor")
    total_doctors = cur.fetchone()['cnt']

    cur.execute("SELECT COUNT(*) AS cnt FROM Appointment WHERE Status = 'Scheduled'")
    scheduled = cur.fetchone()['cnt']

    cur.execute("SELECT COUNT(*) AS cnt FROM Appointment WHERE Status = 'In Progress'")
    in_progress = cur.fetchone()['cnt']
    cur.close()

    return render_template('dashboard.html',
                           rows=rows,
                           total_patients=total_patients,
                           total_doctors=total_doctors,
                           scheduled=scheduled,
                           in_progress=in_progress)


@app.route('/doctors')
def doctors():
    cur = mysql.connection.cursor(dictionary=True)
    cur.execute("""
        SELECT d.DoctorID, d.Name AS doctor_name, d.PhoneNumber,
               d.Address, dep.Name AS department_name
        FROM Doctor d
        INNER JOIN Department dep ON d.DepartmentID = dep.DepartmentID
        ORDER BY dep.Name, d.Name
    """)
    rows = cur.fetchall()
    cur.close()
    return render_template('doctors.html', doctors=rows)


@app.route('/patients', methods=['GET', 'POST'])
def patients():
    error_msg  = None
    success_msg = None

    if request.method == 'POST':
        pid    = request.form.get('patient_id', '').strip()
        name   = request.form.get('name', '').strip()
        phone  = request.form.get('phone', '').strip()
        addr   = request.form.get('address', '').strip()
        bdate  = request.form.get('birth_date', '').strip() or None
        job    = request.form.get('job', '').strip()

        if not pid or not name:
            error_msg = "Patient ID and Name are required fields."
        else:
            try:
                cur = mysql.connection.cursor(dictionary=True)
                cur.execute("""
                    INSERT INTO Patient (PatientID, Name, PhoneNumber, Address, BirthDate, Job)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """, (pid, name, phone, addr, bdate, job))
                mysql.connection.commit()
                cur.close()
                success_msg = f"Patient '{name}' added successfully."
            except mysql_driver.Error as e:
                mysql.connection.rollback()

                if e.errno == 1062:
                    error_msg = f"Patient ID {pid} already exists. Please use a unique ID."
                else:
                    error_msg = extract_trigger_message(e)


    cur = mysql.connection.cursor(dictionary=True)
    search = request.args.get('search', '').strip()
    if search:
        cur.execute("""
            SELECT * FROM Patient
            WHERE Name LIKE %s OR PatientID = %s
            ORDER BY Name
        """, (f'%{search}%', search if search.isdigit() else -1))
    else:
        cur.execute("SELECT * FROM Patient ORDER BY Name")
    rows = cur.fetchall()
    cur.close()

    return render_template('patients.html',
                           patients=rows,
                           error_msg=error_msg,
                           success_msg=success_msg,
                           search=search)


@app.route('/appointments', methods=['GET', 'POST'])
def appointments():
    error_msg   = None
    success_msg = None

    if request.method == 'POST':
        appt_id    = request.form.get('appointment_id', '').strip()
        new_status = request.form.get('new_status', '').strip()

        allowed = {'Scheduled', 'In Progress', 'Postponed'}
        if new_status not in allowed:
            error_msg = f"Invalid status '{new_status}'. Must be one of: {', '.join(allowed)}."
        else:
            try:
                cur = mysql.connection.cursor(dictionary=True)
                cur.execute("""
                    UPDATE Appointment SET Status = %s
                    WHERE AppointmentID = %s
                """, (new_status, appt_id))
                mysql.connection.commit()
                cur.close()
                success_msg = f"Appointment #{appt_id} updated to '{new_status}'."
            except mysql_driver.Error as e:
                mysql.connection.rollback()
 
                error_msg = extract_trigger_message(e)

 
    cur = mysql.connection.cursor(dictionary=True)
    cur.execute("""
        SELECT a.AppointmentID, a.Date, a.StartTime, a.EndTime,
               a.Cost, a.Status, a.Diagnosis,
               p.Name AS patient_name,
               d.Name AS doctor_name
        FROM Appointment a
        JOIN Patient p  ON a.PatientID  = p.PatientID
        JOIN Doctor  d  ON a.DoctorID   = d.DoctorID
        ORDER BY a.Date DESC, a.StartTime DESC
    """)
    rows = cur.fetchall()
    cur.close()

    return render_template('appointments.html',
                           appointments=rows,
                           error_msg=error_msg,
                           success_msg=success_msg)


if __name__ == '__main__':
    app.run(debug=True)