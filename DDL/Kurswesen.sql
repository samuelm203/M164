-- Sicherstellen das man auf Master ist
USE master;

-- Datenbank "Kurswesen" erstellen und auf die erstellte Datenbank wechseln 
CREATE DATABASE Kurswesen;

USE Kurswesen; 

-- Tabelle "Kurs" erstellen
CREATE TABLE Kurs (
	KursID INT IDENTITY(1,1) PRIMARY KEY, 
	BEZ NVARCHAR(100) NOT NULL, 
	MaxTeilnehmer INT NOT NULL, 
	Kosten INT NOT NULL, 
	StartDatum DATE NOT NULL, 
	Dauer DECIMAL(2,1) NOT NULL
);