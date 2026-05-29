
-- Vista Materiallizada 
CREATE MATERIALIZED VIEW `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`
AS
SELECT 
  DATE(timestamp) AS sales_date,
  COUNT(*) AS total_transactions,
  SUM(amount) AS total_sales,
  AVG(amount) AS average_sale,
  MIN(amount) AS min_sale,
  MAX(amount) AS max_sale
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized`
GROUP BY DATE(timestamp)
ORDER BY sales_date;

-- Consulta vista materializada
SELECT *
FROM `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`
ORDER BY sales_date DESC
LIMIT 10;

-- Comparación Vista  Vista Normal


SELECT 
  DATE(timestamp) AS sales_date,
  SUM(amount) AS total_sales
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized`
GROUP BY DATE(timestamp);

-- VS Vista Materializada
SELECT * FROM `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`;