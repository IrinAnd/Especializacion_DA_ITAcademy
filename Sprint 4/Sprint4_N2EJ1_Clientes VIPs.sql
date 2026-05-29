
WITH VIP_Stats AS (
  -- Pas 1: Calcular les estadístiques de compra per usuari
  SELECT 
    user_id,
    SUM(amount) AS total_gastat,
    COUNT(*) AS num_compres,
    ROUND(AVG(amount), 2) AS tiquet_mig,
    MAX(amount) AS max_compra
  FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized`
  GROUP BY user_id
  HAVING SUM(amount) > 500  -- Filtre: només VIPs
)
-- Pas 2: Creuar amb la taula d'usuaris per obtenir dades personals
SELECT 
  v.user_id,
  u.nom_complet,
  u.email,
  v.num_compres,
  v.tiquet_mig,
  v.max_compra,
  v.total_gastat
FROM VIP_Stats AS v
JOIN `sprint3-analytics-irina.sprint3_gold.users_combined` AS u
  ON v.user_id = u.user_id
ORDER BY v.total_gastat DESC;