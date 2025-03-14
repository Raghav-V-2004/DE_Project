
WITH COPYTABLE AS (
    SELECT * FROM {{ source('dbo', 'transactions') }}
),
dropping_null_values AS (
    SELECT 
        *
    FROM 
        COPYTABLE
    WHERE
        customer_id IS NOT NULL
),
datatype_conversion AS (
    SELECT 
        CAST(customer_id AS INT) AS customer_id,
        product_id,
         PAYMENT_MONTH,
        CAST(REVENUE_TYPE AS INT) AS REVENUE_TYPE,
        CAST(REVENUE AS DECIMAL(10,2)) AS REVENUE,
        CAST(QUANTITY AS INT) AS QUANTITY,
        DIMENSION_1,
        DIMENSION_2,
        DIMENSION_3,
        DIMENSION_4,
        DIMENSION_5,
        DIMENSION_6,
        DIMENSION_7,
        DIMENSION_8,
        DIMENSION_9,
        DIMENSION_10,
        COMPANIES
    FROM dropping_null_values
)
SELECT * FROM datatype_conversion