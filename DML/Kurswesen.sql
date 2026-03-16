-- Sicherstellen das man auf der Datenbank "Kurswesen" ist
USE Kurswesen; 

-- Drei neue Kurse einfügen 
INSERT INTO Kurs (Bez, MaxTeilnehmer, Kosten, StartDatum, Dauer)
VALUES 
	('Windows 11', '10', '450', '2025-06-03', '2.5'),
	('Word 2024', '5', '250', '2025-04-20', '1'),
	('Windows 11 Neuheiten', '15', '150', '2025-05-17', '0.5');

SELECT * FROM Kurs; 

-- Kurs "Windosw 11" anpassen
UPDATE Kurs SET StartDatum = '2025-05-02', MaxTeilnehmer = '15' WHERE BEZ = 'Windows 11'; 

SELECT * FROM Kurs; 

-- Neue Word- und Excel-Kurse
INSERT INTO Kurs (BEZ, MaxTeilnehmer, Kosten, StartDatum, Dauer)
VALUES 
	('Word 365','10','320','2025-06-15','2'),
	('Excel 365','10','320',NULL,'2'); 

SELECT * FROM Kurs; 

-- "Word 2024" Kurs löschen
DELETE FROM Kurs WHERE BEZ = 'Word 2024'; 

SELECT * FROM Kurs; 

-- Neue Schulungsräume 
SELECT * FROM Kurs WHERE MaxTeilnehmer < 12;

UPDATE Kurs SET MaxTeilnehmer = '12' WHERE MaxTeilnehmer < 12;

SELECT * FROM Kurs; 

-- Datum ändern
SELECT * FROM Kurs WHERE StartDatum = '2025-05-17';

UPDATE Kurs SET StartDatum = DATEADD(day, 7, StartDatum) WHERE StartDatum = '2025-05-17'; 

SELECT * FROM Kurs; 