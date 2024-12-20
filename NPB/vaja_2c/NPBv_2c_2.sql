/* Klemen Skok, R4.A, 6. 11. 2024 */
/* Firebird SUPB */

/* 1. */
/* isql -user sysdba -password masterkey */

/* 2. */
CONNECT 'GLASBENAZBIRKA.FDB' USER sysdba PASSWORD masterkey;

/* 3. */
SHOW TABLES;
SHOW TABLE Avtor;
SHOW TABLE CD;
SHOW TABLE Posnetek;
SHOW TABLE Vsebina;
SHOW TABLE Lastnik;
SHOW TABLE Drzava;

/* 4. */
ALTER TABLE CD ADD Leto INT;

/* 5. */
SHOW TABLE CD;

/* 6. */
ALTER TABLE Avtor ALTER Ime POSITION 3;
ALTER TABLE Lastnik ALTER Ime POSITION 3;

/* 7. */
ALTER TABLE Avtor ADD Opus VARCHAR(100);
-- dopustiti moramo NULL vrednosti

/* 
AVTORID                         INTEGER Not Null
PRIIMEK                         VARCHAR(20) Not Null
IME                             VARCHAR(20) Not Null
LETOROJSTVA                     SMALLINT Nullable
DID                             INTEGER Nullable DEFAULT 5
OPUS                            VARCHAR(100) Nullable
CONSTRAINT AVTOR_DRZAVA_FK:
  Foreign key (DID)    References DRZAVA (DID) On Update Cascade On Delete Set Default
CONSTRAINT INTEG_2:
  Primary key (AVTORID)
CONSTRAINT AVTOR_LETOROJSTVA_CK:
  CHECK (letoRojstva <= CAST(LEFT(CURRENT_DATE, 4) AS INT))
 */

/* 8. */
INSERT INTO Avtor VALUES(10, 'Orff', 'Carl', 'opera, kantata, drugo');
INSERT INTO Avtor VALUES(20, 'Gounod', 'Charles', 'opera, simfonija, drugo');
INSERT INTO Avtor VALUES(30, 'Adams', 'Brian', 'balada, drugo');
INSERT INTO Avtor VALUES(40, 'Cohen', 'Leonard', 'balada, drugo');
INSERT INTO Avtor VALUES(50, 'Donizetti', 'Gaetano', 'opera');
SELECT * FROM Avtor;

/* 9. */
ALTER TABLE Avtor ADD DatumRojstva DATE;

/* 10. */
UPDATE Avtor SET DatumRojstva = 1895 WHERE AvtorID = 10;
UPDATE Avtor SET DatumRojstva = 1818 WHERE AvtorID = 20;
UPDATE Avtor SET DatumRojstva = 1959 WHERE AvtorID = 30;
UPDATE Avtor SET DatumRojstva = 1934 WHERE AvtorID = 40;
UPDATE Avtor SET DatumRojstva = 1797 WHERE AvtorID = 50;
-- napaka: tip DATE ne sprejme samo leta
ALTER TABLE Avtor DROP DatumRojstva;
ALTER TABLE Avtor ADD DatumRojstva INT;

/* 11. */
SELECT * FROM Avtor;

/* 12. */
EXIT;

/* 13. */
/* isql -user sysdba -password masterkey */
CONNECT 'GLASBENAZBIRKA.FDB' USER sysdba PASSWORD masterkey;

/* 14. */
CREATE TABLE Drzava (
    DID INT primary key,
    ImeDrzave VARCHAR(20) not null
);
-- ne uspe, ker mora biti DID primary key

/* 15. */
CREATE TABLE Drzava (
    DID INT generated by default as identity primary key,
    ImeDrzave VARCHAR(20) not null
);

/* 16. */
INSERT INTO Drzava VALUES(100, 'Canada');
INSERT INTO Drzava VALUES(200, 'Italia');
INSERT INTO Drzava VALUES(300, 'Deutschland');
INSERT INTO Drzava VALUES(400, 'France');
INSERT INTO Drzava VALUES(500, 'Slovenija');

/* 17. */
ALTER TABLE Avtor ADD DID INT DEFAULT 500;
ALTER TABLE Avtor ADD CONSTRAINT avtor_drzava_fk FOREIGN KEY (DID) REFERENCES Drzava(DID);

/* 18. */
UPDATE Avtor SET DID = 300 WHERE AvtorID = 10;
UPDATE Avtor SET DID = 400 WHERE AvtorID = 20;
UPDATE Avtor SET DID = 100 WHERE AvtorID = 30;
UPDATE Avtor SET DID = 100 WHERE AvtorID = 40;
UPDATE Avtor SET DID = 200 WHERE AvtorID = 50;

/* 19. */
UPDATE Avtor
SET Ime = '', Priimek = ''
WHERE POSITION('opera' IN Opus) > 0 AND POSITION('kantata' IN Opus) > 0;
-- ne moremo brisati stolpcev posameznih vrstic, lahko pa jih posodobimo na prazen niz

/* 20. */
DELETE FROM Drzava WHERE DID = 300;
-- napaka, ker je DID že uporabljen kot tuji ključ