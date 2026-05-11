-- Überprüfung ob die Datenbank existiert, wenn ja wird sie gelöscht
USE master; 
DROP DATABASE IF EXISTS ComputerShop;

GO

-- Datenbank "ComputerShop" erstellen 
USE master;
GO

CREATE DATABASE ComputerShop;
GO

USE ComputerShop;
GO

-- Tabelle "Kunden", "Artikel" und "Bestellung" erstellen
CREATE TABLE Artikel (
	Artikel_ID INTEGER IDENTITY(1, 1) PRIMARY KEY,
	Bezeichnung NVARCHAR(200) NOT NULL, 
	Preis NUMERIC(9,2) NOT NULL
);

GO

CREATE TABLE Kunde (
	Kunde_ID INTEGER IDENTITY(1, 1) PRIMARY KEY, 
	Nachname NVARCHAR(100) NOT NULL, 
	Vorname NVARCHAR(100) NOT NULL
); 

GO

CREATE TABLE Bestellung (
	Bestellung_ID INTEGER IDENTITY(1, 1) PRIMARY KEY, 
	Datum DATE NOT NULL, 
	Komplettlieferung BIT NOT NULL, 
	fk_Artikel_ID INTEGER NOT NULL, 
	fk_Kunde_ID INTEGER NOT NULL
);

GO

-- Zwischentabellen erstellen 
CREATE TABLE Besteht_Aus (
    fk_Bestellung_ID INTEGER,
    fk_Artikel_ID INTEGER,
    PRIMARY KEY (fk_Bestellung_ID, fk_Artikel_ID),
    FOREIGN KEY (fk_Bestellung_ID) REFERENCES Bestellung (Bestellung_ID),
    FOREIGN KEY (fk_Artikel_ID) REFERENCES Artikel (Artikel_ID)
);

GO

ALTER TABLE Bestellung 
	DROP COLUMN fk_Artikel_ID;
GO

-- Zwischentabelle "Besteht_aus" ergänzen
ALTER TABLE Besteht_aus 
	ADD Anzahl INTEGER;
GO

-- Alle notwendigen Beziehungen erstellen
ALTER TABLE Bestellung 
    ADD CONSTRAINT FK_Bestellung_Kunde 
    FOREIGN KEY (fk_Kunde_ID) REFERENCES Kunde (Kunde_ID);
GO
	
-- In der Tabelle "Bestellung" die Spalte "Datum" in "Bestelldatum" ändern 
EXEC sp_rename 'Bestellung.Datum',  'Bestelldatum', 'COLUMN';

-- Regeln zu Verbesserung der Datenbank hinzufügen
ALTER TABLE Artikel 
	ADD CONSTRAINT ch_preis 
	CHECK (Preis > 0 AND Preis <= 10);
GO

ALTER TABLE Besteht_Aus 
	ADD CONSTRAINT ch_artikel 
	CHECK (Anzahl > 0); 
GO

ALTER TABLE Bestellung 
	ADD CONSTRAINT ch_gesamtbestellung
	DEFAULT 0 FOR Komplettlieferung; 
GO

ALTER TABLE Bestellung 
	ADD CONSTRAINT ch_bestelldatum
	DEFAULT GETDATE() FOR Bestelldatum;
GO

ALTER TABLE Bestellung 
	ADD CONSTRAINT ch_bestelldatumZukunft
	CHECK (Bestelldatum <= GETDATE()); 
GO 
