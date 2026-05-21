Crea una vista anomenada sprint3_gold.v_marketing_kpis que mostri la següent informació per a cada companyia:

» Nom de la companyia, Telèfon i País (origen: companies_clean).
» Mitjana de compra (AVG(amount) de transactions_clean).
» Classificació de Client (Lògica):
Crea una columna calculada anomenada client_tier.
Si la mitjana de compra és superior a 260€, etiqueta com a "Premium".
Si és igual o inferior, etiqueta com a "Standard".

CREATE VIEW sprint3_gold.v_marketing_kpis AS
SELECT c.name AS company_name, c.phone, c.country,AVG(T.amount)
FROM `sprint3-analytics-irina.sprint3_silver.companies_clean` AS C
JOIN `sprint3-analytics-irina.sprint3_silver.transactions_clean` AS T
ON C.COMPAid = T

