What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg




----------------------------------------------------------------------
WITH UniqueCounts AS (
    SELECT 
        COUNT(DISTINCT product_code) AS unique_products_2020
    FROM 
        fact_gross_price 
    WHERE 
        fiscal_year = 2020
),
UniqueCounts2021 AS (
    SELECT 
        COUNT(DISTINCT product_code) AS unique_products_2021
    FROM 
        fact_gross_price 
    WHERE 
        fiscal_year = 2021
)
SELECT 
    UniqueCounts.unique_products_2020,
    UniqueCounts2021.unique_products_2021,
    ((UniqueCounts2021.unique_products_2021 - UniqueCounts.unique_products_2020) / UniqueCounts.unique_products_2020) * 100 AS percentage_chg
FROM 
    UniqueCounts, UniqueCounts2021;
