
-- 
CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_gold.dim_transactions_flat` AS
SELECT 
  t.transaction_id,
  t.timestamp,
  t.total_amount AS total_ticket,
  p.sku AS product_sku,
  p.name AS product_name,
  p.price AS product_price
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized` AS t
CROSS JOIN UNNEST(t.product_ids) AS product_id
JOIN `sprint3-analytics-irina.sprint3_gold.products` AS p
  ON CAST(product_id AS STRING) = p.sku;

