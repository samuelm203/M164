# M164 – Datenbanken (SQL-Skripte)

Dieses Repository enthält T-SQL-Skripte aus dem Modul **M164 – Datenbanken**.

## Struktur

```text
M164/
├── 00_Zusatz/
│   ├── ERD/UnihockeyStats.drawio
│   └── UnihockeyStats.drawio
├── 01_DDL/                     # Data Definition Language
│   ├── Bibliothek.sql
│   ├── ComputerShop.sql
│   ├── ComputerShopFullScript.sql
│   ├── Druckerverwaltung.sql
│   ├── Fahrzeugpark.sql
│   └── Kurswesen.sql
├── 02_DML/                     # Data Manipulation Language
│   ├── Bibliothek.sql
│   ├── Bibliothek_BisKap8.sql
│   ├── Fahrzeugpark.sql
│   └── Kurswesen.sql
└── 03_DQL/
    └── BikeLager/
        ├── BikeLager.sql
        └── Vorbereitung/Bike_Lager Datenbank.sql
```

## Inhalte

### 01_DDL
Skripte zum Erstellen von Datenbankschemas und Constraints für:
- Bibliothek
- ComputerShop
- Druckerverwaltung
- Fahrzeugpark
- Kurswesen

### 02_DML
Skripte zum Einfügen, Aktualisieren und Löschen von Daten für:
- Bibliothek
- Fahrzeugpark
- Kurswesen

### 03_DQL
Abfragen (SELECT, JOIN, GROUP BY, ORDER BY) für das Beispiel **Bike_Lager**.

### 00_Zusatz
Zusätzliche Unterlagen (u. a. ERD als `.drawio`).

## Technologien

- **Datenbanksystem:** Microsoft SQL Server (T-SQL)
- **Konzepte:** DDL, DML, DQL, Primär- und Fremdschlüssel, Constraints, Joins, Aggregationen
