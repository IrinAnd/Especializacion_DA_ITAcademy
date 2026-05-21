CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_silver.transactions_clean` AS
SELECT
  -- 1. Estandarización de Nombres: id -> transaction_id
  id AS transaction_id,
  
  -- 2. Robustez en Imports: SAFE_CAST + IFNULL para asegurar que sea FLOAT64 o 0
  IFNULL(
    SAFE_CAST(amount AS FLOAT64), 
    0.0
  ) AS amount,
  
  -- 3. Datos Reales: de STRING a TIMESTAMP real
  SAFE_CAST(timestamp AS TIMESTAMP) AS transaction_timestamp,
  
  -- 4. Coordenadas: Asegurar lat y long como FLOAT64, de lo contrario devuelve NULL
  SAFE_CAST(lat AS FLOAT64) AS latitude,
  SAFE_CAST(longitude AS FLOAT64) AS longitude,
  
  -- 5. Desglose de Productos: Transformación  "1, 2, 3" en ARRAY<INT64>

  ARRAY(
    SELECT SAFE_CAST(x AS INT64)
    FROM UNNEST(SPLIT(TRIM(REPLACE(product_ids, ' ', '')), ',')) AS x
  ) AS product_ids_array,
  
  -- 6. Resto de campos: Mantenemos igual 
  card_id,
  business_id,
  declined,
  user_id,
FROM `sprint3-analytics-irina.Sprint3_bronze.transactions_raw`;