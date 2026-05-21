CREATE EXTERNAL TABLE `sprint3-analytics-irina.Sprint3_bronze.transactions_raw`
OPTIONS (
  format = 'CSV',
  uris = ['gs://bootcamp-data-analytics-public/ERP/transactions.csv'],
  field_delimiter = ';',  
  skip_leading_rows = 1   
);

-- 2. Crear companies_raw (amb esquema manual definit)
CREATE EXTERNAL TABLE `sprint3-analytics-irina.Sprint3_bronze.companies_raw` (
  company_id STRING,
  company_name STRING,
  phone STRING,
  email STRING,
  country STRING,
  website STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://bootcamp-data-analytics-public/ERP/companies.csv'],
  skip_leading_rows = 1,
  field_delimiter = ','
);

-- 3. Crear american_users_raw (Estàndard)
CREATE EXTERNAL TABLE `sprint3-analytics-irina.Sprint3_bronze.american_users_raw`
OPTIONS (
  format = 'CSV',
  uris = ['gs://bootcamp-data-analytics-public/CRM/american_users.csv'],
  skip_leading_rows = 1
);

-- 4. Crear european_users_raw (Estàndard)
CREATE EXTERNAL TABLE `sprint3-analytics-irina.Sprint3_bronze.european_users_raw`
OPTIONS (
  format = 'CSV',
  uris = ['gs://bootcamp-data-analytics-public/CRM/european_users.csv'],
  skip_leading_rows = 1
);

-- 5. Crear credit_cards_raw (Estàndard)
CREATE EXTERNAL TABLE `sprint3-analytics-irina.Sprint3_bronze.credit_cards_raw`
OPTIONS (
  format = 'CSV',
  uris = ['gs://bootcamp-data-analytics-public/CRM/credit_cards.csv'],
  skip_leading_rows = 1
);