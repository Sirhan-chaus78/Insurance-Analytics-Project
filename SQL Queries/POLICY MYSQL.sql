create database Policy_insurance;
use policy_insurance;
show tables;

select * from additional_fields;
select * from claims;
select * from customer_information;
select * from payment_history;
select * from policy_details;


#1:------- TOTAL POLICYES------#

SELECT 
    COUNT(*) AS total_policies
FROM 
    policy_details;


#2:------TOTAL CUSTOMERS------#

SELECT 
    COUNT(DISTINCT customer_id) AS total_customers
FROM 
    customer_information;


#3:------TOTAL CLAIMS------#

SELECT 
    CONCAT(FORMAT(SUM(claim_amount) / 1000000, 0), 'M') AS total_claim_amount
FROM 
    claims;


#4:------AGE BUCKET WISE POLICY COUNT------#

ALTER TABLE customer_information
ADD COLUMN age_bucket VARCHAR(50);

UPDATE customer_information
SET age_bucket = CASE
    WHEN age < 18 THEN 'Under 18'
    WHEN age BETWEEN 18 AND 25 THEN '18-25'
    WHEN age BETWEEN 26 AND 35 THEN '26-35'
    WHEN age BETWEEN 36 AND 50 THEN '36-50'
    WHEN age BETWEEN 51 AND 65 THEN '51-65'
    ELSE 'Above 65'
END;
SELECT age_bucket, COUNT(*) AS policy_count
FROM customer_information
GROUP BY age_bucket;


#5:------Gender Wise Policy Count------#

SELECT 
    gender,
    COUNT(*) AS policy_count
FROM 
    customer_information
GROUP BY 
    gender;

#6:------Policy Type Wise Policy Count------#

SELECT 
    policy_type,
    COUNT(*) AS policy_count
FROM 
    policy_details
GROUP BY 
    policy_type;


#7:------Policy Expire This Year------#

SELECT 
    COUNT(*) AS policies_expiring
FROM 
    policy_details
WHERE 
    YEAR(policy_end_date) = YEAR(CURDATE());

SELECT YEAR(Policy_End_Date) AS policy_end_year, COUNT(policy_id) AS policy_count FROM policy_details
GROUP BY YEAR(Policy_End_Date);

SELECT 
    COUNT(*) AS policies_expiring
FROM 
    policy_details
WHERE 
    YEAR(policy_end_date) = 2024;


#8:------ Premium Growth Rate------#

SELECT 
    (SUM(premium_current_year) - SUM(premium_previous_year)) / SUM(premium_previous_year) * 100 AS premium_growth_rate
FROM 
    premium_table;

SELECT 
    YEAR(policy_start_date) AS policy_year,
    ROUND((SUM(Premium_Amount) / (SELECT SUM(Premium_Amount) FROM policy_details)) * 100, 2) AS growth_rate
FROM 
    policy_details
GROUP BY 
    YEAR(policy_start_date);


#9:------Claim Status-Wise Policy Count------#

SELECT 
    claim_status,
    COUNT(*) AS policy_count
FROM 
    claims
GROUP BY 
    claim_status;


#10:------Payment Status-Wise Policy Count------#
SELECT 
    payment_status,
    COUNT(*) AS policy_count
FROM 
    payment_history
GROUP BY 
    payment_status;






