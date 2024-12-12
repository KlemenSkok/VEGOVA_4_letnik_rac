/* Klemen Skok, R4.A, 6. 11. 2024 */
/* MySQL SUPB */

/* mysql -u root -p */

/* 1. */
CREATE DATABASE JavnaUprava;
USE JavnaUprava;

/* 2. */
CREATE TABLE Pokrajina (
    PokrajinaID INT PRIMARY KEY,
    ImePokrajine VARCHAR(20) not null
);

CREATE TABLE Kraj (
    KrajID INT PRIMARY KEY,
    PokrajinaID INT not null,
    ImeKraja VARCHAR(30) not null,
    CONSTRAINT kraj_pokrajina_fk FOREIGN KEY (PokrajinaID) REFERENCES Pokrajina(PokrajinaID)
);

/* 3. */
ALTER TABLE Pokrajina ADD Opis VARCHAR(50) null;

/* 4. */
ALTER TABLE Kraj ADD SteviloPrebivalcev INT null;
ALTER TABLE Kraj ADD CONSTRAINT kraj_st_prebivalcev_ck CHECK (SteviloPrebivalcev >= 0);

/* 5. */
CREATE TABLE Obcan (
    EMSO CHAR(13) PRIMARY KEY,
    Ime VARCHAR(20) not null,
    Priimek VARCHAR(20) not null,
    DatumRojstva DATE not null,
    KrajID INT not null
);

/* 6. */
ALTER TABLE Obcan MODIFY KrajID INT null;
ALTER TABLE Obcan ADD CONSTRAINT obcan_kraj_fk FOREIGN KEY (KrajID) REFERENCES Kraj(KrajID) ON UPDATE CASCADE ON DELETE SET NULL;

/* 7. */
ALTER TABLE Obcan MODIFY Priimek VARCHAR(20) not null AFTER EMSO;

/* 8. */
ALTER TABLE Obcan ADD Spol ENUM('M', 'Z') not null;

/* 9. */
SHOW TABLES;

/* 10. */
DESCRIBE Pokrajina;
DESCRIBE Kraj;
DESCRIBE Obcan;

/* 11. */
CREATE TABLE Obisk (
    EMSO CHAR(13) not null,
    KrajID INT not null,
    DatumObiska DATE not null,
    Vtisi VARCHAR(200) not null DEFAULT 'vse naj',
    /* CONSTRAINT obisk_datum_ck CHECK(DatumObiska <= CURRENT_DATE()), */ 
    CONSTRAINT obisk_kraj_fk FOREIGN KEY (KrajID) REFERENCES Kraj(KrajID),
    CONSTRAINT obisk_obcan_fk FOREIGN KEY (EMSO) REFERENCES Obcan(EMSO),
    PRIMARY KEY (EMSO, KrajID, DatumObiska)
);
-- ne pusti preverjati veljavnosti datuma z uporabo funkcije CURRENT_DATE()
