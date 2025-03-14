SELECT
    timeperiod,
    SUM(revenue) AS current_revenue,
    SUM(previous_revenue) AS previous_revenue,
 
    CASE WHEN SUM(previous_revenue) > 0
         THEN LEAST(SUM(revenue), SUM(previous_revenue)) / SUM(previous_revenue)
         ELSE NULL END AS gross_retention_rate,
 
    CASE WHEN SUM(previous_revenue) > 0
         THEN SUM(revenue) / SUM(previous_revenue)
         ELSE NULL END AS net_retention_rate
FROM {{ref('transform_nrr_grr')}}
WHERE previous_revenue IS NOT NULL
GROUP BY timeperiod
ORDER BY timeperiod