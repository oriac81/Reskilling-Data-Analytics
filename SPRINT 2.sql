-- Nivell 1

-- Detall de la taula company:

DESCRIBE company
;

-- Detall de la taula transaction:

DESCRIBE transaction
;

-- Visualització de la taula company:

SELECT * FROM company
;

-- Visualització de la taula transaction:

SELECT * FROM transaction
;

-- Exercici 2
-- Utilitzant JOIN realitzaràs les següents consultes:
-- 2.1 Llistat dels països que estan fent compres.

SELECT DISTINCT (c.country) AS pais
FROM company AS c
INNER JOIN transaction AS t
ON c.id = t.company_id
;

-- 2.2 Des de quants països es realitzen les compres.

SELECT COUNT(DISTINCT (c.country)) AS total_paisos
FROM company AS c
INNER JOIN transaction AS t
ON c.id = t.company_id
;

-- 2.3 Identifica la companyia amb la mitjana més gran de vendes.

SELECT company_name, ROUND (avg (amount),2)
FROM company
JOIN transaction
ON company.id=transaction.company_id
WHERE declined =0
GROUP BY company_name
ORDER BY 2 DESC
LIMIT 1;

-- Exercici 3
-- Utilitzant només subconsultes (sense utilitzar JOIN):
-- 3.1 Mostra totes les transaccions realitzades per empreses d'Alemanya.

SELECT *
FROM transaction AS t
WHERE t.company_id IN
	(SELECT c.id
	FROM company AS c 
	WHERE c.country = "Germany")
;

-- 3.2 Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.
SELECT DISTINCT t.company_id, t.amount
FROM transaction AS t
WHERE t.amount > 
		(SELECT AVG(t.amount) FROM transaction AS t
		)
;

    
    -- 3.3 Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.
-- 3.3 Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.

SELECT DISTINCT c.company_name
FROM company AS c
WHERE NOT EXISTS 
(SELECT * FROM transaction)
;


-- Nivell 2

-- Exercici 1
/*Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. 
Mostra la data de cada transacció juntament amb el total de les vendes.*/

SELECT DATE(t.timestamp) AS data_transaccio, SUM(t.amount) AS total_vendes
FROM transaction AS t 
WHERE t.declined = 0
GROUP BY DATE(t.timestamp)
ORDER BY total_vendes DESC
LIMIT 5
;

-- Exercici 2
-- Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.

SELECT c.country, ROUND(AVG(t.amount),2) AS mitjana_vendes
FROM transaction AS t
INNER JOIN company AS c 
ON c.id = t.company_id
WHERE t.declined = 0
GROUP BY c.country
ORDER BY mitjana_vendes DESC
;


-- Exercici 3
/* En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer 
competència a la companyia "Non Institute". Per a això, et demanen la llista de totes les transaccions realitzades 
 per empreses que estan situades en el mateix país que aquesta companyia.*/

-- 3.1. Mostra el llistat aplicant JOIN i subconsultes.

 
SELECT * FROM transaction
INNER JOIN company AS c
ON transaction.company_id = c.id
WHERE c.country = (
		SELECT  c.country
		FROM company AS c
		WHERE c.company_name LIKE "Non Institute")
;

-- 3.2. Mostra el llistat aplicant solament subconsultes

SELECT * FROM transaction AS t
WHERE t.company_id IN (                                         
	SELECT c.id	
	FROM company AS c
	WHERE c.country = (
		SELECT  c.country
		FROM company AS c
		WHERE c.company_name LIKE "Non Institute"))
;

-- Nivell 3
-- Exercici 1
/* Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions
 amb un valor comprès entre 100 i 200 euros i en alguna d'aquestes dates: 
 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. 
 Ordena els resultats de major a menor quantita.*/
 
SELECT c.company_name, c.phone, c.country, t.timestamp, t.amount
FROM transaction AS t
INNER JOIN company AS c ON t.company_id = c.id
WHERE DATE (t.timestamp) IN ("2021-04-29", "2021-07-20" , "2022-03-13")
	AND t.amount >= 100 AND t.amount <= 200
	ORDER BY t.amount DESC
;
 
 -- Exercici 2
 /*Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, 
 per la qual cosa et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, 
 però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis 
 si tenen més de 4 transaccions o menys.*/


SELECT c.id, c.company_name, COUNT(t.id) AS numero_transaccions, 
    CASE 
        WHEN COUNT(t.id) > 4 THEN 'Més de 4 transaccions' 
        ELSE '4 transaccions o menys' 
    END AS classificacio
FROM transaction AS t
INNER JOIN company AS c ON t.company_id = c.id
GROUP BY c.id, c.company_name
ORDER BY numero_transaccions DESC
;
