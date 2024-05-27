Get the products that have the highest and lowest manufacturing costs.
The final output should contain these fields,
product_code
product
manufacturing_cost


------------------------------------------------------------------------
WITH CostExtremes AS (
    SELECT 
        MIN(fmc.manufacturing_cost) AS min_cost,
        MAX(fmc.manufacturing_cost) AS max_cost
    FROM 
        fact_manufacturing_cost fmc
)


SELECT 
    dp.product_code,
    dp.product,
    fmc.manufacturing_cost
FROM 
    fact_manufacturing_cost fmc
JOIN 
    dim_product dp ON fmc.product_code = dp.product_code
JOIN 
    CostExtremes ce ON fmc.manufacturing_cost = ce.min_cost OR fmc.manufacturing_cost = ce.max_cost;
