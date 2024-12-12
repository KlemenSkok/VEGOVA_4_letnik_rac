/* Klemen Skok, R4.A, 5. 11. 2024 */
/* MySQL SUPB */

/* mysql -u root -p */

/* 1. */
CREATE DATABASE DemoPB;
/* baza se ustvari kot mapa (v xampp/mysql/data/) */

/* 2., 3. */
CREATE TABLE Predmet (
    PID INT AUTO_INCREMENT PRIMARY KEY,
    Kratica CHAR(3) not null,
    ImePredmeta VARCHAR(20) not null,
    kreditneTocke TINYINT not null,
    Opis VARCHAR(200)
) AUTO_INCREMENT = 100
CHARACTER SET utf8;

/* 4. */
SHOW CREATE TABLE Predmet;
/* Uporabljen je način hranjenja InnoDB */

/* 5. */
INSERT INTO Predmet VALUES (NULL, 'MAT', 'Matematika', 19, 'Splošni predmet.');
INSERT INTO Predmet VALUES (NULL, 'NPB', 'Napredna uporaba podatkovnih baz', 8, 'Strokovni predmet.');
INSERT INTO Predmet VALUES (NULL, 'FIZ', 'Fizika', 6, 'Splošni predmet.');
INSERT INTO Predmet VALUES (NULL, 'NSA', 'Načrtovanje in razvoj spletnih aplikacij', 8, 'Strokovni predmet.');
INSERT INTO Predmet VALUES (NULL, 'TEH', 'Multimedijska tehnologija', 8, 'Strokovni predmet.');

/* 6. */
ALTER TABLE Predmet ADD COLUMN stUrNaTeden TINYINT;
ALTER TABLE Predmet ADD CONSTRAINT stUrNaTeden CHECK (stUrNaTeden IN (2, 3, 4, 5, 6));

/* 7. */
SHOW CREATE TABLE Predmet;
/* vrednost AUTO_INCREMENT-a je zdaj 105 */

/* 8. */
UPDATE Predmet SET stUrNaTeden = 4 WHERE PID IN (100, 101, 104);
UPDATE Predmet SET stUrNaTeden = 3 WHERE PID = 102;
UPDATE Predmet SET stUrNaTeden = 5 WHERE PID = 103;

/* 9. */
ALTER TABLE Predmet ADD COLUMN Opomba VARCHAR(100) null;

/* 10. */
SELECT * FROM Predmet;

/* 11. */
UPDATE Predmet SET Opomba = 'zahtevno uporabno' WHERE PID = 100;
UPDATE Predmet SET Opomba = 'zanimivo uporabno' WHERE PID = 103;
UPDATE Predmet SET Opomba = 'zanimivo' WHERE PID = 102;

/* 12. */
/* imajo 2 opombi (ali več) */
SELECT ImePredmeta
FROM Predmet
WHERE LOCATE(' ', Opomba) > 0;

/* 13. */
/* nimajo opombe uporabno */
SELECT ImePredmeta
FROM Predmet
WHERE LOCATE('uporabno', Opomba) = 0;

/* 14 */
/* 4 ure tedensko */
SELECT ImePredmeta
FROM Predmet
WHERE stUrNaTeden = 4;

EXIT;
/* mysqldump -u root -p DemoPB > DemoPB.sql */