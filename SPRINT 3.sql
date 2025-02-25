########################################## NIVELL 1 #######################################################

-- Exercici 1
/* La teva tasca és dissenyar i crear una taula anomenada "credit_card" que emmagatzemi detalls crucials
 sobre les targetes de crèdit. La nova taula ha de ser capaç d'identificar de manera única
 cada targeta i establir una relació adequada amb les altres dues taules ("transaction" i "company").
 Després de crear la taula serà necessari que ingressis la informació del document
 denominat "dades_introduir_credit". Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.*/

-- Mostra de dades de  taula datos_introducir_credit
-- credit_card (id, iban, pan, pin, cvv, expiring_date) VALUES (        'CcU-2938', 'TR301950312213576817638661', '5424465566813633', '3257', '984', '10/30/22');



CREATE TABLE IF NOT EXISTS credit_card (
id VARCHAR(15) PRIMARY KEY,   			-- Identificador únic de la targeta, alfanumèric
    iban VARCHAR(34) ,    		-- IBAN pot tenir fins a 34 caràcters segons la norma ISO 13616
    pan VARCHAR(30) ,        	-- PAN (Primary Account Number), normalment de 16 dígits. Incrementat a 30 Ha donat problemes, per tant hem incrementat la mida a (30)
    pin CHAR(4) ,         		-- PIN de 4 dígits
    cvv CHAR(3) ,         		-- CVV normalment de 3 dígits
    expiring_date VARCHAR(10)   -- Data d'expiració en format VARCHAR(10) perque les dades a introduir MM/DD/YY i donaria problemes ja que es YYYY-MM-DD
    );

-- Visualitzem la correcta creació de la taula i el seu contingut

 select * from credit_card;   
    

    
    -- Executem datos_introducir_credit per a que es carreguin les dades. i mirem resultat.
    
    --
    
    -- FOREIGN KEY (company_id) REFERENCES company(id) -- Com afegir una Foreing Key
    -- Alterem la taula transaction afegint una FOREIGN KEY anomenada credit_card_id que te com a Referencia el camp id de credit_card, i ho expressem amb
    -- credit_card(id)
    
    ALTER TABLE transaction ADD  CONSTRAINT credit_card_transaction FOREIGN KEY(credit_card_id) REFERENCES credit_card(id); 
    
    
    
    
    -- Observem com queda la taula transaction amb la nova Foreign Key afegida.
    DESCRIBE transaction;
    
    
-- Exercici 2
/* El departament de Recursos Humans ha identificat un error en el número de compte 
de l'usuari amb ID CcU-2938. La informació que ha de mostrar-se per a 
aquest registre és: R323456312213576817699999. Recorda mostrar que el canvi es va realitzar.*/

-- Volem modificar el camp credit_card(iban) del usuari amb id = CcU-2938
UPDATE credit_card 									-- UPDATE per a modificar
SET iban = 'R323456312213576817699999' 				-- SET per a establir camp = valor nou del camp
WHERE id = 'CcU-2938'								-- WHERE per a dir-li que ho faci a id = id de credit_card
;


 

-- Comprovem el resultat per a verificar el canvi
SELECT * 
FROM credit_card AS cc
WHERE cc.id = 'CcU-2938'
;




/*
- Exercici 3
En la taula "transaction" ingressa un nou usuari amb la següent informació:
Id	108B1D1D-5B23-A76C-55EF-C568E49A99DD
credit_card_id	CcU-9999
company_id	b-9999
user_id	9999
lat	829.999
longitude	-117.999
amount	111.11
declined	0
*/









-- Ingressem el nou usuari amb la comanda INSERT INTO transaction 
INSERT INTO transaction (id, credit_card_id, company_id , user_id, lat, longitude,  amount, declined)
VALUES( '108B1D1D-5B23-A76C-55EF-C568E49A99DD' , 'CcU-9999' , 'b-9999' , '9999', '829.999' ,  '-117.999', '111.11','0')
;
-- Dona un error perque el id de company 'b-9999' no existeix  

-- Primerament crearem company(id) = ‘b-9999’a la taula company
INSERT INTO company (id, company_name, phone, email, country, website)
VALUES ('b-9999','company_name', 'phone', 'email', 'country', 'website')
;
-- Es crea satisfactoriament

SELECT *
FROM company
WHERE id = 'b-9999'
;

-- Es crea correctament  

-- Ingressem de nou l'usuari amb la comanda INSERT INTO transaction 
INSERT INTO transaction (id, credit_card_id, company_id , user_id, lat, longitude,  amount, declined)
VALUES( '108B1D1D-5B23-A76C-55EF-C568E49A99DD' , 'CcU-9999' , 'b-9999' , '9999', '829.999' ,  '-117.999', '111.11','0')
;


-- Dona un error perque el id de credit_card no exusteix   
-- Comprovem si existeix id
SELECT * 
FROM credit_card 
WHERE id = 'CcU-9999'
;

 
-- Creem el id 'CcU-9999' a taula credit_card 
INSERT INTO credit_card (id , iban , pan, pin, cvv, expiring_date )
VALUES ('CcU-9999', 'iban','pan', 'pin', 'cvv', 'mm/dd/yy' )
;


-- Verifiquem id = 'CcU-9999'
select * from credit_card
where id='CcU-9999';


-- Ingressem de nou l'usuari amb la comanda INSERT INTO transaction 
INSERT INTO transaction (id, credit_card_id, company_id , user_id, lat, longitude,  amount, declined)
VALUES( '108B1D1D-5B23-A76C-55EF-C568E49A99DD' , 'CcU-9999' , 'b-9999' , '9999', '829.999' ,  '-117.999', '111.11','0')
;
-- Ara si l'hem creat correctament

-- Visulaitzem el usuari creat 
SELECT * 
FROM transaction 
WHERE company_id = 'b-9999'
;

-- Exercici 4
-- Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_*card. Recorda mostrar el canvi realitzat.


-- Busquem les columnes de la taula credit_*card 
SHOW COLUMNS FROM credit_*card;
-- no existeix la taula credit-*card

-- Com que si que hi ha una taula similar que es crdit_card, eliminarem 'pan' d'aquesta taula
-- Procedim a eliminar la columna pan de credit_card
ALTER TABLE credit_card
DROP COLUMN pan
;

-- Verifiquem la composició de la taula credit_card
DESCRIBE credit_card
;

########################################################## Nivell 2 ##################################################################################

-- Exercici 1
-- Elimina de la taula transaction el registre amb ID 02C6201E-D90A-1859-B4EE-88D2986D3B02 de la base de dades.

DELETE FROM transaction
WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02'
;


-- Exercici 2
/* La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives.
 S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. 
 Serà necessària que creïs una vista anomenada VistaMarketing que contingui la següent 
 informació: Nom de la companyia. Telèfon de contacte. País de residència. Mitjana de compra realitzat per cada companyia. 
 Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.*/

CREATE VIEW VistaMarketing AS
SELECT c.company_name, c.phone, c.country, ROUND(AVG(t.amount),2) AS Mitjana_compra
FROM company AS c
INNER JOIN transaction AS t
ON c.id = t.company_id
GROUP  BY c.company_name, c.phone, c.country
ORDER BY Mitjana_compra DESC
;


-- Exercici 3
-- Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"

SELECT *
FROM VistaMarketing
WHERE country = 'Germany'
;

############################################################### Nivell 3 ##############################################################
-- Exercici 1
/* La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. 
Un company del teu equip va realitzar modificacions en la base de dades, però no recorda com les va realitzar. 
Et demana que l'ajudis a deixar els comandos executats per a obtenir el següent diagrama:*/
-- Executem l'arxiu estructura_datos_user.sql

-- Comprovem creació taula user i estructura de la mateixa
DESCRIBE user;

-- Carreguem les dades de datos_introducir_user.sql

-- Visualitzem dades de user després de la càrrega de dades

SELECT * FROM user; 


-- Eliminem la Foreign Key
ALTER TABLE transaction DROP FOREIGN KEY user_ibfk_1
;

-- Intentem crear la FOREIGN KEY a transaction que apunti a id de user. Li direm user_transaction

 ALTER TABLE transaction ADD  CONSTRAINT user_transaction FOREIGN KEY(user_id) REFERENCES user(id)
 ;
 -- No podem per que el id de user '9999' no existeix per tant el crearem 

-- Creem el id de user '9999' amb dades complertes
INSERT INTO user (id, name, surname, phone, email, birth_date, country, city, postal_code, address) 
VALUES ("9999", "name", "surname", "(0034) 614-1654", "user@email.net", "Aug 31, 1981", "Catalunya", "Barcelona", "08036", "Ap #836-9508 Vitae, Ave")
;


-- Ara sí, creem la FOREIGN KEY a transaction que apunti a id de user. Li direm user_transaction

 ALTER TABLE transaction ADD  CONSTRAINT user_transaction FOREIGN KEY(user_id) REFERENCES user(id)
 ; 
 
 -- Eliminem la columna website de company
 ALTER TABLE company
 DROP COLUMN website
 ;
 
-- Cambiem el nom de la taula user
ALTER TABLE user RENAME TO data_user
;

-- Cambiem el nom de la columna email per personal_email
ALTER TABLE data_user 
CHANGE email personal_email VARCHAR(150)
;
-- Modifiquem el valor de cvv a 000 on id 'CcU-9999' per a poder posteriorment
-- cambiar el tipus de dada de les columnes que volem canviar
UPDATE credit_card
SET cvv = 000 
WHERE id = 'CcU-9999'	
;

-- Modifiquem les columnes de la taula credit_card de la següent forma
ALTER TABLE credit_card
MODIFY COLUMN id VARCHAR(20),
MODIFY COLUMN iban VARCHAR(50),
MODIFY COLUMN pin VARCHAR(4),
MODIFY COLUMN cvv INT,
MODIFY COLUMN expiring_date VARCHAR(20)
;

-- Creem una nova columna fecha_actual com a DATE a credit card

ALTER TABLE credit_card
ADD COLUMN
fecha_actual DATE
;






/*Exercici 2
L'empresa també et sol·licita crear una vista anomenada "InformeTecnico" que contingui la següent informació:
o	ID de la transacció
o	Nom de l'usuari/ària
o	Cognom de l'usuari/ària
o	IBAN de la targeta de crèdit usada.
o	Nom de la companyia de la transacció realitzada.
o	Assegura't d'incloure informació rellevant de totes dues taules i utilitza àlies per a canviar de nom columnes segons sigui necessari.
Mostra els resultats de la vista, ordena els resultats de manera descendent en funció de la variable ID de transaction.
*/

-- Creem una vista que inclou els amount per transferencia ja que es demana que inclogui informació rellevant

CREATE VIEW Informe_Tecnico AS
SELECT t.id AS Identificador_transacció, d_u.name AS Nom_usuari, d_u.surname AS Cognom_usuari, c_c.iban AS Iban,
 c.company_name AS Nom_de_la_empresa, t.amount AS Import_Transferència
FROM transaction AS t
JOIN data_user AS d_u ON d_u.id = t.id
JOIN credit_card AS c_c ON c_c.id = t.credit_card_id
JOIN company as c ON c.id = t.company_id
ORDER BY Identificador_transacció DESC
;