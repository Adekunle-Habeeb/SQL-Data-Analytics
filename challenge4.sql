Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference



----------------------------------------------------------------------
WITH ProductCounts2020 AS (
    SELECT 
        dp.segment,
        COUNT(DISTINCT fs.product_code) AS product_count_2020
    FROM 
        fact_sales_monthly fs
    JOIN 
        dim_product dp ON fs.product_code = dp.product_code
    WHERE 
        fs.fiscal_year = 2020
    GROUP BY 
        dp.segment
),


ProductCounts2021 AS (
    SELECT 
        dp.segment,
        COUNT(DISTINCT fs.product_code) AS product_count_2021
    FROM 
        fact_sales_monthly fs
    JOIN 
        dim_product dp ON fs.product_code = dp.product_code
    WHERE 
        fs.fiscal_year = 2021
    GROUP BY 
        dp.segment
)


SELECT 
    pc2020.segment,
    pc2020.product_count_2020,
    pc2021.product_count_2021,
    (pc2021.product_count_2021 - pc2020.product_count_2020) AS difference
FROM 
    ProductCounts2020 pc2020
JOIN 
    ProductCounts2021 pc2021 ON pc2020.segment = pc2021.segment
ORDER BY 
    difference DESC;
