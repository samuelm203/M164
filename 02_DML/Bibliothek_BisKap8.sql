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