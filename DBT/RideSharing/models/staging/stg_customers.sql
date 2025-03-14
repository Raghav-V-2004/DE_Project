WITH COPYTABLE AS (
    SELECT * FROM {{ source('dbo', 'customers') }}
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
       
        COMPANY,
        CUSTOMERNAME
    FROM dropping_null_values
)
SELECT * FROM datatype_conversion