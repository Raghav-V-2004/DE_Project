{{
    config(
        tags=['basic', 'staging']
    )
}}

WITH

datatype_conversion AS (

    SELECT 

    CAST(customer_id AS INT)    AS customer_id,
    country,
    region
    

    FROM {{ source('dbo', 'country') }}

)

select * from datatype_conversion
