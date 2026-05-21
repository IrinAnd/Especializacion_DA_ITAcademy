Exercici 2: Rànquing de Productes (La Potència dels Arrays)
Escenari de Negoci:
L'equip de vendes vol optimitzar el catàleg. Necessiten un informe a la capa Gold que mostri el rendiment real de cada producte. Gràcies a la teva bona enginyeria a la capa Silver, la taula transactions_clean ja té els IDs de producte perfectament organitzats en una llista (Array). Ara toca explotar aquesta estructura.

🎯 Objectiu:
Crea la taula sprint3_gold.product_sales_ranking que contingui l'inventari complet de productes i quantes vegades s'ha venut cadascun.

📝 Requisits de l'Informe:
» Detall del Producte: Ha d'incloure product_id, name, price i color (vénen de la taula products_clean).
» Mètrica de Negoci: Una columna nova total_sold que compti quantes vegades apareix aquest producte a les transaccions.
» Integritat: Han d'aparèixer tots els productes, fins i tot els que tenen 0 vendes (potser cal descatalogar-los).
💡 Pista Tècnica:
» A transactions_clean, els productes estan "encapsulats" dins d'un Array per cada transacció.
» Primer necessitaràs "aplanar" la taula de transaccions usant UNNEST(product_ids) per poder comptar els productes individualment.
» Després, fes un encreuament (LEFT JOIN) començant per la taula de productes per no perdre aquells que no s'han venut mai.

