/* Klemen Skok, R4.A, 15. 11. 2024 */
/* Firebird SUPB */


/* isql -user sysdba -password masterkey */

CONNECT prodajavozil2.fdb USER sysdba PASSWORD masterkey;


/* a */
SELECT Model
FROM Vozilo
WHERE Znamka = 'BMW' AND OsnovnaCena < 50000;

/* b */
SELECT pc.ProdajalecID AS ProdajalecID, pc.ImeProdajalca AS Ime, pc.PriimekProdajalca AS Priimek, COUNT(pa.VoziloID) AS "Prodaja leta 2010"
FROM Prodajalec pc LEFT OUTER JOIN Prodaja pa
    ON (pc.ProdajalecID = pa.ProdajalecID) AND EXTRACT(YEAR FROM pa.DatumProdaje) = '2010'
GROUP BY pc.ProdajalecID, pc.ImeProdajalca, pc.PriimekProdajalca;
-- ne izpise vseh!

/* c */
SELECT pc.PriimekProdajalca, pc.ImeProdajalca, v.VoziloID, v.Znamka, ROUND(v.OsnovnaCena * (1 - pa.ProcPopusta) + pa.ProdProvizija, 2) AS koncnacena
FROM Prodajalec pc LEFT OUTER JOIN Prodaja pa
    ON (pc.ProdajalecID = pa.ProdajalecID)
    LEFT OUTER JOIN Vozilo v 
    ON (pa.VoziloID = v.VoziloID)
ORDER BY pc.PriimekProdajalca, pc.ImeProdajalca, v.Znamka;

/* d */
SELECT k.PriimekKupca, k.ImeKupca
FROM Kupec k INNER JOIN Prodaja pa
    ON (k.DavSt = pa.DavSt)
    INNER JOIN Vozilo v
    ON (pa.VoziloID = v.VoziloID)
WHERE v.Znamka = 'Fiat'
GROUP BY k.PriimekKupca, k.ImeKupca
HAVING COUNT(*) > 0;

/* e */
SELECT k.ImeKupca, k.PriimekKupca
FROM Kupec k INNER JOIN Prodaja pa
    ON (k.DavSt = pa.DavSt)
    INNER JOIN Prodajalec pc 
    ON (pa.ProdajalecID = pc.ProdajalecID)
WHERE pc.ImeProdajalca = 'Marjeta' AND pc.PriimekProdajalca = 'Pretnar'
GROUP BY k.ImeKupca, k.PriimekKupca;

/* f */
SELECT v.VoziloID, v.Znamka, v.Model, k.ImeKupca, k.PriimekKupca
FROM Vozilo v INNER JOIN Prodaja pa
    ON (v.VoziloID = pa.VoziloID)
    INNER JOIN Kupec k
    ON (pa.DavSt = k.DavSt)
WHERE v.Letnik = 2010 AND EXTRACT(YEAR FROM pa.DatumProdaje) = 2010;

/* g */
SELECT *
FROM Vozilo v
WHERE Letnik IN (2012, 2007) AND Status = 'na zalogi';

/* h */
SELECT k.KrajKupca, COUNT(pa.VoziloID)
FROM Kupec k INNER JOIN Prodaja pa
    ON (k.DavSt = pa.DavSt)
GROUP BY k.KrajKupca;

/* i */
SELECT k.ImeKupca, k.PriimekKupca
FROM Vozilo v LEFT OUTER JOIN Prodaja pa
    ON (v.VoziloID = pa.VoziloID) AND v.Znamka = 'Fiat'
    RIGHT OUTER JOIN Kupec k
    ON (pa.DavSt = k.DavSt)
GROUP BY k.ImeKupca, k.PriimekKupca
HAVING COUNT(v.VoziloID) = 0;

/* SELECT k.ImeKupca, k.PriimekKupca
FROM Kupec k INNER JOIN Prodaja pa
    ON (k.DavSt = pa.DavSt)
    INNER JOIN Vozilo v
    ON (pa.VoziloID = v.VoziloID)
WHERE k.DavSt NOT IN (
    SELECT k.DavSt
    FROM Kupec k INNER JOIN Prodaja pa
        ON (k.DavSt = pa.DavSt)
        INNER JOIN Vozilo v
        ON (pa.VoziloID = v.VoziloID)
    WHERE v.Znamka = 'Fiat'
    GROUP BY k.DavSt
); */ --! gnezdeni select


/* j */
SELECT FIRST 1 k.PriimekKupca, k.ImeKupca
FROM Vozilo v INNER JOIN Prodaja pa
    ON (v.VoziloID = pa.VoziloID)
    INNER JOIN Kupec k
    ON (pa.DavSt = k.DavSt)
ORDER BY ROUND(v.OsnovnaCena * (1 - pa.ProcPopusta) + pa.ProdProvizija, 2) DESC;

/* k */
SELECT pa.ProdajalecID, v.Znamka, SUM(ROUND(v.OsnovnaCena * (1 - pa.ProcPopusta) + pa.ProdProvizija, 2)) AS skupniZnesek
FROM Vozilo v INNER JOIN Prodaja pa
    ON (v.VoziloID = pa.VoziloID)
GROUP BY pa.ProdajalecID, v.Znamka;

/* l */
SELECT v.Znamka, v.VoziloID, v.Model, pa.DatumProdaje, ROUND(v.OsnovnaCena * (1 - pa.ProcPopusta) + pa.ProdProvizija, 2) AS koncnacena
FROM Vozilo v INNER JOIN Prodaja pa
    ON(v.VoziloID = pa.VoziloID)
ORDER BY v.Znamka, pa.DatumProdaje DESC; 

/* m */
SELECT pc.PriimekProdajalca, pc.ImeProdajalca
FROM Vozilo v NATURAL JOIN Prodaja pa
    INNER JOIN Prodajalec pc
    ON (pa.ProdajalecID = pc.ProdajalecID) AND ROUND(v.OsnovnaCena * (1 - pa.ProcPopusta) + pa.ProdProvizija, 2) > 50000
GROUP BY pc.PriimekProdajalca, pc.ImeProdajalca
HAVING COUNT(*) > 0;