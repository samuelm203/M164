-- Aufg. 2; Sicherstellen das man auf der Datenbank "Fahrzeugpark" ist
USE Fahrzeugpark; 

-- Aufg. 3; Mitarbeiter hinzufügen
INSERT INTO Mitarbeiter (Nachname, Vorname)
VALUES 
	('Chuche', 'Didier'),
	('Feuz', 'Beat'),
	('Figini', 'Michela'),
	('Gut-Behrami', 'Lara'),
	('Heizner', 'Franz'),
	('Hess', 'Erika'),
	('Janka', 'Carlo'),
	('Müller', 'Peter'),
	('Nadig', 'Marie-Theres'),
	('Odermatt', 'Marco'),
	('Schneider', 'Vreni'),
	('Zurbriggen', 'Primin');

SELECT * FROM Mitarbeiter;

-- Aufg. 4; Mitarbeiter einfügen
INSERT INTO Fahrzeug (Marke, Typ, Neupreis, Jahrgang, Occasion) 
VALUES 
	('Ford','Model T','825','1908', 0),
	('Volkswagen','Käfer','5000','1983','1'),
	('Chevrolet','Corvette C1','3500','1953','1'),
	('Mercedes-Benz','300 SL Flügeltier','29000','1954','1'),
	('Mini','Mini Cooper','497','1959','1'),
	('Jaguar','E-Type','2250','1961','1'),
	('Ferrari','250 GTO','18000','1962','0'),
	('Porsche','911','14500','1964','1'),
	('Ford','Mustang','2368','1964','0'),
	('Lamborghini','Miura','20000','1966','0'),
	('Toyota','Corolla (erste Generation)','1100','1966','1'),
	('Toyota','Prius (erste Generation)','35000','1997','0');

SELECT * FROM  Fahrzeug;

-- Aufg. 5; Mitarbeiter und Fahrzeug verknüpfen
UPDATE Fahrzeug 
SET fk_Mitarbeiter_ID = (SELECT Mitarbeiter_ID FROM Mitarbeiter WHERE Vorname = 'Beat')
WHERE Fahrzeug_ID = 2;

UPDATE Fahrzeug
SET fk_Mitarbeiter_ID = (SELECT Mitarbeiter_ID FROM Mitarbeiter WHERE Vorname = 'Didier')
WHERE Marke = 'Ford';

SELECT * FROM Fahrzeug;

-- Aufg. 6; Ersatzfahrzeug zuweisen 
UPDATE Fahrzeug 
SET fk_Mitarbeiter_ID = (SELECT Mitarbeiter_ID FROM Mitarbeiter WHERE Vorname = 'Beat' AND Nachname = 'Feuz')
WHERE Fahrzeug_ID = (SELECT Fahrzeug_ID WHERE Typ = 'Mini Cooper');  

UPDATE Fahrzeug 
SET fk_Mitarbeiter_ID = (SELECT Mitarbeiter_ID FROM Mitarbeiter WHERE Vorname = 'Beat' AND Nachname = 'Feuz')
WHERE Typ = 'Mini Cooper';  

SELECT * FROM Fahrzeug; 

-- Aufg. 7; Fahrzeuge verkaufen und kaufen
DELETE FROM Fahrzeug WHERE Marke = 'Toyota';

INSERT INTO Fahrzeug (Marke, Typ, Neupreis, Jahrgang, Occasion)
VALUES ('Lamborghini','Diablo','285000','1990','1');

SELECT * FROM Fahrzeug; 

-- Aufg. 8; Kennzeichen hinzufügen
ALTER TABLE Fahrzeug
	ADD Kennzeichen NVARCHAR(50); 

UPDATE Fahrzeug 
SET Kennzeichen = 'LU 777'
WHERE Typ = 'Model T'; 

UPDATE Fahrzeug 
SET Kennzeichen = 'LU 64'
WHERE Typ = 'Mustang'; 

UPDATE Fahrzeug 
SET Kennzeichen = 'LU 150'
WHERE Typ = 'Mini Cooper'; 

UPDATE Fahrzeug 
SET Kennzeichen = 'NW 100'
WHERE Typ = '911'; 


SELECT * FROM Fahrzeug;

-- Aufg. 9; Mitarbeiter löschen
UPDATE FAHRZEUG 
SET fk_Mitarbeiter_ID = NULL 
WHERE fk_Mitarbeiter_ID = (SELECT fk_Mitarbeiter_ID FROM Mitarbeiter WHERE Vorname = 'Beat' AND NACHNAME = 'Feuz');

DELETE FROM Mitarbeiter WHERE Vorname = 'Beat' AND Nachname = 'Feuz';

SELECT * FROM Mitarbeiter;

-- Aufg. 10; Zeitwert erfassen 
ALTER TABLE Fahrzeug 
	ADD Zeitwert DECIMAL(9, 2); 

UPDATE Fahrzeug 
	SET Zeitwert = Neupreis; 

SELECT * FROM Fahrzeug; 

-- Aufg. 11; Zeitwert anpassen
UPDATE FAHRZEUG
SET Zeitwert = Neupreis / 100 * CASE 
        WHEN (YEAR(GETDATE()) - Jahrgang) < 6    THEN 50
        WHEN (YEAR(GETDATE()) - Jahrgang) <= 25  THEN 10
        WHEN (YEAR(GETDATE()) - Jahrgang) <= 50  THEN 300
        WHEN (YEAR(GETDATE()) - Jahrgang) <= 75  THEN 1000
        WHEN (YEAR(GETDATE()) - Jahrgang) <= 100 THEN 10000
        ELSE 100000 
END;

SELECT * FROM Fahrzeug;

-- Aufg. 12; Occasionsfahrzeuge justieren 
SELECT * FROM Fahrzeug WHERE Zeitwert >= 100000

UPDATE Fahrzeug 
SET Zeitwert = Zeitwert / 100 * 80
WHERE Zeitwert >= 100000; 

SELECT * FROM Fahrzeug; 