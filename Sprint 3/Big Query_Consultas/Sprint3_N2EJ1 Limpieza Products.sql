CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_silver.products_clean` AS
SELECT
  -- 1. Estandarditzación de Nombres:
  -- renombre 'id' a 'product_id'
  id AS product_id,
  
  -- Modificamos 'product_name' a 'name'
  product_name AS name,

  -- 2. Limpieza IDs (warehouse_id):
  -- Eliminem el prefix "WH-" i convertim a enter (INT64)
  -- REGEXP_EXTRACT Coge
  SAFE_CAST(REGEXP_EXTRACT(warehouse_id, r'-(\d+)') AS INT64) AS warehouse_id_clean,

  -- 3. Garantia de Preu (price):
  -- Assegurem que sigui FLOAT64. Si hi hagués símbols com '€', els eliminaria.
  SAFE_CAST(REGEXP_REPLACE(CAST(price AS STRING), r'[^\d.]', '') AS FLOAT64) AS price,

  -- 4. Altres columnes:
  -- Conservem les columnes que no necessiten neteja específica
  colour,
  weight,
  category,
  brand,
  cost,
  launch_date

FROM `sprint3-analytics-irina.Sprint3_bronze.products_raw`;
