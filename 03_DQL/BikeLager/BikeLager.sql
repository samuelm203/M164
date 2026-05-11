-- Sicherstellen das man auf der Datenbank 'Bike_Lager' ist
USE Bike_Lager; 
GO

-- Aufg. 2; Alle Spalten und Datensätze anzeigen 
SELECT * FROM Bike; 

SELECT * FROM Marke; 

SELECT * FROM Typ; 

-- Aufg. 3; Ausgewählte Spalten anzeigen und sortieren
SELECT Bike_Id, Bezeichnung, Preis FROM Bike
	ORDER BY Bezeichnung;

SELECT Bike_Id, Bezeichnung, Preis FROM Bike
	ORDER BY Preis DESC;

SELECT Bike_Id, Bezeichnung, Preis FROM Bike 
	ORDER BY Preis DESC, Bezeichnung;

-- Aufg. 4; Spalten umbenennen
SELECT Bezeichnung AS 'Beschreibung', Preis AS 'Preis in CHF' FROM Bike 
	ORDER BY Preis, Bezeichnung;

-- Aufg. 5; Ausgewählte Datensätze anzeigen mit einem Kriterium 
SELECT * FROM Bike WHERE FK_Marke_Id = 3; 

SELECT * FROM Bike WHERE  FK_Marke_Id = (SELECT Marke_Id FROM Marke WHERE Bezeichnung = 'Flyer');

-- Aufg. 6; Ausgewählte Datensätze anzeigen mit zwei Kriterien 
SELECT Bezeichnung, Preis FROM Bike 
	WHERE Fk_Typ_Id = 4 AND FK_Marke_Id = 1;

SELECT Bezeichnung, Preis FROM Bike 
	WHERE Fk_Typ_Id = (SELECT Typ_Id FROM Typ WHERE Bezeichnung = 'Mountainbike') AND
	FK_Marke_Id = (SELECT Marke_Id FROM Marke WHERE Bezeichnung = 'Scott'); 

-- Aufg. 7; Alle Datensätze von zwei Tabellen verbinden
SELECT 
    Marke.Bezeichnung AS Marke, 
    Bike.Bezeichnung AS Bike, 
    Bike.Preis 
FROM Bike 
INNER JOIN Marke ON Bike.FK_Marke_Id = Marke.Marke_Id
ORDER BY Bike.Bezeichnung;

-- Aufg. 8; Alle Datensätze von drei Tabellen verbinden
SELECT 
    Marke.Bezeichnung AS Marke, 
    Typ.Bezeichnung AS Typ, 
    Bike.Bezeichnung AS Bike, 
    Bike.Preis
FROM Bike
INNER JOIN Marke ON Bike.FK_Marke_Id = Marke.Marke_Id
INNER JOIN Typ ON Bike.FK_Typ_Id = Typ.Typ_Id
ORDER BY Marke.Bezeichnung, Bike.Bezeichnung;

-- Aufg. 9; Ausgewählte Datensätze mehrerer Tabellen sortieren
SELECT 
    Marke.Bezeichnung AS Marke, 
    Typ.Bezeichnung AS Typ, 
    Bike.Bezeichnung AS Bike, 
    Bike.Preis
FROM Bike
INNER JOIN Marke ON Bike.FK_Marke_Id = Marke.Marke_Id
INNER JOIN Typ ON Bike.FK_Typ_Id = Typ.Typ_Id
WHERE Marke.Bezeichnung = 'Wheeler'
ORDER BY Bike.Preis ASC;

-- Aufg. 10; Alle Datensätze gruppieren und aggregieren
SELECT 
    Marke.Bezeichnung AS Marke, 
    COUNT(Bike.Bike_Id) AS Anzahl
FROM Bike
INNER JOIN Marke ON Bike.FK_Marke_Id = Marke.Marke_Id
GROUP BY Marke.Bezeichnung
ORDER BY Marke.Bezeichnung;

-- Aufg. 11; Ausgewählte Datensätze gruppieren und aggregieren
SELECT 
    Typ.Bezeichnung AS Typ, 
    AVG(Bike.Preis) AS Durchschnittspreis
FROM Bike
INNER JOIN Typ ON Bike.FK_Typ_Id = Typ.Typ_Id
WHERE Typ.Bezeichnung = 'E-Bike'
GROUP BY Typ.Bezeichnung;