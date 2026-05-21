SELECT ROUND(Sum(amount),2) AS total_ingresos,DATE(timestamp) AS Fecha 
FROM `sprint3-analytics-irina.Sprint3_bronze.transactions_raw`
WHERE EXTRACT(YEAR FROM DATE(timestamp)) =2021
GROUP BY Fecha 
ORDER BY total_ingresos DESC
LIMIT 5;