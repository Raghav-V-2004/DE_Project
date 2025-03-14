SELECT 
    a.product_id,
    a.Total_Sum,
    a.ranking,
   
    p.product_family,
    p.product_sub_family
FROM (
    SELECT 
        total.product_id,
        total.Total_Sum,
        RANK() OVER (ORDER BY total.Total_Sum DESC) AS ranking
    FROM (
        SELECT 
            product_id,
            SUM(REVENUE) AS Total_Sum
        FROM {{ ref('stg_transactions') }}
        GROUP BY product_id
    ) total
) a
JOIN {{ ref('stg_products') }} p ON a.product_id = p.product_id 