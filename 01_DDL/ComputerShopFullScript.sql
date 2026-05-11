USE master;
GO

-- 1. Datenbank löschen falls vorhanden und neu erstellen
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'ComputerShop')
BEGIN
    DROP DATABASE ComputerShop;
END
GO

CREATE DATABASE ComputerShop;
GO

USE ComputerShop;
GO

-- 2. Tabellen erstellen
-- Tabelle: Artikel
CREATE TABLE Artikel (
    Artikel_ID INTEGER IDENTITY(1, 1) PRIMARY KEY,
    Bezeichnung NVARCHAR(200) NOT NULL, 
    Preis NUMERIC(9,2) NOT NULL
);
GO

-- Tabelle: Kunde
CREATE TABLE Kunde (
    Kunde_ID INTEGER IDENTITY(1, 1) PRIMARY KEY, 
    Nachname NVARCHAR(100) NOT NULL, 
    Vorname NVARCHAR(100) NOT NULL
); 
GO

-- Tabelle: Bestellung
CREATE TABLE Bestellung (
    Bestellung_ID INTEGER IDENTITY(1, 1) PRIMARY KEY, 
    Bestelldatum DATE NOT NULL, 
    Komplettlieferung BIT NOT NULL, 
    fk_Kunde_ID INTEGER NOT NULL
);
GO

-- Tabelle: Besteht_Aus (Zwischentabelle für m:n Beziehung)
CREATE TABLE Besteht_Aus (
    fk_Bestellung_ID INTEGER,
    fk_Artikel_ID INTEGER,
    Anzahl INTEGER NOT NULL,
    PRIMARY KEY (fk_Bestellung_ID, fk_Artikel_ID),
    FOREIGN KEY (fk_Bestellung_ID) REFERENCES Bestellung (Bestellung_ID),
    FOREIGN KEY (fk_Artikel_ID) REFERENCES Artikel (Artikel_ID)
);
GO

-- 3. Beziehungen (Foreign Keys) und Constraints hinzufügen
-- Fremdschlüssel für Bestellung -> Kunde
ALTER TABLE Bestellung 
    ADD CONSTRAINT FK_Bestellung_Kunde 
    FOREIGN KEY (fk_Kunde_ID) REFERENCES Kunde (Kunde_ID);
GO

-- Check-Constraints für Datenvalidierung
ALTER TABLE Artikel 
    ADD CONSTRAINT ch_preis 
    CHECK (Preis > 0 AND Preis <= 10); 
GO

ALTER TABLE Besteht_Aus 
    ADD CONSTRAINT ch_artikel_anzahl 
    CHECK (Anzahl > 0); 
GO

-- Default-Werte setzen
ALTER TABLE Bestellung 
    ADD CONSTRAINT df_komplettlieferung
    DEFAULT 0 FOR Komplettlieferung; 
GO

ALTER TABLE Bestellung 
    ADD CONSTRAINT df_bestelldatum
    DEFAULT GETDATE() FOR Bestelldatum;
GO

-- Validierung: Bestelldatum darf nicht in der Zukunft liegen
ALTER TABLE Bestellung 
    ADD CONSTRAINT ch_bestelldatumZukunft
    CHECK (Bestelldatum <= GETDATE()); 
GO