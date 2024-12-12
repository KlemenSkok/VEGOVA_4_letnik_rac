/* Klemen Skok, R4.A, 8. 11. 2024 */
/* Firebird SUPB */

/* isql -USER sysdba -PASSWORD masterkey */

CONNECT prodajavozil2.fdb USER sysdba PASSWORD masterkey;

/* a */
SELECT pc.imeprodajalca, pc.priimekprodajalca
FROM prodajalec pc LEFT OUTER JOIN prodaja pa ON (pc.prodajalecid = pa.prodajalecid) 
GROUP BY pc.imeprodajalca, pc.priimekprodajalca
HAVING AVG(procpopusta) >= 0.07
ORDER BY AVG(procpopusta) DESC;

/* funkcije */
IN "C:\Program Files\Firebird\Firebird_3_0\UDF\ib_udf2.sql";

/* b */
SELECT 'Prodajalec ' || SUBSTRING(imeprodajalca FROM 1 FOR 1) || '. ' || RTRIM(pc.priimekprodajalca) || ' se ni prodal nobenega vozila!' AS priimek
FROM prodajalec pc LEFT OUTER JOIN prodaja pa 
    ON (pc.prodajalecid = pa.prodajalecid)
WHERE pa.voziloid IS NULL;

/* c */
SELECT first 1 EXTRACT(MONTH FROM datumprodaje) AS mesec
FROM prodaja
GROUP BY EXTRACT(MONTH FROM datumprodaje)
ORDER BY (EXTRACT(MONTH FROM datumprodaje)) DESC;

/* d */
SELECT v.znamka
FROM kupec k INNER JOIN prodaja pa ON (k.DavSt = pa.DavSt)
    INNER JOIN vozilo v ON (pa.VoziloID = v.VoziloID)
WHERE UPPER(k.KrajKupca) IN ('LJUBLJANA', 'MARIBOR')
GROUP BY (v.znamka);

/* e */
SELECT SUM(v.osnovnacena - v.osnovnacena * pa.procpopusta) AS skupna_vrednost
FROM kupec k INNER JOIN prodaja pa ON (k.DavSt = pa.DavSt)
    INNER JOIN vozilo v ON (pa.VoziloID = v.VoziloID)
WHERE UPPER(k.KrajKupca) = 'LJUBLJANA' AND EXTRACT (YEAR FROM pa.datumprodaje) = 2010
/* GROUP BY (k.KrajKupca) */;

/* f */
UPDATE prodajalec 
SET PriimekProdajalca = UPPER(LEFT(PriimekProdajalca, 3)) || RIGHT(PriimekProdajalca, STRLEN(PriimekProdajalca)-3)
WHERE POSITION('LEN' IN UPPER(PriimekProdajalca)) > 0;
-- pazi: case sensitive

/* g */
UPDATE vozilo
SET OsnovnaCena = ROUND(OsnovnaCena * 0.75, 2)
WHERE letnik = 2010 AND status = 'na zalogi';

/* h */
SELECT COUNT(VoziloID) AS stevilo_vozil
FROM vozilo
WHERE status = 'na zalogi';

/* i */
DELETE FROM prodajalec
WHERE ImeProdajalca LIKE 'P%';
-- ni uspelo. Ker so nekateri prodajalci prodali vozila, ne izbriše nobenega

/* j */
UPDATE vozilo
SET OsnovnaCena = osnovnacena - 350
WHERE SUBSTRING(status FROM 8 FOR 2) = '1 ';

/* k */
INSERT INTO kupec VALUES (12345678, 'Klemen', 'Skok', 'Vegova 4', 'Ljubljana');

/* l */
INSERT INTO prodaja VALUES (5, 12345678, '10.11.2024', 1, 0.4, 200.0);
-- ne uspe, ker je največji dovoljen popust 30%

/* m */
SELECT FIRST 1 k.ImeKupca, k.PriimekKupca/* , COUNT(pa.VoziloID) AS stevilo_vozil */
FROM kupec k INNER JOIN prodaja pa ON (k.DavSt = pa.DavSt)
GROUP BY k.ImeKupca, k.PriimekKupca
ORDER BY COUNT(pa.VoziloID) DESC;

/* n */
SELECT v.znamka, v.model, k.PriimekKupca, k.ImeKupca, pa.datumprodaje, ROUND(v.OsnovnaCena - v.OsnovnaCena * pa.procpopusta, 2) AS koncna_cena
FROM kupec k INNER JOIN prodaja pa ON (k.DavSt = pa.DavSt)
    INNER JOIN vozilo v ON (pa.VoziloID = v.VoziloID)
WHERE DATEDIFF(MONTH FROM pa.datumprodaje TO CURRENT_DATE) <= 24;
-- DATEDIFF(MONTH FROM starejsi_datum TO novejsi_datum) -> st mesecev

/* o */
SELECT v.znamka, v.model, k.PriimekKupca, k.ImeKupca, pa.datumprodaje, ROUND(v.OsnovnaCena - v.OsnovnaCena * pa.procpopusta, 2) AS koncna_cena
FROM kupec k INNER JOIN prodaja pa ON (k.DavSt = pa.DavSt)
    INNER JOIN vozilo v ON (pa.VoziloID = v.VoziloID)
WHERE DATEDIFF(DAY FROM pa.datumprodaje TO CURRENT_DATE) <= 60;
