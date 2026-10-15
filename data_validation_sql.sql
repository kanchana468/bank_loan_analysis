show DATABASEs;

use banking_application;

SHOW TABLES;

select * from banking;

-- 1. View sample records
SELECT *
FROM banking
LIMIT 10;

-- 2. Count all applications
SELECT COUNT(*) AS total_applications
FROM banking;

-- 3. Check duplicate loan IDs
SELECT loan_id, COUNT(*) AS id_count
FROM banking
GROUP BY loan_id
HAVING COUNT(*) > 1;

-- 4. Check loan statuses
SELECT DISTINCT loan_status
FROM banking;

-- 5. Count approved and rejected applications
SELECT TRIM(loan_status) AS loan_status,
       COUNT(*) AS total_applications
FROM banking
GROUP BY TRIM(loan_status);

-- 6. Check missing values
SELECT
    SUM(loan_id IS NULL) AS missing_loan_id,
    SUM(loan_status IS NULL) AS missing_status,
    SUM(cibil_score IS NULL) AS missing_cibil,
    SUM(income_annum IS NULL) AS missing_income,
    SUM(loan_amount IS NULL) AS missing_loan_amount
FROM banking;

-- 7. Check invalid loan amounts
SELECT *
FROM banking
WHERE loan_amount < 0
   OR income_annum < 0;

-- 8. Check the range of CIBIL scores
SELECT
    MIN(cibil_score) AS minimum_cibil,
    MAX(cibil_score) AS maximum_cibil,
    AVG(cibil_score) AS average_cibil
FROM banking;

