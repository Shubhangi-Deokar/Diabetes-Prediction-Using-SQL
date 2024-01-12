Select * from [dbo].[DBS];


/* Que.1) Retrieve the Patient_id and ages of all patients*/

Select Patient_id, age
From [dbo].[DBS];


/* Que.2) Select all female patients who are older than 40.*/

Select EmployeeName, Patient_id, gender, age
From [dbo].[DBS]
Where gender = 'Female' and age > 40;


/* Que.3) Calculate the average BMI of patients*/

Select AVG(bmi) as Average_bmi
From [dbo].[DBS];


/* Que.4) List patients in descending order of blood glucose levels */

Select EmployeeName, Patient_id, blood_glucose_level
From [dbo].[DBS]
order by blood_glucose_level desc;


/* Que.5) Find patients who have hypertension and diabetes.*/

Select EmployeeName, Patient_id, hypertension, diabetes
From [dbo].[DBS]
Where hypertension = '1' and diabetes = '1';


/* Que.6) Determine the number of patients with heart disease.*/

Select Count(EmployeeName) as Patients_With_Heart_Disease
From [dbo].[DBS]
Where heart_disease = '1';


/* Que.7) Group patients by smoking history and count how many smokers and non-smokers there are.*/

Select smoking_history, count(smoking_history) as Patient_Count
From [dbo].[DBS]
Group by smoking_history;


/* Que.8) Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.*/

Select EmployeeName, Patient_id, bmi
From [dbo].[DBS]
Where bmi > (Select AVG(bmi) FROM [dbo].[DB]);


/* Que.9) Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.*/

Select TOP 1 WITH TIES EmployeeName, Patient_id, HbA1c_level
From [dbo].[DBS]
ORDER BY HbA1c_level DESC;


Select TOP 1 WITH TIES EmployeeName, Patient_id, HbA1c_level
From [dbo].[DBS]
ORDER BY HbA1c_level ASC;


/* Que.10) Calculate the age of patients in years (assuming the current date as of now).*/

SELECT EmployeeName, Patient_id, age,
DATEADD(YEAR, -age, GETDATE()) AS approximate_dob
FROM [dbo].[DBS];


/* Que.11) Rank patients by blood glucose level within each gender group */

Select EmployeeName, Patient_id, gender, blood_glucose_level,
	Rank () Over(Partition by Gender Order by blood_glucose_level Desc) as Glucose_Level_Rank
FROM [dbo].[DBS];


/* Que.12) Update the smoking history of patients who are older than 50 to "Ex-smoker." */

Update [dbo].[DBS] 
Set smoking_history = 'Ex-smoker'
Where age > 50;

/* To Check if data is updated*/

Select EmployeeName, Patient_id, age, smoking_history
from [dbo].[DBS]
Where age > 50;


/* Que.13) Insert a new patient into the database with sample data. */

Insert into [dbo].[DBS]
Values ('ROBIN SHARMA', 'PT100101', 'Male', 28, 0, 0, 'never', 38.17, 3.52, 95, 0);

/* To Check if new patient is inserted in Data*/

Select *
From [dbo].[DBS]
Where Patient_id = 'PT100101';


/* Que.14) Delete all patients with heart disease from the database */

Delete from [dbo].[DBS]
Where heart_disease = 1;

/* To Check if we have deleted all patients with heart disease*/

Select *
From [dbo].[DBS]
Where heart_disease = 1;


/* Que.15) Find patients who have hypertension but not diabetes using the EXCEPT operator. */

Select EmployeeName, Patient_id, hypertension, diabetes
From [dbo].[DBS]
Where hypertension = 1 

Except

Select EmployeeName, Patient_id, hypertension, diabetes
From [dbo].[DBS]
Where diabetes = 1;


/* Que.16) Define a unique constraint on the "patient_id" column to ensure its values are unique.*/

Alter Table [dbo].[DBS]
Add Constraint unique_patient_id UNIQUE (patient_id);


/* Que.17) Create a view that displays the Patient_ids, ages, and BMI of patients.*/

CREATE VIEW Patient_info
As
Select Patient_id, age, bmi
From [dbo].[DBS];

/* To Check if table has been created or not. */

Select * from Patient_info;


/* Que.18) Suggest improvements in the database schema to reduce data redundancy and improve data integrity. 

1) Normalize tables into third normal form (3NF) by splitting large tables into smaller ones, minimizing redundant data storage.

2) Use proper data types and constraints 

3) Use Foreign keys  and Joins to establish relationships.

4)  Indexing: Create indexes on columns frequently used in queries to improve      query performance.

5) Remove unused data

6) Regular Maintenance: Schedule regular database maintenance to remove unnecessary data, optimize indexes, and ensure smooth operation.*/



/* Que.19) Explain how you can optimize the performance of SQL queries on this dataset. 

1. Limit the Number of Rows Returned:-
Use the LIMIT clause to restrict the number of rows returned, especially when working with
large datasets. It significantly enhances query response times.
2. Implement Indexing:-
Create indexes on columns frequently used in WHERE clauses and join conditions. This can
significantly speed up query execution.
3. Optimize JOIN Operations:-
Be mindful of how you structure your joins. Selecting appropriate join types(INNER, LEFT, etc.)
based on specific requirements.
4. Avoid Unnecessary SELECT :-
Instead of using SELECT *, explicitly list only the columns you need. This reduces the amount
of data transferred and can improve query performance.
5. Effective Utilization of  WHERE Clauses :-
Filter rows as early as possible in the query execution process by using efficient WHERE
clauses. Avoid unnecessary conditions.
6. Partitioning:-
If your dataset is large, consider partitioning tables based on certain criteria (e.g., date ranges).
This can improve query performance by narrowing the scope of data to be searched.
7. Use Stored Procedures:-
Use stored procedures to encapsulate and optimize frequently executed */