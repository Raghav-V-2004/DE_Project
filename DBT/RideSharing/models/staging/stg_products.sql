WITH COPYTABLE AS (
    SELECT * FROM {{ source('dbo', 'products') }}
),
dropping_null_values AS (
    SELECT 
        *
    FROM 
        COPYTABLE
    WHERE
        product_id IS NOT NULL
)


SELECT * FROM dropping_null_values