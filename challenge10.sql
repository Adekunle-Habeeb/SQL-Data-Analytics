Get the Top 3 products in each division that have a high
total_sold_quantity in the fiscal_year 2021? The final output contains these
fields,
division
product_code


------------------------------------------------------------------------
WITH ProductSales AS (
    SELECT
        dp.division,
        fsm.product_code,
        SUM(fsm.sold_quantity) AS total_sold_quantity
    FROM
        fact_sales_monthly fsm
    JOIN
        dim_product dp ON fsm.product_code = dp.product_code
    WHERE
        YEAR(fsm.date) = 2021
    GROUP BY
        dp.division,
        fsm.product_code
),
RankedProductSales AS (
    SELECT
        ps.division,
        ps.product_code,
        ps.total_sold_quantity,
        RANK() OVER (PARTITION BY ps.division ORDER BY ps.total_sold_quantity DESC) AS rank
    FROM
        ProductSales ps
)

SELECT
    division,
    product_code
FROM
    RankedProductSales
WHERE
    rank <= 3
ORDER BY
    division,
    rank;
