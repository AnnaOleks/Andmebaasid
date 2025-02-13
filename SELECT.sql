CREATE DATABASE AnnaOleks

Use AnnaOleks
CREATE TABLE laps(
lapsID int primary key identity(1,1),
nimi varchar(10) not null,
pikkus smallint,
synniaasta smallint,
synnilinn varchar(20)
);
SELECT * FROM laps;

INSERT INTO laps(nimi,pikkus,synniaasta,synnilinn)
VALUES 
('Kira',166,2000,'Tallinn'),
('Richard',170,2005,'Tallinn'),
('Karl',154,2003,'Tallinn'),
('Vasja',173,2009,'Tallinn'),
('Leo',168,2002,'Tallinn')

--sorteerimine
SELECT nimi, pikkus
FROM laps
ORDER BY pikkus DESC, nimi; 
--Asc, Desc (от большего к меньшему)

--lapsed mis on syndinud peale 2005
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta>=2005
ORDER by nimi;

--DISTINCT - выяснить какие значения есть. Показывает 1 повторение. 
SELECT DISTINCT synniaasta
FROM laps
WHERE synniaasta>2000;

--BETWEEN
--lapsed mis on syndinu (2000 kuni 2005)
SELECT nimi, synniaasta
FROM laps
WHERE synniaasta>=2000 and synniaasta<=2005


SELECT nimi, synniaasta
FROM laps
WHERE synniaasta BETWEEN 2000 and 2005;

--LIKE
--näita lapsed, kelle nimi algab K
--% kõik võimalikud sümbolis
-- sisaldab K täht - '%K%'
SELECT nimi
FROM laps
WHERE nimi like 'K%';

SELECT nimi
FROM laps
WHERE nimi like '%K%';

-- täpsem määratud tähtede arv_
SELECT nimi
FROM laps
WHERE nimi like '_a__';

--AND / OR
SELECT nimi, synnilinn
FROM laps
WHERE nimi like 'K%' OR synnilinn like 'Tartu';

SELECT nimi, synnilinn
FROM laps
WHERE nimi like 'K%' AND synnilinn like 'Tartu';

--Agregaatfunktsioonid
SUM, AVG, MIN, MAX, COUNT
SELECT COUNT(nimi) AS 'laste arv' --Если с пробелом, то в ковычках
FROM laps;

SELECT AVG(pikkus) AS KeskminePikkus
FROM laps
WHERE synnilinn='Tallinn';

--Näita keskmine pikkus linnade järgi
--GROUP by
SELECT AVG(pikkus) AS KeskminePikkus, synnilinn
FROM laps
GROUP by synnilinn;

--näita laste arv mis on sündinud konkreetsel sünniaastal
SELECT synniaasta, count(*) AS lastearv
FROM laps
GROUP by synniaasta

--HAVING --ограничение для уже сгруппированных данных
--keskmine pikkus iga aasta järgi
SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
GROUP by synniaasta
HAVING AVG(pikkus)>170;

SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
WHERE synniaasta=2005
GROUP by synniaasta;

SELECT synniaasta, AVG(pikkus) AS keskmine
FROM laps
WHERE NOT synniaasta=2005
GROUP by synniaasta;

--seotud tabel
CREATE TABLE loom(
loomID int PRIMARY KEY identity(1,1),
loomNimi varchar(50),
lapsID int,
FOREIGN KEY (lapsID) REFERENCES laps(lapsID)
);

INSERT INTO loom(loomNimi, lapsID)
VALUES('kass Kott', 2),
('Koer Doris', 1),
('Koer Kiana', 1),
('Koer Bobik', 3),
('Koer Tuzik', 3),
('Kass Ljalja', 4),
('Kass Murka', 5),
('Kilpkonn', 5),
('Papagoi Kesha', 6),
('Papagoi Gena', 6),
('Kass Masja', 6)

SELECT * FROM loom;

--select seotud tabelite põhjal
SELECT * FROM loom, laps; --ei näita õiged andmed

SELECT*FROM loom
INNER JOIN laps
ON loom.lapsID=laps.lapsID;

--lihtne vaade
SELECT l.loomNimi, la.nimi, la.synniaasta
FROM loom l,laps la
WHERE l.lapsID=la.lapsID;











