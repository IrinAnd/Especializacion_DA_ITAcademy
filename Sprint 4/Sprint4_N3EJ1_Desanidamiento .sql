CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_gold.dim_transactions_flat` AS 
SELECT 
  t.transaction_id,
  t.Sales_Timestamp AS trans_timestamp,
  t.amount AS total_ticket,
  pid AS product_sku,
  p.name AS product_name,
  p.price AS product_price
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized` AS t,
UNNEST(t.product_ids_array) AS pid  
JOIN `sprint3-analytics-irina.sprint3_silver.products_clean` AS p
  ON pid = p.product_id
WHERE pid IS NOT NULL;  