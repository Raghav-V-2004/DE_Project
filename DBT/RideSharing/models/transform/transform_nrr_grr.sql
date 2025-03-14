WITH period_revenue AS (
    SELECT
        SUBSTRING(payment_month,4,2) AS timeperiod,
        customer_id,
        product_id,
        SUM(revenue) AS revenue
    FROM {{ ref('stg_transactions') }}
    GROUP BY timeperiod ,customer_id ,product_id
),
 
retention_calc AS (
    SELECT
        timeperiod,
        customer_id,
        product_id,
        revenue,
        LAG(revenue) OVER (PARTITION BY customer_id, product_id ORDER BY timeperiod) AS previous_revenue
    FROM period_revenue
)
 
select * from retention_calc