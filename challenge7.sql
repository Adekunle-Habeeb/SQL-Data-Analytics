Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount



SELECT
    year_FORMAT(fsm.year, '%M') AS Month,
    YEAR(fsm.year) AS Year,
    ROUND(SUM(fsm.sold_quantity * fgp.gross_price), 2) AS Gross_sales_Amount
FROM
    fact_sales_monthly fsm
JOIN
    dim_customer dc ON fsm.customer_code = dc.customer_code
JOIN
    fact_gross_price fgp ON fsm.product_code = fgp.product_code AND fsm.year = fgp.year
WHERE
    dc.customer = 'Atliq Exclusive'
GROUP BY
    year_FORMAT(fsm.year, '%M'),
    YEAR(fsm.year)
ORDER BY
    YEAR(fsm.year),
    MONTH(fsm.year);
