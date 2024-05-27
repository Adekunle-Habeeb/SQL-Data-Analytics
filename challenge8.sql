In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity



-------------------------------------------------------------------------
WITH SalesWithQuarters AS (
    SELECT
        fsm.date,
        fsm.sold_quantity,
        CASE
            WHEN MONTH(fsm.date) IN (9, 10, 11) THEN 'Q1'
            WHEN MONTH(fsm.date) IN (12, 1, 2) THEN 'Q2'
            WHEN MONTH(fsm.date) IN (3, 4, 5) THEN 'Q3'
            WHEN MONTH(fsm.date) IN (6, 7, 8) THEN 'Q4'
        END AS Quarter,
        YEAR(fsm.date) AS Year
    FROM
        fact_sales_monthly fsm
    JOIN
        dim_customer dc ON fsm.customer_code = dc.customer_code
    WHERE
        dc.customer = 'Atliq Exclusive'
)

SELECT
    Quarter,
    SUM(sold_quantity) AS total_sold_quantity
FROM
    SalesWithQuarters
WHERE
    Year = 2020
GROUP BY
    Quarter
ORDER BY
    total_sold_quantity DESC
LIMIT 1;