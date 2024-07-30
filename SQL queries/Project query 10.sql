/* 10 .Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 
       The final output contains these fields,
	                                       division 
                                               product_code
					       product 
					       total_sold_quantity
					       rank_order                      */


WITH  sold_quantity AS
	(SELECT  p.division, p.product_code, concat(p.product, ' ( ', p.variant, ' )') AS product, 
	 SUM(s.sold_quantity) AS total_sold_quantity
	FROM fact_sales_monthly s
	JOIN dim_product P
	ON s.product_code = p.product_code
	WHERE s.fiscal_year = 2021
	GROUP BY p.division, p.product_code , p.product,p.variant
	ORDER BY total_sold_quantity) 
    ,
	sold_quantity_per_divison AS
	 (SELECT *,
		       DENSE_RANK () OVER (partition by division  order by total_sold_quantity DESC) AS rank_order
	  FROM sold_quantity )

SELECT * 
FROM sold_quantity_per_divison  
WHERE rank_order<=3 
