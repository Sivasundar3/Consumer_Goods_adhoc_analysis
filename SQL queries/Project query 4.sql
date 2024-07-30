/* 4. Follow-up: Which segment had the most increase in unique productsin 2021 vs 2020? The final output contains these fields,
					     segment 
						 product_count_2020 
						 product_count_2021
						 difference              */

WITH CTE AS
	 (SELECT p.segment,
		 COUNT(DISTINCT
		 (CASE WHEN s.fiscal_year = 2020 THEN p.product_code END)) 
		 as product_code_2020 ,
		 COUNT(DISTINCT
		 (CASE WHEN s.fiscal_year = 2021 THEN p.product_code END)) 
		 as product_code_2021
	FROM gdb023.fact_sales_monthly s
	JOIN gdb023.dim_product p
	ON s.product_code = p.product_code
	GROUP BY p.segment)
    
SELECT *, (product_code_2021 - product_code_2020) as difference
FROM CTE
ORDER BY difference DESC ;
    