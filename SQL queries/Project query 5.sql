/* 5. Get the products that have the highest and lowest manufacturing costs.
      The final output should contain these fields, 
                                                   product_code,
                                                   product
                                                   manufacturing_cost    */

  
SELECT p.product_code, p.product,CONCAT('$ ',ROUND(m.manufacturing_cost,2)) as manufacturing_cost
FROM dim_product p
JOIN fact_manufacturing_cost m
ON p.product_code = m.product_code
WHERE m.manufacturing_cost = (SELECT MAX(manufacturing_cost) as maximum_cost
                              FROM fact_manufacturing_cost )
OR
      m.manufacturing_cost = (SELECT MIN(manufacturing_cost) as minimum_cost
                              FROM fact_manufacturing_cost)	
ORDER BY m.manufacturing_cost DESC                        
           
    
