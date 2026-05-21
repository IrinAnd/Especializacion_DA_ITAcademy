CREATE OR REPLACE TABLE `sprint3-analytics-irina.sprint3_silver.users_combined` AS
SELECT
  id AS user_id,          -- 1. Estandarización id -> user_id
  name,
  surname,
  phone,
  email,
  birth_date,
  country,
  city,
  postal_code,
  address,
  'USA' AS origin         -- 2. Columna Calculada: Origen
  
FROM `sprint3-analytics-irina.Sprint3_bronze.american_users_raw`

UNION ALL

SELECT
  id AS user_id,
  name,
  surname,
  phone,
  email,
  birth_date,
  country,
  city,
  postal_code,
  address,
  'EUROPE' AS origin      -- 3. Columna Calculada: Origen 2
  
FROM `sprint3-analytics-irina.Sprint3_bronze.european_users_raw`;