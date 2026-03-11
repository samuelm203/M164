-- Datenbank "Druckerverwaltung" erstellen
USE master;  -- Wecheselt auf Master

Create DATABASE Druckerverwaltung -- Mit Create wird die Datenbank "Druckerverwaltung" erstellt
USE Druckerverwaltung -- Wechselt auf die Datenbank "Druckerverwaltung"

-- Tabelle "Standort" und "Mitarbeiter" erstellen
CREATE TABLE Standort ( -- Tabelle "Standort" wird erstellt
	Standort_ID integer IDENTITY(1, 1) PRIMARY KEY, -- Der Wert "Standort_ID" wird erstellt, mit Identity wird automatisch pro Eintrag um 1 hochgezählt und anhand von dem Primary Key erkennt man das jeder Eintrag einzigartig ist
	Bezeichnung nvarchar(50) NOT NULL -- Der Wert "Bezeichnung" wird als Buchstabenkette gespeichert, die nicht null sein darf
); 

CREATE TABLE Mitarbeiter ( -- Die Tabelle "Mitarbeiter" wird erstellt 
	Mitarbeiter_ID integer IDENTITY(1, 1) PRIMARY KEY, -- Der Wert "Mitarbeiter_ID" wird erstellt als integer (also Zahl), anhand von diesem erkennt man das jeder Mitarbeiter / jede Mitarbeiterin einzigartig ist auch dies wirt automatisch pro Eintrag um 1 hochgezählt
	Vorname nvarchar(50) NOT NULL, -- Der Wert "Vorname" wird als Buchstabenkette gespeichert mit der max. Länge 50, die nicht null sein darf 
	Nachname nvarchar(50) NOT NULL, -- Der Wert "Nachname" wird als Buchstabenkette gespeichert mit der max. Länge 50, die nicht null sein darf
	Tel_Intern nvarchar(10) NULL
); 

-- Tabelle "Drucker" erstellen
CREATE TABLE Drucker (
	Drucker_ID integer IDENTITY(1, 1) PRIMARY KEY, 
	Bezeichnung nvarchar(50) NOT NULL, 
	Typ nvarchar(30) NOT NULL, 
	Seriennummer nvarchar(20) NOT NULL, 
	Kaufdatum date NULL, 
	fk_Mitarbeiter_ID integer
)

-- Tabelle "Drucker" ergänzen mit neuem Feld "Kaufpreis"
ALTER TABLE Drucker
	ADD Kaufpreis DECIMAL(2) 

-- Fremdschlüssel in der Tabelle "Drucker" hinzufügen
ALTER TABLE Drucker ADD FOREIGN KEY (fk_Mitarbeiter_ID)
	REFERENCES Mitarbeiter (Mitarbeiter_ID)

ALTER TABLE Drucker ADD fk_Standort_ID 
	integer FOREIGN KEY REFERENCES Standort (Standort_ID)

-- Ein Skript für alles 
USE master; 
DROP DATABASE IF EXISTS Druckerverwaltung

CREATE DATABASE Druckerverwaltung

USE Druckerverwaltung; 

CREATE TABLE Standort (
	Standort_ID integer IDENTITY(1, 1) PRIMARY KEY,
	Bezeichnung nvarchar(50) NOT NULL
); 

CREATE TABLE Mitarbeiter (
	Mitarbeiter_ID integer IDENTITY(1, 1) PRIMARY KEY, 
	Vorname nvarchar(50) NOT NULL, 
	Nachname nvarchar(50) NOT NULL, 
	Tel_Intern nvarchar(10) NULL
); 

CREATE TABLE Drucker (
	Drucker_ID integer IDENTITY(1, 1) PRIMARY KEY, 
	Bezeichnung nvarchar(50) NOT NULL, 
	Typ nvarchar(30) NOT NULL, 
	Seriennummer nvarchar(20) NOT NULL, 
	Kaufdatum date NULL, 
	fk_Mitarbeiter_ID integer FOREIGN KEY REFERENCES Mitarbeiter (Mitarbeiter_ID), 
	fk_Standort_ID integer FOREIGN KEY REFERENCES Standort (Standort_ID)
)
