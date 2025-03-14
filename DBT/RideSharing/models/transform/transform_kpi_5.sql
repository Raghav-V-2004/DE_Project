WITH COPY_TABLE1 AS(
    select * from {{ref('stg_transactions')}}
),
COPY_TABLE2 AS(
    select * from {{ref('stg_customers')}}
)
,joining AS (
    SELECT COPY_TABLE1.customer_id, COPY_TABLE1.revenue_type,COPY_TABLE1.companies, SUBSTRING(COPY_TABLE1.payment_month, 7, 4) AS paymentyear
    FROM COPY_TABLE1 
    
)
,grouping as(
    select customer_id,min(paymentyear) as fiscalyear from joining where revenue_type=1 group by customer_id
)
,grouped as(
    select customername,COPY_TABLE2.customer_id,fiscalyear from grouping join COPY_TABLE2 on grouping.customer_id=COPY_TABLE2.customer_id
)
SELECT * FROM GROUPED