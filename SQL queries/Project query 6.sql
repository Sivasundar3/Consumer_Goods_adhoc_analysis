/* 6. Generate a report which contains the top 5 customers who received an 
   average high pre_invoice_discount_pct for the fiscal year 2021 
   and in the Indian market. 
   The final output contains these fields,
   customer_code 
   customer 
   average_discount_percentage  */
  
 WITH CTE AS 
   (SELECT c.customer_code ,c.customer, pre.pre_invoice_discount_pct,
         (SELECT ROUND(AVG(pre_invoice_discount_pct),3)
          FROM fact_pre_invoice_deductions) As average_discount_pct1
  FROM dim_customer c
  JOIN fact_pre_invoice_deductions pre
  ON c.customer_code = pre.customer_code
  WHERE c.market = "India" AND pre.fiscal_year = 2021)
  
 SELECT customer_code, customer,
        ROUND((pre_invoice_discount_pct *100),2) AS average_discount_pct
 FROM CTE
 WHERE pre_invoice_discount_pct > average_discount_pct1
 ORDER BY pre_invoice_discount_pct DESC
 LIMIT 5
  