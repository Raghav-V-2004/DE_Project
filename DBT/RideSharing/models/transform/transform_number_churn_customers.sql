WITH ADDYEAR AS (
    SELECT customer_id, SUBSTRING(payment_month, 7, 4) AS paymentyear, revenue_type, companies 
    FROM {{ ref('stg_transactions') }} 
    WHERE revenue_type = 1
),
addrank AS (
    SELECT customer_id, paymentyear, companies, 
           DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY paymentyear ASC) AS ranking 
    FROM ADDYEAR
),
findmaxrank AS (
    SELECT customer_id,  MAX(ranking) AS ranking 
    FROM addrank 
    GROUP BY customer_id
),
comparewithfiscal AS (
    SELECT DISTINCT customer_id, customername, fiscalyear 
    FROM {{ ref('transform_kpi_5') }} 
    ORDER BY fiscalyear
),
joinedone AS (
    SELECT f.customer_id,ranking,customername,fiscalyear
    FROM findmaxrank f 
    JOIN comparewithfiscal c ON f.customer_id = c.customer_id 
    
)

SELECT * FROM joinedone
