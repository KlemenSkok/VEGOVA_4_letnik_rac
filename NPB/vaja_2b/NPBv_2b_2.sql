/* Klemen Skok, R4.A, 6. 11. 2024 */
/* MySQL SUPB */

/* mysql -u root -p */

/* 1. */
CREATE DATABASE GlasbenaZbirka_innoDB;
ALTER DATABASE GlasbenaZbirka_innoDB CHARACTER SET utf8;

/* 2. */
CREATE TABLE Avtor (
    AvtorID INT PRIMARY KEY,
    Ime VARCHAR(20) not null,
    Priimek VARCHAR(20) not null,
    Opus SET('opera', 'kantata', 'simfonija', 'koncert', 'balada', 'drugo') not null
) ENGINE=InnoDB;

CREATE TABLE Posnetek (
    PID INT PRIMARY KEY,
    Naslov VARCHAR(30) not null,
    Genre ENUM('klasika', 'pop', 'jazz') not null,
    Trajanje TIME not null,
    AvtorID INT,
    CONSTRAINT posnetek_avtor_fk FOREIGN KEY (AvtorID) REFERENCES Avtor(AvtorID)
) ENGINE=InnoDB;

CREATE TABLE CD (
    CDID INT PRIMARY KEY,
    Naslov VARCHAR(30) not null,
    Cena DECIMAL(3, 2) not null, -- natanko 2 decimalni mesti
    Opombe VARCHAR(150) null,
    lastnik INT not null
) ENGINE=innoDB;

CREATE TABLE Vsebina (
    CDID INT,
    PID INT,
    CONSTRAINT vsebina_cd_fk FOREIGN KEY (CDID) REFERENCES CD(CDID),
    CONSTRAINT vsebina_posnetek_fk FOREIGN KEY (PID) REFERENCES Posnetek(PID),
    PRIMARY KEY (CDID, PID)
) ENGINE=innoDB;

CREATE TABLE Lastnik (
    LID INT PRIMARY KEY,
    Ime VARCHAR(20) not null,
    Priimek VARCHAR(20) not null,
    Tel VARCHAR(20) not null,
    eMail VARCHAR(30) not null
) ENGINE=InnoDB;

/* 
Postavljanje integritetnih omejitev v tabeli vsebina je uspelo:
-----------------------+
| vsebina | CREATE TABLE `vsebina` (
  `CDID` int(11) NOT NULL,
  `PID` int(11) NOT NULL,
  PRIMARY KEY (`CDID`,`PID`),
  KEY `vsebina_posnetek_fk` (`PID`),
  CONSTRAINT `vsebina_cd_fk` FOREIGN KEY (`CDID`) REFERENCES `cd` (`CDID`),
  CONSTRAINT `vsebina_posnetek_fk` FOREIGN KEY (`PID`) REFERENCES `posnetek` (`PID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci |
*/

/* 3. */
SHOW TABLES;
SHOW CREATE TABLE Avtor;
SHOW CREATE TABLE Posnetek;
SHOW CREATE TABLE CD;
SHOW CREATE TABLE Vsebina;
SHOW CREATE TABLE Lastnik;

/* 4. */
ALTER TABLE CD add CONSTRAINT cd_lastnik_fk FOREIGN KEY (Lastnik) REFERENCES Lastnik(LID);

/* 5. */
ALTER TABLE CD ADD COLUMN Leto YEAR not null;

/* 6. */
DESCRIBE CD;

/* 7. */
-- tabela, ki ima enako vsebino kot tabela lastnik
CREATE TABLE Owner (
    LID INT PRIMARY KEY,
    Ime VARCHAR(20) not null,
    Priimek VARCHAR(20) not null,
    Tel VARCHAR(20) not null,
    eMail VARCHAR(30) not null
) ENGINE=InnoDB;

/* 8. */
ALTER TABLE Avtor MODIFY Ime VARCHAR(20) not null AFTER Priimek;
ALTER TABLE Lastnik MODIFY Ime VARCHAR(20) not null AFTER Priimek;

/* 9. */
INSERT INTO Avtor VALUES (10, 'Orff', 'Carl', 'opera,kantata,drugo');
INSERT INTO Avtor VALUES (20, 'Gounod', 'Charles', 'opera,simfonija,drugo');
INSERT INTO Avtor VALUES (30, 'Adams', 'Brian', 'balada,drugo');
INSERT INTO Avtor VALUES (40, 'Cohen', 'Leonard', 'balada,drugo');
INSERT INTO Avtor VALUES (50, 'Donizetti', 'Gaetano', 'opera');

/* 10. */
ALTER TABLE Avtor ADD COLUMN letoRojstva YEAR not null;

/* 11. */
UPDATE Avtor SET letoRojstva = 1895 WHERE AvtorID = 10;
UPDATE Avtor SET letoRojstva = 1818 WHERE AvtorID = 20;
UPDATE Avtor SET letoRojstva = 1959 WHERE AvtorID = 30;
UPDATE Avtor SET letoRojstva = 1934 WHERE AvtorID = 40;
UPDATE Avtor SET letoRojstva = 1797 WHERE AvtorID = 50;

-- nekateri vnosi spodletijo, ker lahko YEAR shrani le vrednosti od 1901 do 2155
ALTER TABLE Avtor MODIFY letoRojstva INT not null;
UPDATE Avtor SET letoRojstva = 1895 WHERE AvtorID = 10;
UPDATE Avtor SET letoRojstva = 1818 WHERE AvtorID = 20;
UPDATE Avtor SET letoRojstva = 1797 WHERE AvtorID = 50;

/* 12. */
SELECT * FROM Avtor;

/* 13. */
EXIT;

/* 14. */
-- mysql -u root -p
USE GlasbenaZbirka_innoDB;

/* 15. */
CREATE TABLE Drzava (
    DID INT AUTO_INCREMENT,
    ImeDrzave VARCHAR(20) not null
) AUTO_INCREMENT=100 
ENGINE=InnoDB;
-- ne uspe, ker mora biti atribut s AUTO_INCREMENT ključ

/* 16. */
CREATE TABLE Drzava (
    DID INT PRIMARY KEY AUTO_INCREMENT,
    ImeDrzave VARCHAR(20) not null
) AUTO_INCREMENT=100 
ENGINE=InnoDB;

/* 17. */
INSERT INTO Drzava VALUES (100, 'Canada');
INSERT INTO Drzava VALUES (200, 'Italia');
INSERT INTO Drzava VALUES (300, 'Deutschland');
INSERT INTO Drzava VALUES (400, 'France');
INSERT INTO Drzava VALUES (500, 'Slovenija');

/* 18. */
insert into drzava (imeDrzave) values ('Austria');
-- dobi vrednost 501, ker je to naslednje število od največjega ključa

/* 19. */
ALTER TABLE Avtor ADD DID INT DEFAULT 500;
ALTER TABLE Avtor ADD CONSTRAINT avtor_drzava_fk FOREIGN KEY (DID) REFERENCES Drzava(DID);

/* 20. */
UPDATE Avtor SET DID = 300 WHERE AvtorID = 10;
UPDATE Avtor SET DID = 400 WHERE AvtorID = 20;
UPDATE Avtor SET DID = 100 WHERE AvtorID = 30;
UPDATE Avtor SET DID = 100 WHERE AvtorID = 40;
UPDATE Avtor SET DID = 200 WHERE AvtorID = 50;

/* 21. */
SELECT ime, priimek
FROM Avtor
WHERE FIND_IN_SET('opera', Opus) > 0 
    AND FIND_IN_SET('kantata', Opus) > 0;

/* 22. */
DELETE FROM Drzava WHERE DID = 300;
-- brisanje ni uspelo, ker je to tuji kljuc v drugi tabeli

/* 23. */
SELECT ime, priimek, imeDrzave
FROM Avtor INNER JOIN Drzava ON (Avtor.DID = Drzava.DID);

/* 24. */
EXIT;
-- mysqldump -u root -p GlasbenaZbirka_innoDB > GlasbenaZbirka_innoDB.sql