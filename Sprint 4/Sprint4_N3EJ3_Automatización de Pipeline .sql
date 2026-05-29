
--  función de IVA (21%) de forma persistente
CREATE OR REPLACE FUNCTION `sprint3-analytics-irina.sprint3_gold.calculate_tax`(amount FLOAT64)
RETURNS FLOAT64
AS (
  amount * 1.21
);

--  La tabla plana automatizada con cálculo de impuestos

CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_gold.dim_transactions_flat` AS
SELECT 
  t.transaction_id,
  t.Sales_Timestamp AS trans_timestamp,
  t.amount AS total_ticket,
  p.product_id AS product_sku,
  p.name AS product_name,
  p.price AS product_price,
  `sprint3-analytics-irina.sprint3_gold.calculate_tax`(p.price) AS product_price_tax_inc   -- Aplicamos la UDF aquí. El resultado es el precio con IVA
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized` AS t
CROSS JOIN UNNEST(t.product_ids_array) AS pid
JOIN `sprint3-analytics-irina.sprint3_silver.products_clean` AS p
  ON CAST(pid AS INT64) = p.product_id;