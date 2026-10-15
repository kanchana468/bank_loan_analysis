-- Total approved Rejected Approval rate 
SELECT
    COUNT(*) AS total_applications,
    SUM(TRIM(loan_status) = 'Approved') AS approved_applications,
    SUM(TRIM(loan_status) = 'Rejected') AS rejected_applications,
    ROUND(
        100.0 * SUM(TRIM(loan_status) = 'Approved')
        / COUNT(*), 2
    ) AS approval_rate_percentage
FROM banking;

-- Application by education

SELECT
    education,
    COUNT(*) AS total_applications
FROM banking
GROUP BY education
ORDER BY total_applications DESC;

-- Approval and rejection by education

SELECT
    education,
    TRIM(loan_status) AS loan_status,
    COUNT(*) AS applications
FROM banking
GROUP BY education, TRIM(loan_status)
ORDER BY education, loan_status;

-- Approval and rejection by employment

SELECT
    self_employed,
    TRIM(loan_status) AS loan_status,
    COUNT(*) AS applications
FROM banking
GROUP BY self_employed, TRIM(loan_status)
ORDER BY self_employed, loan_status;

-- Average income by loan status

SELECT
    TRIM(loan_status) AS loan_status,
    ROUND(AVG(income_annum), 2) AS average_annual_income
FROM banking
GROUP BY TRIM(loan_status);

-- Average loan amount by status

SELECT
    TRIM(loan_status) AS loan_status,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM banking
GROUP BY TRIM(loan_status);

-- . Applications by CIBIL score group

SELECT
    CASE
        WHEN cibil_score < 600 THEN 'Below 600'
        WHEN cibil_score < 700 THEN '600-699'
        WHEN cibil_score < 750 THEN '700-749'
        ELSE '750 and above'
    END AS cibil_group,
    COUNT(*) AS applications
FROM banking
WHERE cibil_score IS NOT NULL
GROUP BY cibil_group
ORDER BY MIN(cibil_score);

-- Approval and rejection by CIBIL score group

SELECT
    CASE
        WHEN cibil_score < 600 THEN 'Below 600'
        WHEN cibil_score < 700 THEN '600-699'
        WHEN cibil_score < 750 THEN '700-749'
        ELSE '750 and above'
    END AS cibil_group,
    TRIM(loan_status) AS loan_status,
    COUNT(*) AS applications
FROM banking
WHERE cibil_score IS NOT NULL
GROUP BY cibil_group, TRIM(loan_status)
ORDER BY MIN(cibil_score), loan_status;

-- Applications by number of dependents

SELECT
    no_of_dependents,
    COUNT(*) AS applications
FROM banking
GROUP BY no_of_dependents
ORDER BY no_of_dependents;

-- Applications by loan term

SELECT
    loan_term,
    COUNT(*) AS applications
FROM banking
GROUP BY loan_term
ORDER BY loan_term;

-- Average assets by loan status

SELECT
    TRIM(loan_status) AS loan_status,
    ROUND(AVG(bank_asset_value), 2) AS average_bank_assets,
    ROUND(AVG(residential_assets_value), 2) AS average_residential_assets,
    ROUND(AVG(commercial_assets_value), 2) AS average_commercial_assets,
    ROUND(AVG(luxury_assets_value), 2) AS average_luxury_assets
FROM banking
GROUP BY TRIM(loan_status);

-- Income compared with loan amount

SELECT
    loan_id,
    income_annum,
    loan_amount,
    ROUND(
        loan_amount / NULLIF(income_annum, 0), 2
    ) AS loan_to_annual_income_ratio,
    loan_status
FROM banking
WHERE income_annum > 0
ORDER BY loan_to_annual_income_ratio DESC
LIMIT 20;

-- Height loan amounts

SELECT
    loan_id,
    income_annum,
    loan_amount,
    cibil_score,
    loan_status
FROM banking
ORDER BY loan_amount DESC
LIMIT 10;

-- Approval percentage by education

SELECT
    education,
    COUNT(*) AS total_applications,
    SUM(TRIM(loan_status) = 'Approved') AS approved_applications,
    ROUND(
        100.0 * SUM(TRIM(loan_status) = 'Approved')
        / COUNT(*), 2
    ) AS approval_percentage
FROM banking
GROUP BY education;


