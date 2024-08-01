/* 7 . Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. 
       This analysis helps to get an idea of low and high-performing months and take strategic decisions. 
       The final report contains these columns:
                                                Month 
					        Year
						Gross sales Amount    */
     


SELECT  monthname(s.date) as month_name, year(s.date) as year, s.fiscal_year,
       ROUND(SUM(g.gross_price * s.sold_quantity)/1000000,2) As Gross_sales_amount_mln
FROM fact_sales_monthly s JOIN fact_gross_price g ON s.product_code = g.product_code 
                          JOIN dim_customer c ON c.customer_code = s.customer_code
WHERE c.customer = "Atliq Exclusive"
GROUP BY month_name , year, s.fiscal_year
ORDER BY s.fiscal_year ;
