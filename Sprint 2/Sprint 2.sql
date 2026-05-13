USE Transaction;

--  NIVEL 1  --

-- Exercici 1
	-- Creamos la base de datos  
CREATE DATABASE IF NOT EXISTS transactions;
Use transactions;
    -- Creamos la tabla company
    CREATE TABLE IF NOT EXISTS company (
        id VARCHAR(15) PRIMARY KEY,
        company_name VARCHAR(255),
        phone VARCHAR(15),
        email VARCHAR(100),
        country VARCHAR(100),
        website VARCHAR(255)
    );
    
    -- Creamos la tabla transaction
    CREATE TABLE IF NOT EXISTS transaction (
        id VARCHAR(255) PRIMARY KEY,
        credit_card_id VARCHAR(15) REFERENCES credit_card(id),
        company_id VARCHAR(20), 
        user_id INT REFERENCES user(id),
        lat FLOAT,
        longitude FLOAT,
        timestamp TIMESTAMP,
        amount DECIMAL(10, 2),
        declined BOOLEAN,
        FOREIGN KEY (company_id) REFERENCES company(id) 
    );
	
    	-- Insertamos datos de company desde N1-Ex.1__dades_introduir.
 
	SELECT*FROM transaction;

-- Ejercicio 2 

	 -- 2.1 Llistat dels països que estan generant vendes.
	 SELECT DISTINCT country
	 FROM company 
	 INNER JOIN transaction ON company.id=transaction.company_id
     WHERE declined=0 ;
     
		
 
 
	 -- 2.2 Des de quants països es generen les vendes.
	 SELECT COUNT( distinct country) AS quantitat_paisos
	 FROM company
	 INNER JOIN transaction ON company.id=transaction.company_id
     WHERE declined=0 ;
 
 
	 -- 2.3 Identifica la companyia amb la mitjana més gran de vendes.
	 SELECT company_name, AVG(amount) AS major_venta_empresa
	 FROM company 
	 JOIN transaction ON company.id=transaction.company_id
     WHERE declined = 0 
	 GROUP BY company_name
	 ORDER BY major_venta_empresa desc 
	 limit 1;
     
 
 
 -- Ejercicio 3
	
	-- 3.1 Mostra totes les transaccions realitzades per empreses d'Alemanya.
    
     SELECT  id
     FROM transaction 
     WHERE company_id in (
		 SELECT company.id
         FROM company
         WHERE country = 'Germany' and declined = 0);
	
         
	-- 3.2 Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.
    
    SELECT company_id
    FROM transaction
    WHERE amount > (
		SELECT AVG (amount) 
        FROM transaction
        WHERE declined = 0 
        )
	GROUP BY company_id;
    
     
   -- 3.3 Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.
	
    SELECT *
    FROM transaction
    WHERE company_id not in(
    SELECT id
    FROM company);
    

-- Ejercicio 4 
-- La teva tasca és dissenyar i crear una taula anomenada "credit_card" que emmagatzemi detalls crucials sobre les targetes de crèdit. 
-- La nova taula ha de ser capaç d'identificar de manera única cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company").
--  Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit". 
-- Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.

    
	CREATE TABLE IF NOT EXISTS credit_card(
    id VARCHAR (15)  PRIMARY KEY,
    iban VARCHAR (34),
    pan VARCHAR (20),
    pin VARCHAR (4),
    cvv VARCHAR (4),
    expiring_date CHAR (8),
    expiring_date_ok DATE NULL
    );
    -- Cargar datos desde archivo N1-Ex.4__ datos_introducir_credit.sql
	-- Vinculamos la nueva tabla dimensión a la tabla de hechos. 
    ALTER TABLE transaction
    ADD constraint FK2 foreign key (credit_card_id) REFERENCES credit_card(id); 
    
   -- Despúes de LA CREACIÓN. Convertir expiring_date a DATE 
	UPDATE credit_card
	SET expiring_date_ok = STR_TO_DATE(expiring_date, '%m/%d/%y');
    
    -- Eliminamos la columana original con mal formato. 
    ALTER TABLE credit_card
    DROP COLUMN expiring_date,
    CHANGE COLUMN expiring_date_ok expiring_date DATE ; 

-- Ejercicio 5 
   -- El departament de Recursos Humans ha identificat un error en el número de compte associat a la targeta de crèdit amb ID CcU-2938.
   -- La informació que ha de mostrar-se per a aquest registre és: TR323456312213576817699999. Recorda mostrar que el canvi es va realitzar.
   
    -- Registro antes del cambio 
   SELECT * 
   FROM credit_card
   WHERE id='CcU-2938';
   
   -- Ejecución del cambio. 
	UPDATE credit_card
    SET iban = 'TR323456312213576817699999'
    WHERE id = 'CcU-2938';
    
      -- Registro despúes del cambio 
   SELECT * 
   FROM credit_card
   WHERE id='CcU-2938';

-- Ejercicio 6 En la taula "transaction" ingressa una nova transacció amb la següent informació:
    
    INSERT INTO company(id)
    VALUE ('b-9999');
    INSERT INTO credit_card (id)
    VALUE('CcU-9999');
    INSERT INTO transaction (Id,credit_card_id,company_id , user_id, lat , longitude , amount ,declined ) 
	VALUES('108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', '9999', '829.999', '-117.999' ,'111.11' ,'0');
   
-- Ejercicio 7 Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_card. Recorda mostrar el canvi realitza
    
    -- Tabla antes del cambio.
    SELECT*
    FROM credit_card; 
    
    -- ejecución 
    ALTER TABLE credit_card
    DROP COLUMN pan;
    
    -- Tras el cambio
    SELECT*
    FROM credit_card;

-- Ejercicio 8 Estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui. 

 CREATE DATABASE IF NOT EXISTS bancos;
  USE bancos;
  
   DROP TABLE if exists users;
   CREATE TABLE users(
    id INT PRIMARY KEY,
    name VARCHAR (50),
    surname VARCHAR (50),
    phone VARCHAR (20),
    email VARCHAR(50),
    birth_date VARCHAR(50),
    country VARCHAR (50),
    city VARCHAR (50),
    postal_code VARCHAR (50),
    address  VARCHAR (100),
    region VARCHAR (20) NULL
    );
    
     LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ european_users.csv"
    INTO TABLE users
    FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	IGNORE 1 ROWS
    (id,name,surname,phone,email,birth_date,country,city,postal_code,address,@region);
    
    
    LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1-Ex.8__ american_users (1).csv"
    INTO TABLE users
    FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	IGNORE 1 ROWS
    (id,name,surname,phone,email,birth_date,country,city,postal_code,address,@region);
    
    LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1-Ex.8__ american_users (1).csv"
    INTO TABLE users
    FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	IGNORE 1 ROWS
    (id,name,surname,phone,email,birth_date,country,city,postal_code,address,@region);
    
    UPDATE users
    SET region = CASE
		WHEN country IN ('United States','Canada') THEN 'America'
        ELSE 'Europe'
        END;
 -- creación de companies 
	SELECT*FROM companies;
	CREATE TABLE companies (
    company_id VARCHAR(50) PRIMARY KEY,
    company_name VARCHAR (100),
    phone VARCHAR (50),
    email VARCHAR (100),
    country VARCHAR(50),
    website VARCHAR (100)
    );
    
    LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ companies.csv"
    INTO TABLE companies
    FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	IGNORE 1 ROWS
    (company_id,company_name,phone,email,country,website);
    
-- Creación de credit cards 
	CREATE TABLE IF NOT EXISTS credit_cards(
    id VARCHAR (50) PRIMARY KEY,
    user_id VARCHAR (50),
    iban VARCHAR (100),
    pan VARCHAR (50),
    pin VARCHAR (50),
    cvv VARCHAR (50),
    track1 VARCHAR (100),
    track2 VARCHAR (100),
    expiring_date VARCHAR (50),
    expiring_date_ok DATE NULL);
    
    LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ credit_cards.csv"
    INTO TABLE credit_cards
    FIELDS TERMINATED BY ','
	ENCLOSED BY '"'
	IGNORE 1 ROWS
    (id,user_id,iban,pan,pin,cvv,track1,track2,expiring_date,@expiring_date_ok);
    
    UPDATE credit_cards
	SET expiring_date_ok = STR_TO_DATE(expiring_date, '%m/%d/%y');
    
    ALTER TABLE credit_cards
    DROP COLUMN expiring_date,
    CHANGE COLUMN expiring_date_ok expiring_date DATE ;
    select*from credit_cards;

-- Creación de transaction. 
	
	CREATE TABLE IF NOT EXISTS transaction(
	id VARCHAR (100) PRIMARY KEY,
	card_id VARCHAR (50),
	business_id VARCHAR (50),
	fecha_hora  TIMESTAMP,
	amount DECIMAL (10,2),
	declined BOOLEAN,
	product_ids VARCHAR(100),	 
	user_id INT,
	lat FLOAT,
	longitude FLOAT,
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (business_id) REFERENCES companies(company_id),
	FOREIGN KEY (card_id) REFERENCES credit_cards(id)
);

	LOAD DATA 
	INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/N1.Ex.8__ transactions (1).csv"
	INTO TABLE transaction
	FIELDS TERMINATED BY ';'
	ENCLOSED BY '"'
	IGNORE 1 ROWS
	(id,card_id,business_id,fecha_hora,amount,declined,product_ids,user_id,lat,longitude);

  -- EJercicio 9 Realitza una subconsulta que mostri tots els usuaris amb més de 80 transaccions utilitzant almenys 2 taules
		
        SELECT users.name AS Nombre_completo, id
		FROM users
		WHERE id in (
			SELECT user_id
			FROM transaction
			GROUP BY user_id
			HAVING COUNT(transaction.amount)>80);
	
    -- EX 10 Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules.
    
		SELECT credit_cards.iban, ROUND(AVG (amount),2)AS media_amount
		FROM credit_cards
		JOIN transaction ON credit_cards.id = transaction.card_id
		JOIN companies ON companies.company_id = transaction.business_id
		WHERE companies.company_name = 'Donec Ltd'
		GROUP BY credit_cards.iban;
    

     --  NIVEL 2  --
     
	-- Ejercicio 1.  Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes.
	-- Mostra la data de cada transacció juntament amb el total de les vendes.
   
		SELECT DATE(fecha_hora) as dia_venta , SUM(amount) as total_ingresos
		FROM transaction
		WHERE declined=0 
		GROUP BY DATE(fecha_hora)
		ORDER BY total_ingresos desc
		limit 5;
        
	-- Ejercicio 2. Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions 
    -- amb un valor comprès entre 350 i 400 euros i en alguna d'aquestes dates: 29 d'abril del 2015, 20 de juliol del 2018 
	-- i 13 de març del 2024. Ordena els resultats de major a menor quantitat.
   
	   SELECT companies.company_name, companies.phone,DATE (transaction.fecha_hora)AS Fecha,transaction.amount
	   FROM companies
	   JOIN transaction 
	   On transaction.business_id=companies.company_id
	   WHERE amount BETWEEN 350 AND 400
	   AND DATE(fecha_hora) in ('2015-04-29', '2018-07-20', '2024-03-13')
	   ORDER BY amount DESC;
   
	-- Ejercicio 3  Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi,
	-- per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, 
    -- però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen igual o més de 400 transaccions o menys.
    
		SELECT business_id, COUNT(id) as Cantidad_trasacciones, 
		CASE
			WHEN COUNT(id)  >= 400 THEN 'Mayor 400'
			ELSE 'Inferior 400'
		END AS categoria_transacciones
		FROM transaction
		GROUP BY business_id;
        
	  -- Elimina de la taula transaction el registre amb ID 000447FE-B650-4DCF-85DE-C7ED0EE1CAAD de la base de dades.
    
		DELETE FROM transaction
		WHERE id =' 000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';
        
	-- Ejercicio 5 La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
    -- S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions.
    -- Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent informació: Nom de la companyia. 
    -- Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia.
    -- Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.
    
    
		CREATE VIEW VistaMarketing AS
		SELECT company_name ,phone , country ,ROUND(AVG(transaction.amount),2) AS media_compra
		FROM companies 
		JOIN transaction 
		ON transaction.business_id =companies.company_id
		WHERE declined =0
		GROUP BY company_id
		ORDER BY media_compra desc;
    
    