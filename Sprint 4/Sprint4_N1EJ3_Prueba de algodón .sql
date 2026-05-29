-- Dry Run en la tabla original
SELECT C.country, DATE(T.timestamp) AS date
FROM `sprint3-analytics-irina.Sprint3_bronze.transactions_raw_native` AS T
JOIN `sprint3-analytics-irina.Sprint3_bronze.companies_raw` AS C
ON T.business_id = C.company_id
WHERE C.country = 'Germany'
AND DATE(T.timestamp) = '2022-03-12';

-- Dry Run en la tabla optimizada
SELECT business_id, timestamp, amount
FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized`
WHERE DATE(timestamp) = DATE_SUB(CURRENT_DATE(), INTERVAL 10 DAY)
AND business_id = 'TU_ID_DE_EMPRESA';