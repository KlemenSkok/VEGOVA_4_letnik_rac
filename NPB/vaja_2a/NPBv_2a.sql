
/* Klemen Skok, R4.A */

/* isql -user sysdba -password masterkey */

CREATE DATABASE 'GlasbenaZbirka.fdb' USER sysdba PASSWORD masterkey;
CONNECT 'GlasbenaZbirka.fdb' USER sysdba PASSWORD masterkey;

/* 2. */
CREATE DOMAIN Zvrst VARCHAR(10) DEFAULT '' NOT NULL
CHECK (VALUE IN ('pop', 'rok', 'klasika', 'jazz'));

/* 3. */
CREATE TABLE Avtor(
	AvtorID INT PRIMARY KEY,
	Ime VARCHAR(20) not null,
	Priimek VARCHAR(20) not null
);

CREATE TABLE Posnetek(
	PID INT PRIMARY KEY,
	Naslov VARCHAR(30) not null,
	Genre ZVRST not null,
	Trajanje TIME not null,
	AvtorID INT NOT NULL,
	CONSTRAINT posnetek_avtor_fk FOREIGN KEY (AvtorID) REFERENCES Avtor(AvtorID)
);

CREATE TABLE CD (
	CDID INT PRIMARY KEY,
	NaslovCD VARCHAR(30) not null,
	Cena NUMERIC(2) not null,
	Opombe VARCHAR(150),
	Lastnik INT not null
);

CREATE TABLE Vsebina (
	CDID INT not null,
	PID INT not null,
	CONSTRAINT vsebina_cd_pfk FOREIGN KEY (CDID) REFERENCES CD(CDID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT vsebina_posnetek_pfk FOREIGN KEY (PID) REFERENCES Posnetek(PID) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (CDID, PID)
);

CREATE TABLE Lastnik (
	LID INT PRIMARY KEY,
	Ime VARCHAR(20) not null,
	Priimek VARCHAR(20) not null,
	Tel VARCHAR(20) not null,
	eMail VARCHAR(30) not null,
	CONSTRAINT check_email_has_at CHECK (eMail LIKE '*@*')
);

ALTER TABLE Posnetek DROP CONSTRAINT posnetek_avtor_fk;
ALTER TABLE Posnetek ADD CONSTRAINT posnetek_avtor_fk FOREIGN KEY (AvtorID) REFERENCES Avtor(AvtorID) ON DELETE NO ACTION ON UPDATE CASCADE;

/* 4. */
SHOW TABLES;
/* 5. */
SHOW DOMAINS;

/* 6. */
/* OPISI TABEL */
/* 7. */
/* OPISI DOMEN */

/* 8. */
ALTER TABLE CD ADD leto INT;
ALTER TABLE CD ADD CONSTRAINT cd_leto_ck
CHECK (leto >= 1982);

/* 9. */
ALTER TABLE CD ADD CONSTRAINT cd_lastnik_fk FOREIGN KEY (Lastnik) REFERENCES Lastnik(LID) ON DELETE CASCADE ON UPDATE CASCADE;

/* 10. */


/* 11. */
SELECT * FROM Avtor;

/* 12. */
ALTER TABLE Lastnik ALTER Priimek POSITION 2;
ALTER TABLE Avtor ALTER Priimek POSITION 2;

/* 13. */
INSERT INTO Avtor VALUES(10, 'Orff', 'Carl');
INSERT INTO Avtor VALUES(20, 'Gounod', 'Charles');
INSERT INTO Avtor VALUES(30, 'Adams', 'Brian');
INSERT INTO Avtor VALUES(40, 'Cohen', 'Leonard');
INSERT INTO Avtor VALUES(50, 'Donizetti', 'Gaetano');

/* 14. */
ALTER TABLE Avtor ADD letoRojstva SMALLINT;
ALTER TABLE Avtor ADD CONSTRAINT avtor_letoRojstva_ck
CHECK (letoRojstva <= CAST(LEFT(CURRENT_DATE, 4) AS INT));

/* 15. */
UPDATE Avtor SET letoRojstva = 1895 WHERE AvtorID = 10;
UPDATE Avtor SET letoRojstva = 1818 WHERE AvtorID = 20;
UPDATE Avtor SET letoRojstva = 1937 WHERE AvtorID = 30;
UPDATE Avtor SET letoRojstva = 1934 WHERE AvtorID = 40;
UPDATE Avtor SET letoRojstva = 1797 WHERE AvtorID = 50;

/* 16. */
SELECT * FROM Avtor;

/* 17. */
/* izhod, podatki se shranijo */
EXIT;

/* 18. */
/* isql -user sysdba -password masterkey */
CONNECT 'GlasbenaZbirka.fdb' USER sysdba PASSWORD masterkey;

/* 19. */
CREATE TABLE Drzava (
	DID INT not null,
	ImeDrzave VARCHAR(20) not null
);

/* 20. */
ALTER TABLE Drzava ADD CONSTRAINT PK_drzava PRIMARY KEY (DID);

/* 21. */
ALTER TABLE Drzava ADD CONSTRAINT imeDrzave_unique UNIQUE (ImeDrzave);

/* 
ce je napaka, da ja tabela "in use:"
SET TRANSACTION WAIT;
*/

/* 22. */
INSERT INTO Drzava VALUES(1, 'Canada');
INSERT INTO Drzava VALUES(2, 'Italia');
INSERT INTO Drzava VALUES(3, 'Deutschland');
INSERT INTO Drzava VALUES(4, 'France');
INSERT INTO Drzava VALUES(5, 'Slovenija');

/* 23. */
ALTER TABLE Avtor ADD DID INT DEFAULT 5;
ALTER TABLE Avtor ADD CONSTRAINT avtor_drzava_fk FOREIGN KEY (DID) REFERENCES Drzava(DID) ON DELETE SET DEFAULT ON UPDATE CASCADE;

/* 24. */
UPDATE Avtor SET DID = 1 WHERE AvtorID = 30;
UPDATE Avtor SET DID = 2 WHERE AvtorID = 50;
UPDATE Avtor SET DID = 3 WHERE AvtorID = 10;
UPDATE Avtor SET DID = 4 WHERE AvtorID = 20;
UPDATE Avtor SET DID = 1 WHERE AvtorID = 40;

/* 25 */
SELECT * FROM Avtor;

/* 26. */
DELETE FROM Drzava WHERE DID = 3;

/* 27 */
DROP TABLE Drzava;
/*
Brisanje tabele Drzava ni uspelo, ker je njen primarni ključ tuji ključ v tabeli Avtor
*/