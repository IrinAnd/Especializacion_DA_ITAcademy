
-- añadir año ? 
SELECT 
  sales_date AS Data,
  ROUND(total_sales, 2) AS Vendes_Dia,
  ROUND(
    SUM(total_sales) OVER (
      PARTITION BY EXTRACT(YEAR FROM sales_date)
      ORDER BY sales_date
      ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 
    2
  ) AS Vendes_Acumulades_YTD
FROM `sprint3-analytics-irina.sprint3_gold.mv_daily_sales`
ORDER BY sales_date;
