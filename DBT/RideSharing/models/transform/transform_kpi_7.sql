SELECT 
    a.customer_id,
    a.Total_Sum,
    a.ranking,
   
    p.company,
    p.CUSTOMERNAME
FROM (
    SELECT 
        total.customer_id,
        total.Total_Sum,
        RANK() OVER (ORDER BY total.Total_Sum DESC) AS ranking
    FROM (
        SELECT 
            customer_id,
            SUM(REVENUE) AS Total_Sum
        FROM {{ ref('stg_transactions') }}
        GROUP BY customer_id
    ) total
) a
JOIN {{ ref('stg_customers') }} p ON a.customer_id = p.customer_id 