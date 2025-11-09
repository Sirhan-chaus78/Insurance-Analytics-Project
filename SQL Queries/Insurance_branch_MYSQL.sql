create database Branch_insurance;
use Branch_insurance;


-- SQL (INSURANCE PROJECT)
SELECT opportunity_name, revenue_amount    -- TOP 5 OPEN OPPORTUNITY
FROM opportunity
ORDER BY revenue_amount DESC
LIMIT 5;

SELECT opportunity_name, revenue_amount      -- TOP 4 OPPORTUNITY BY REVENUE
FROM opportunity
ORDER BY revenue_amount DESC
LIMIT 4;

SELECT product_group, COUNT(opportunity_name) AS opportunity_count     -- OPPORTUNITY-PRODUCT GROUP
FROM opportunity
GROUP BY product_group order by opportunity_count desc;


SELECT Stage, sum(revenue_amount)     -- STAGE FUNNEL BY REVENUE
FROM opportunity
Group by stage;


select count(stage) as Total_Opportunity  -- TOTAL OPPORTUNITY
from opportunity;
     
     
     select count(stage) as Total_Open_Opportunity  -- TOTAL OPEN OPPORTUNITY
     from opportunity
     where stage not in ('negotiate');
     
select meeting_date as year, count(meeting_date) as MeetingCount   -- YEAR WISE MEETING COUNT
from meeting 
group by meeting_date
order by meeting_date;
      
SELECT Account_Executive, COUNT(meeting_date) AS meeting_count   -- NO OF MEETING BY ACC EXE
FROM meeting
GROUP BY account_executive;

SELECT account_executive, COUNT(invoice_date) AS invoice_count   -- NO OF INVOICE BY ACC EXE
FROM invoice
GROUP BY account_executive order by invoice_count desc;

SELECT 
    (SELECT SUM(cross_sell) FROM invoice) AS target_cross_sell,         -- TARGET AND INVOICE AMOUNT OF CROSS SELL
    (SELECT SUM(amount) 
     FROM invoice 
     WHERE income_class='cross sell')AS invoice_cross_sell;
     
     
     
     SELECT
    SUM(amount) AS Cross_Sell_achievement     -- ACHIEVEMENT AMOUNT OF CROSS SELL
FROM (
    SELECT amount
    FROM fees
    WHERE income_class='cross sell' 
    UNION ALL
    SELECT amount
    FROM brokerage
    WHERE income_class='cross sell'  
)as combined;


     SELECT 
    (SELECT SUM(new_budget) FROM indi) AS target_new,         -- TARGET AND INVOICE AMOUNT OF NEW
    (SELECT SUM(COALESCE(amount, 0)) 
     FROM invoice 
     WHERE income_class='new') AS invoice_new;
     
     SELECT
    SUM(amount) AS New_achievement                        -- ACHIEVEMENT AMOUNT OF NEW
FROM (
    SELECT amount
    FROM fees
    WHERE income_class='new' 
    UNION ALL
    SELECT amount
    FROM brokerage
    WHERE income_class='new'  
)as combined;
     
      SELECT 
    (SELECT SUM(renewal_budget)                   -- TARGET AND INVOICE AMOUNT OF RENEWAL
    FROM invoice) AS target_renewal,
    (SELECT SUM(COALESCE(amount, 0)) 
     FROM invoice 
     WHERE income_class='renewal') AS invoice_renewal;
     
 SELECT
    SUM(amount) AS Renewal_achievement                 -- ACHIEVEMENT AMOUNT OF RENEWAL
FROM (
    SELECT amount
    FROM fees
    WHERE income_class='renewal' 
    UNION ALL
    SELECT amount
    FROM brokerage
    WHERE incomee_class='renewal'  
)as combined;

select (13041253.3/20083111*100) as Cross_sell_Placed_Achievement;
select (2853842/20083111*100) as Cross_sell_Invoice_Achievement;

select (3531629.31/19673793*100) as New_Placed_Achievement;
select (569815/19673793*100) as New_Invoice_Achievement;

select(18507270.64/12319455*100) as Renewal_Placed_Achievemnt;
select(8244310/12319455*100) as Renewal_Invoice_Achievement;

