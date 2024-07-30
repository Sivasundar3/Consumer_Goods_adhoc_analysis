/* 9.Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? 
     The final output contains these fields, 
										    channel ,
											gross_sales_mln,
										    percentage           */



WITH sales AS
	(SELECT c.channel, 
		   (ROUND(SUM(g.gross_price * s.sold_quantity)/1000000,2)) As Gross_sales_mln
	FROM fact_sales_monthly s
	JOIN fact_gross_price g 
	ON s.product_code = g.product_code AND
	   s.fiscal_year = g.fiscal_year
	JOIN dim_customer c
	ON c.customer_code = s.customer_code
	WHERE s.fiscal_year = 2021
	GROUP BY c.channel 
	ORDER BY gross_sales_mln DESC )
    
SELECT *,
   ROUND((gross_sales_mln / SUM(gross_sales_mln) over()*100),2) AS percentage
FROM sales    