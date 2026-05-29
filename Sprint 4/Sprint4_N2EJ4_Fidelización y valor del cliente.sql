WITH Primeras_Compras AS (
  -- Paso 1: Numerar las compras de cada usuario per orden cronològico
  SELECT 
    t.user_id,
    t.Sales_Timestamp,
    t.amount,
    ROW_NUMBER() OVER (
      PARTITION BY t.user_id 
      ORDER BY t.Sales_Timestamp
    ) AS numero_compra
  FROM `sprint3-analytics-irina.sprint3_gold.fact_transactions_optimized` AS t

  -- Se filtra solo las 3 primeras compras de cada usuario.
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY t.user_id 
    ORDER BY t.Sales_Timestamp
  ) <= 3
)

-- Paso 2: Cruzar con usuarios i calcular el promedio de las 3 primeras compras 
SELECT 
  u.user_id,
  CONCAT(u.name, ' ', u.surname) AS nombre_completo,
  u.email,
  MAX(CASE WHEN pc.numero_compra = 3 THEN pc.Sales_Timestamp END) AS fecha_3a_compra,  -- Data e importe de la 3a compra
  MAX(CASE WHEN pc.numero_compra = 3 THEN pc.amount END) AS importe_3a_compra,
  ROUND(AVG(pc.amount) FILTER (WHERE pc.numero_compra <= 3), 2) AS promedio_3_primeres   -- promedio de las 3 primeras compras.
FROM Primeras_Compras AS pc
JOIN `sprint3-analytics-irina.sprint3_gold.users_combined` AS u
  ON pc.user_id = u.user_id
GROUP BY u.user_id, u.nombre_completo, u.email
HAVING COUNT(*) >= 3  
ORDER promedio_3_primeres DESC;
