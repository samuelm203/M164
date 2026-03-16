-- Sicherstellen das ich auf der Datenbank "Bibliothek" bin
USE Bibliothek;

-- Überprüfung der Tabelle "Verlag"
SELECT * FROM Verlag;

-- Einen neuen Verlag einfügen (INSERT)
INSERT INTO Verlag (Name, Hauptsitz) 
	VALUES ('Diogenes Verlag', 'Zürich');

-- Einen neuen Verlag einfügen (INSERT) in dem Kurzformat
INSERT Verlag 
	VALUES ('dtv', 'München'); 

-- Nur einzelner Verlag ohne Hauptsitz einfügen (INSERT)
INSERT INTO Verlag (Name)
	VALUES ('Suhrkamp'); 

DELETE FROM Verlag 
	WHERE Name = 'Suhrkamp';

INSERT INTO Verlag (Name, Hauptsitz)
	VALUES ('Suhrkamp', 'Berlin'); 

-- Mehrere Verlage einfügen (INSERT)
INSERT INTO Verlag (Name, Hauptsitz)
	VALUES
	('Fischer Verlag', 'Frankfurt'),
	('Reclam', 'Stuttgart'), 
	('Kein & Aber Verlag', 'Zürich'); 

-- Mehrere Kategorien einfügen (INSERT)
INSERT INTO Kategorie (Bezeichnung, Beschreibung)
	VALUES	
	('Fantasy','Fantastische Welten, Magie, Epen'),
	('Satire','Humor, Gesellschaftskritik, Absurdes'),
	('Dystopie','Unterdrückung, Totalitarismus, Zukunftsvisionen'),
	('Klassiker', NULL),
	('Philosophie','Grundfragen menschlichen Denkens'),
	('Drama','Theaterliteratur, Tragödien, Konflikte');

SELECT * FROM Kategorie;

-- Mehrere Autoren einfügen
INSERT INTO Autor (Vorname, Nachname, Geburtsdatum)
	VALUES
	('Neil','Gaiman','1960-11-10'),
	('Terry','Prachett','1948-04-28'),
	('John Ronald Reuel','Tolkien','1892-06-25'),
	('George','Orwell','1903-06-25'),
	('Platon','',NULL),
	('Antoine','de Saint-Exupéry','1900-06-29'),
	('William','Shakespeare','1564-04-26'); 

SELECT * FROM Autor; 

-- Mehrere Mitarbeitende einfügen (INSERT)
INSERT INTO Mitarbeiter (Vorname, Nachname, Funktion)
	VALUES 
	('Tom','Lüthi','Bibliothekar/in'),
	('Dominique','Aegerter','Bibliothekar/in'),
	('Marc','Màrquez','Lernende/r'),
	('Valentino','Rossi','Leiter/in'),
	('Fabio','Quartararo','Lernende/r');

SELECT * FROM Mitarbeiter;

-- Mehrere Kunden einfügen (INSERT)
INSERT INTO Kunde (Vorname, Nachname)
	VALUES
	('Max','Verstappen'), 
	('Lewis','Hamilton');

INSERT INTO Kunde (Vorname, Nachname, Adresse, PLZ, Ort, Land)
	VALUES 
	('Charles','Leclerc','Marktplatz 4','6210','Sursee','Schweiz'),
	('Lando','Norris','Seestrasse 8','6204','Sempach','Schweiz'),
	('Carlos','Sainz','Dorfstrasse 11','6208','Oberkirch','Schweiz'),
	('George','Russell','Hauptstrasse 9','6252','Dagmersellen','Schweiz'),
	('Fernando','Alonso','Schulhausstrasse 7','6206','Neuenkirch','Schweiz'),
	('Sergio','Pérez','Kirchweg 5','6130','Wilisau','Schweiz'); 

SELECT * FROM Kunde;

-- Mehrere Bücher einfügen

INSERT INTO Buch (ISBN, Titel, Erscheinungsjahr, fk_Verlag_ID)
	VALUES ('9780552176453', 'Good Omens', '1990', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Kein & Aber Verlag'));

INSERT INTO Buch (ISBN, Titel, Erscheinungsjahr, fk_Verlag_ID)
	VALUES ('9780261102385', 'Der Herr der Ringe', '1954', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'dtv'));

INSERT INTO Buch (ISBN, Titel, Erscheinungsjahr, fk_Verlag_ID)
	VALUES ('9780451524935', '1984', '1949', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Suhrkamp'));

INSERT INTO Buch (ISBN, Titel, Erscheinungsjahr, fk_Verlag_ID)
	VALUES 
	('9783150000014', 'Die Republik', '-380', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Reclam')),
	('9783150000021', 'Romeo und Julia' , '1597', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Reclam')), 
	('9783150000038', 'Hamlet', '1603', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Reclam')), 
	('9783150000045', 'Ein Sommernachtstraum', '1595', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Reclam'));

INSERT INTO Buch (ISBN, Titel, Erscheinungsjahr, fk_Verlag_ID)
	VALUES ('9780156012195', 'Der kleine Prinz', '1943', (SELECT Verlagsnummer FROM Verlag WHERE Name = 'Fischer Verlag'));

SELECT * FROM Buch

-- Bücher mit Autor verknüpfen
INSERT INTO Buch_Autor (fk_Buch_ID, fk_Autor_ID)
VALUES 
    ((SELECT Buch_ID FROM Buch WHERE Titel = 'Good Omens'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'Neil')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Good Omens'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'Terry')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Der Herr der Ringe'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'John Ronald Reuel')),
    ((SELECT Buch_ID FROM Buch WHERE Titel = '1984'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'George')),
    ((SELECT Buch_ID FROM Buch WHERE Titel = 'Die Republik'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'Platon')),
    ((SELECT Buch_ID FROM Buch WHERE Titel = 'Der kleine Prinz'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'Antoine')),
    ((SELECT Buch_ID FROM Buch WHERE Titel = 'Romeo und Julia'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'William')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Hamlet'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'William')),
    ((SELECT Buch_ID FROM Buch WHERE Titel = 'Ein Sommernachtstraum'), (SELECT Autor_ID FROM Autor WHERE Vorname = 'William'));

SELECT * FROM Buch_Autor;

-- Bücher mit Kategorien verbinden
INSERT INTO Buch_Kategorie (fk_Buch_ID, fk_Kategorie_ID)
VALUES
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Good Omens'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Satire')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Der Herr der Ringe'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Fantasy')),
	((SELECT Buch_ID FROM Buch WHERE Titel = '1984'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Dystopie')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Die Republik'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Philosophie')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Der kleine Prinz'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Klassiker')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Romeo und Julia'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Klassiker')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Romeo und Julia'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Drama')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Hamlet'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Klassiker')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Hamlet'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Drama')),
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Ein Sommernachtstraum'), (SELECT Kategorie_ID FROM Kategorie WHERE Bezeichnung = 'Drama'));

SELECT * FROM Buch_Kategorie;

-- Reservationen "erfinden" und einfügen
INSERT INTO Buch_Kunde (fk_Buch_ID, fk_Kunde_ID, Enddatum)
VALUES 
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Hamlet'),(SELECT Kundennummer FROM Kunde WHERE Vorname = 'Max'), DATEADD(day, 14, CAST(GETDATE() AS DATE)));

INSERT INTO Buch_Kunde (fk_Buch_ID, fk_Kunde_ID, Startdatum, Enddatum)
VALUES 
	((SELECT Buch_ID FROM Buch WHERE Titel = 'Der kleine Prinz'),(SELECT Kundennummer FROM Kunde WHERE Vorname = 'Sergio'),DATEADD(day, -2, CAST(GETDATE() AS DATE)),DATEADD(day, 14, CAST(GETDATE() AS DATE)));

SELECT * FROM Buch_Kunde;

-- Ausleihe "erfinden" und einfügen
INSERT INTO Ausleihe (fk_Buch_ID, fk_Kunde_ID, fk_Mitarbeiter_ID, Enddatum, Strafgebuehr)
VALUES (
	(SELECT Buch_ID FROM Buch WHERE Titel = 'Romeo und Julia'), 
	(SELECT Kundennummer FROM Kunde WHERE Vorname = 'George'),
	(SELECT Personalnummer FROM Mitarbeiter WHERE Vorname = 'Marc'),
	DATEADD(day, 8, CAST(GETDATE() AS DATE)),
	50);

INSERT INTO Ausleihe (fk_Buch_ID, fk_Kunde_ID, fk_Mitarbeiter_ID, Startdatum, Enddatum, Strafgebuehr)
VALUES (
	(SELECT Buch_ID FROM Buch WHERE Titel = 'Romeo und Julia'), 
	(SELECT Kundennummer FROM Kunde WHERE Vorname = 'George'),
	(SELECT Personalnummer FROM Mitarbeiter WHERE Vorname = 'Marc'),
	DATEADD(day, 8, CAST(GETDATE() AS DATE)),
	DATEADD(day, 18, CAST(GETDATE() AS DATE)),
	75);

SELECT * FROM Ausleihe;

-- Strafgebühr auf 0 setzen
UPDATE Ausleihe SET Strafgebuehr = 0; 

SELECT * FROM Ausleihe;

-- Ausleihe um 7 Tage verschieben
UPDATE Ausleihe SET Enddatum = DATEADD(DAY, 7, Enddatum); 

UPDATE Ausleihe SET Startdatum = DATEADD(DAY, 7, Startdatum) WHERE Ausleihe_ID = 4; --Für Verständnis

SELECT * FROM Ausleihe;

-- Erscheinungsjahr präzesieren
UPDATE Buch SET Erscheinungsjahr = -375 WHERE ISBN = '9783150000014';

SELECT * FROM Buch WHERE ISBN = 9783150000014;

-- Beschreibung ergänzen 
UPDATE Kategorie SET Beschreibung = 'Weltliteratur – bekannt über Generationen' WHERE Bezeichnung = 'Klassiker'; 

SELECT * FROM Kategorie

-- Hauptsitz ergänzen
UPDATE Verlag SET Hauptsitz = 'Berlin' WHERE Name = 'Suhrkamp'; 

SELECT * FROM Verlag

-- Adressen aktualisieren
UPDATE Kunde SET Adresse = 'Bahnhofstrasse 25', PLZ = '6210', Ort = 'Sursee', Land = 'Schweiz' WHERE Vorname = 'Max' OR Vorname = 'Lewis';

SELECT * FROM Kunde; 

-- Mitarbeiter befördern
UPDATE Mitarbeiter SET Funktion = 'Stv. Leiter/in' WHERE Vorname = 'Tom'; 

SELECT COUNT(*) AS 'Anzahl Tom' FROM Mitarbeiter WHERE Vorname = 'Tom';

SELECT * FROM Mitarbeiter; 

-- Reservation beenden
UPDATE Buch_Kunde 
SET Enddatum = DATEADD(DAY, 3, CAST(GETDATE() AS date))
	WHERE fk_Kunde_ID = ( SELECT Kundennummer FROM Kunde WHERE Vorname = 'Max' AND Nachname = 'Verstappen') 
	AND fk_Buch_ID = (SELECT Buch_ID FROM Buch WHERE Titel = 'Hamlet');

SELECT * FROM Buch_Kunde; 

-- Kunde "Sergio" löschen
SELECT COUNT(*) AS 'Anz Sergio' FROM Kunde WHERE Vorname = 'Sergio';

DELETE Kunde WHERE Vorname = 'Sergio';

SELECT * FROM Kunde; 

-- Kunde überprüfen und löschen
SELECT COUNT(*) AS 'Anz Fernando' FROM Kunde WHERE Vorname = 'Fernando' AND Kundennummer NOT IN (SELECT fk_Kunde_ID FROM Buch_Kunde);

DELETE FROM Kunde WHERE Vorname = 'Fernando' AND Kundennummer NOT IN (SELECT fk_Kunde_ID FROM Buch_Kunde);

SELECT * FROM Kunde; 

-- Max und Lewis löschen
DELETE FROM Kunde WHERE Vorname IN ('Max', 'Lewis') AND Kundennummer NOT IN (SELECT fk_Kunde_ID FROM Buch_Kunde);

SELECT * FROM Kunde; 

-- Reservationen aufräumen
SELECT * FROM Buch_Kunde WHERE Enddatum < CAST(GETDATE() AS date); 

DELETE FROM Buch_Kunde WHERE Enddatum < CAST(GETDATE() AS date);

-- Buch überprüfen und löschen

DELETE FROM Buch_Kategorie WHERE fk_Buch_ID = (SELECT Buch_ID FROM Buch WHERE Titel = 'Ein Sommernachtstraum');
DELETE FROM Buch_Autor WHERE fk_Buch_ID = (SELECT Buch_ID FROM Buch WHERE Titel = 'Ein Sommernachtstraum'); 

DELETE FROM Buch 
WHERE ISBN = (SELECT ISBN FROM Buch WHERE Titel = 'Ein Sommernachtstraum')
AND Buch_ID NOT IN (SELECT fk_Buch_ID FROM Buch_Kunde)
AND Buch_ID NOT IN (SELECT fk_Buch_ID FROM Buch_Kategorie)
AND Buch_ID NOT IN (SELECT fk_Buch_ID FROM Buch_Autor)
AND Buch_ID NOT IN (SELECT fk_Buch_ID FROM Ausleihe);

SELECT * FROM Buch; 