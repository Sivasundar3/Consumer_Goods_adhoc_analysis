/* 2. What is the percentage of unique product increase in 2021 vs. 2020?
   The final output contains these fields,
   unique_products_2020 
   unique_products_2021 
   percentage_chg #  */ 
   
  
WITH CTE AS
    (SELECT COUNT(DISTINCT(p.product_code)) AS  unique_products_2020 ,
		(SELECT COUNT(DISTINCT(p.product_code)) 
          FROM gdb023.dim_product p 
		  JOIN gdb023.fact_sales_monthly s 
		  ON  p.product_code = s.product_code
		  WHERE s.fiscal_year = 2021) AS unique_products_2021
 FROM gdb023.dim_product p 
 JOIN gdb023.fact_sales_monthly s 
 ON  p.product_code = s.product_code
 WHERE s.fiscal_year = 2020)
 
 SELECT *, 
         ROUND(((unique_products_2021 - unique_products_2020)/unique_products_2020 *100),2) As percentage_chg
 FROM CTE  