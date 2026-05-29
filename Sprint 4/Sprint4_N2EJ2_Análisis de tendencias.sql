
-- 
SELECT 
  sales_date AS Data,
  total_sales AS Vendes_Avui,
  LAG(total_sales) OVER (ORDER BY sales_date) AS Vendes_Ahir,
  ROUND(
    (total_sales - LAG(total_sales) OVER (ORDER BY sales_date)) 
    / LAG(total_sales) OVER (ORDER BY sales_date) * 100, 
    2
  ) AS Diff_Percentual
FROM `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`
ORDER BY sales_date;

-- Version Optimizada 
WITH Sales_With_Lag AS (
  SELECT 
    sales_date,
    total_sales,
    LAG(total_sales) OVER (ORDER BY sales_date) AS prev_day_sales
  FROM `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`
)
SELECT 
  sales_date AS Data,
  total_sales AS Vendes_Avui,
  prev_day_sales AS Vendes_Ahir,
  ROUND(
    (total_sales - prev_day_sales) / prev_day_sales * 100, 
    2
  ) AS Diff_Percentual
FROM Sales_With_Lag
ORDER BY sales_date;

--
