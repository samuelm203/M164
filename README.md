# M164 – Datenbanken (SQL-Skripte)

Dieses Repository enthält T-SQL-Skripte, die im Rahmen des Moduls **M164 – Datenbanken** erstellt wurden. Die Skripte sind in zwei Kategorien unterteilt: **DDL** (Data Definition Language) und **DML** (Data Manipulation Language).

---

## Struktur

```
M164/
├── DDL/                        # Datenbankschema-Skripte
│   ├── Bibliothek.sql          # Vollständiges Schema der Bibliotheksdatenbank
│   ├── ComputerShop.sql        # Schema des ComputerShops (schrittweise aufgebaut)
│   ├── ComputerShopFullScript.sql  # Überarbeitetes, bereinigtes ComputerShop-Schema
│   ├── Druckerverwaltung.sql   # Schema zur Verwaltung von Druckern
│   ├── Fahrzeugpark.sql        # Schema zur Verwaltung eines Fahrzeugparks
│   └── Kurswesen.sql           # Schema zur Verwaltung von Kursen
└── DML/                        # Datenmanipulations-Skripte
    ├── Bibliothek.sql           # Vollständige Testdaten und DML-Operationen
    ├── Bibliothek_BisKap8.sql  # Testdaten für die Bibliothek bis Kapitel 8
    ├── Fahrzeugpark.sql        # Testdaten und DML-Operationen für den Fahrzeugpark
    └── Kurswesen.sql           # Testdaten und DML-Operationen für das Kurswesen
```

---

## DDL – Data Definition Language

### Bibliothek (`DDL/Bibliothek.sql`)

Dieses Skript erstellt die Datenbank **Bibliothek** mit folgenden Tabellen:

| Tabelle         | Beschreibung |
|-----------------|--------------|
| `Autor`         | Autoren mit Vorname, Nachname und Geburtsdatum |
| `Verlag`        | Verlage mit Name und Hauptsitz |
| `Kategorie`     | Buchkategorien; anfangs mit Text-PK, später mit Integer-ID |
| `Mitarbeiter`   | Bibliotheksmitarbeitende mit Funktion |
| `Kunde`         | Kunden mit Adressdaten |
| `Buch`          | Bücher mit ISBN, Titel, Erscheinungsjahr und Verlagsreferenz |
| `Ausleihe`      | Ausleihvorgänge (Buch ↔ Kunde ↔ Mitarbeiter, Datum, Strafgebühr) |
| `Buch_Autor`    | m:n-Beziehung zwischen Büchern und Autoren |
| `Buch_Kategorie`| m:n-Beziehung zwischen Büchern und Kategorien |
| `Buch_Kunde`    | Reservationen (m:n-Beziehung zwischen Büchern und Kunden) |

**Aufbau im Skript (nach Aufgaben):**
- **Aufgabe 3–4:** Datenbank und Basistabellen erstellen
- **Aufgabe 5:** Zwischentabellen für m:n-Beziehungen hinzufügen
- **Aufgabe 6:** Fremdschlüssel via `ALTER TABLE` hinzufügen
- **Aufgabe 7:** Primärschlüssel von `Kategorie` von Text auf Integer umstellen
- **Aufgabe 8:** Spalte `Jahr` in `Buch` umbenennen zu `Erscheinungsjahr`
- **Aufgabe 9:** CHECK-, UNIQUE- und DEFAULT-Constraints hinzufügen

---

### ComputerShop (`DDL/ComputerShop.sql` & `DDL/ComputerShopFullScript.sql`)

Zwei Varianten eines Schemas für einen **Online-ComputerShop** mit den Tabellen:

| Tabelle        | Beschreibung |
|----------------|--------------|
| `Artikel`      | Produkte mit Bezeichnung und Preis |
| `Kunde`        | Kundenstammdaten |
| `Bestellung`   | Bestellungen mit Datum und Liefermodus |
| `Besteht_Aus`  | m:n-Zwischentabelle (Bestellung ↔ Artikel) mit Anzahl |

Enthaltene Constraints:
- `CHECK`: Preis muss zwischen 0 und 10 liegen (im Skript so definiert); Anzahl muss > 0 sein
- `DEFAULT`: Standardwert 0 für `Komplettlieferung`; aktuelles Datum für `Bestelldatum`
- `CHECK`: `Bestelldatum` darf nicht in der Zukunft liegen

Das **FullScript** (`ComputerShopFullScript.sql`) ist eine aufgeräumte und kommentierte Version, die das Schema direkt korrekt erstellt, ohne schrittweise `ALTER TABLE`-Anpassungen.

---

### Druckerverwaltung (`DDL/Druckerverwaltung.sql`)

Schema zur Verwaltung von **Druckern in einem Unternehmen** mit den Tabellen:

| Tabelle       | Beschreibung |
|---------------|--------------|
| `Standort`    | Standorte im Unternehmen |
| `Mitarbeiter` | Mitarbeitende mit internem Telefon |
| `Drucker`     | Drucker mit Typ, Seriennummer, Kaufdatum, Kaufpreis und Zuordnung zu Mitarbeiter und Standort |

Das Skript enthält zuerst eine schrittweise Entwicklung, dann ein vollständiges Einzelskript (Drop + Create).

---

### Fahrzeugpark (`DDL/Fahrzeugpark.sql`)

Dieses Skript erstellt die Datenbank **Fahrzeugpark** mit folgenden Tabellen:

| Tabelle       | Beschreibung |
|---------------|--------------|
| `Mitarbeiter` | Mitarbeitende mit Vor- und Nachname |
| `Fahrzeug`    | Fahrzeuge mit Marke, Typ, Neupreis, Jahrgang, Occasion-Flag und optionaler Mitarbeiterzuordnung |

---

### Kurswesen (`DDL/Kurswesen.sql`)

Dieses Skript erstellt die Datenbank **Kurswesen** mit folgender Tabelle:

| Tabelle | Beschreibung |
|---------|--------------|
| `Kurs`  | Kurse mit Bezeichnung, maximaler Teilnehmerzahl, Kosten, Startdatum und Dauer |

---

## DML – Data Manipulation Language

### Bibliothek (`DML/Bibliothek.sql` & `DML/Bibliothek_BisKap8.sql`)

Diese Skripte befüllen und manipulieren die Bibliotheksdatenbank:

**Eingefügte Testdaten:**
- 6 Verlage (Diogenes, dtv, Suhrkamp, Fischer, Reclam, Kein & Aber)
- 6 Kategorien (Fantasy, Satire, Dystopie, Klassiker, Philosophie, Drama)
- 7 Autoren (u. a. Neil Gaiman, Tolkien, George Orwell, Shakespeare, Platon)
- 5 Mitarbeitende
- 8 Kunden mit Adressdaten
- 8 Bücher (u. a. Good Omens, Der Herr der Ringe, 1984, Romeo und Julia, Hamlet)

**DML-Operationen (UPDATE / DELETE):**
- Strafgebühren auf 0 setzen
- Ausleihdaten um 7 Tage verschieben
- Erscheinungsjahre korrigieren
- Kategoriebeschreibungen ergänzen
- Kundenadressen aktualisieren
- Mitarbeiter befördern
- Reservationen verlängern
- Kunden und Bücher sicher löschen (mit Abhängigkeitsprüfung via Subqueries)

---

### Kurswesen (`DML/Kurswesen.sql`)

Dieses Skript befüllt und manipuliert die Kurswesen-Datenbank:

**Eingefügte Testdaten:**
- 5 Kurse (z. B. Windows 11, Word 2024, Word 365, Excel 365, Windows 11 Neuheiten)

**DML-Operationen (UPDATE / DELETE):**
- Startdatum und Teilnehmerzahl eines Kurses anpassen
- Veralteten Kurs löschen
- Teilnehmerzahlen erhöhen (neue Schulungsräume)
- Startdatum um 7 Tage verschieben

---

### Fahrzeugpark (`DML/Fahrzeugpark.sql`)

Dieses Skript befüllt und manipuliert die Fahrzeugpark-Datenbank:

**Eingefügte Testdaten:**
- 12 Mitarbeitende (u. a. Didier Chuche, Beat Feuz, Marco Odermatt)
- 12 Fahrzeuge (u. a. Ford Model T, VW Käfer, Ferrari 250 GTO, Porsche 911, Lamborghini Miura)

**DML-Operationen (UPDATE / DELETE / ALTER):**
- Fahrzeuge Mitarbeitenden zuweisen (via `UPDATE` mit Subquery)
- Fahrzeuge kaufen und verkaufen (`INSERT` / `DELETE`)
- Kennzeichen-Spalte hinzufügen (`ALTER TABLE`) und Werte setzen
- Mitarbeitende sicher löschen (FK-Referenzen zuvor auf `NULL` setzen)
- Zeitwert-Spalte hinzufügen und altersabhängig berechnen (mittels `CASE WHEN`)
- Occasionsfahrzeuge mit Zeitwert ≥ 100 000 um 20 % reduzieren

---

## Technologien

- **Datenbanksystem:** Microsoft SQL Server (T-SQL)
- **Konzepte:** DDL, DML, Primär- und Fremdschlüssel, Constraints (CHECK, UNIQUE, DEFAULT), m:n-Beziehungen, `ALTER TABLE`, `sp_rename`, Subqueries
