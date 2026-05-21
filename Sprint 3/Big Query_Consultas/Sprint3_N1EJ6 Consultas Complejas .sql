SELECT C.company_name , C.country, T.timestamp
FROM `sprint3-analytics-irina.Sprint3_bronze.transactions_raw` AS T
JOIN `sprint3-analytics-irina.Sprint3_bronze.companies_raw` AS C
ON T.business_id=C.company_id
WHERE T.amount BETWEEN 100 AND 200
AND DATE(timestamp) IN (
DATE ('2015-04-29'),
DATE('2018-07-20'),
DATE ('2024-03-13')
)
ORDER BY T.timestamp ASC;


