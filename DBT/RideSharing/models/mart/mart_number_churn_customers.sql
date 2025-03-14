select sum(
        CASE 
            WHEN ranking = 3 AND fiscalyear = '2018' THEN +0
            WHEN ranking = 2 AND fiscalyear = '2019' THEN +0
            WHEN ranking = 1 AND fiscalyear = '2020' THEN +0
            ELSE +1
        END
    ) AS numberofchurnedcustomer from {{ref('transform_number_churn_customers')}}