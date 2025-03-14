WITH table1 as(
select  distinct customer_id,customername,fiscalyear from {{ ref('transform_kpi_5') }} order by fiscalyear
),
NumberOflogos as(
    select fiscalyear,count(customer_id) as NumberOfLogos from table1 group by fiscalyear
)
select * from NumberOfLogos