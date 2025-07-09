DROP TABLE IF EXISTS users6;

CREATE TABLE users6(
Hospital_Name VARCHAR(50),
location VARCHAR(50),
Department  VARCHAR(30),
Doctors_Count INT,
Patients_Count INT,
Admission_Date DATE,
Discharge_Date DATE,
Medical_Expenses NUMERIC(10,2)
);

SELECT * FROM users6;

-- Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM(patients_count) AS total_patients 
FROM users6;

--Retrieve the average count of doctors available in each hospital.
SELECT hospital_name , AVG(doctors_count) AS Avg_count 
FROM users6
GROUP BY hospital_name;

-- Find the top 3 hospital departments that have the highest number of patients. 
SELECT hospital_name, department , patients_count
FROM users6
ORDER BY patients_count DESC
LIMIT 3;

--Identify the hospital that recorded the highest medical expenses.
SELECT hospital_name , medical_expenses 
FROM users6
ORDER BY medical_expenses DESC
LIMIT 1;

--Calculate the average medical expenses per day for each hospital. 
SELECT 
    hospital_name,
    AVG(medical_expenses / GREATEST(discharge_date - admission_date, 1)) AS avg_expense_per_day
FROM users6
GROUP BY hospital_name;


-- Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date. 
SELECT admission_date , discharge_date ,
	(discharge_date-admission_date) AS stay_of_patients
FROM users6
ORDER BY stay_of_patients DESC
LIMIT 1;

--Count the total number of patients treated in each city. 
SELECT location AS city,
    SUM(patients_count) AS total_patients
FROM users6
GROUP BY location;

--Calculate the average number of days patients spend in each department. 
ALTER TABLE users6
ADD COLUMN stay_of_patients INT;

UPDATE users6
SET stay_of_patients = discharge_date-admission_date;

SELECT * FROM users6

SELECT department , 
AVG(stay_of_patients) AS avg_day_in_department
FROM users6
GROUP BY department;

--Find the department with the least number of patients. 
SELECT department, SUM(patients_count) AS total_patients
FROM users6
GROUP BY department
ORDER BY total_patients ASC
LIMIT 1;

--Group the data by month and calculate the total medical expenses for each month. 
SELECT TO_CHAR(admission_date, 'YYYY-MM') AS month,
    SUM(medical_expenses) AS total_expenses
FROM users6
GROUP BY TO_CHAR(admission_date, 'YYYY-MM')
ORDER BY month;


