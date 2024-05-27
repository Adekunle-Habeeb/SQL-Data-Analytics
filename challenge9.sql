Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage



-------------------------------------------------------------------
WITH SalesData AS (
    SELECT
        dc.channel,
        SUM(fsm.sold_quantity * fgp.gross_price) AS gross_sales
    FROM
        fact_sales_monthly fsm
    JOIN
        dim_customer dc ON fsm.customer_code = dc.customer_code
    JOIN
        fact_gross_price fgp ON fsm.product_code = fgp.product_code
            AND fsm.date = fgp.date
    WHERE
        YEAR(fsm.date) = 2021
    GROUP BY
        dc.channel
),
TotalSales AS (
    SELECT
        SUM(gross_sales) AS total_gross_sales
    FROM
        SalesData
)
SELECT
    sd.channel,
    ROUND(sd.gross_sales / 1e6, 2) AS gross_sales_mln,
    ROUND((sd.gross_sales / ts.total_gross_sales) * 100, 2) AS percentage
FROM
    SalesData sd,
    TotalSales ts
ORDER BY
    sd.gross_sales DESC
LIMIT 1;

