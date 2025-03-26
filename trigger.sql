CREATE DATABASE AutoRegister

CREATE TABLE autod(
autoID int PRIMARY KEY IDENTITY(1,1),
registreerimismark varchar(6) NOT NULL,
mark varchar(30),
esmaneRegistreerimine DATE,
kere varchar(30),
varvus varchar(30),
voimsuskW int,
kutus varchar(30),
kaigukast varchar(30),
omanik varchar(30));

SELECT * FROM autod;

CREATE TABLE logi(
id int PRIMARY KEY IDENTITY(1,1),
aeg DATETIME,
toiming varchar(100),
andmed TEXT,
kasutaja varchar(30));

SELECT * FROM autod;
SELECT * FROM logi;

CREATE TRIGGER autoLisamine
ON autod
FOR INSERT
AS
INSERT INTO logi(aeg, toiming, andmed, kasutaja)
SELECT GETDATE(),
'Uus auto/d on lisatud',
CONCAT ('registreerimismark: ', inserted.registreerimismark, ' / mark: ', inserted.mark, ' / omanik: ', inserted.omanik),
SUSER_NAME()
FROM inserted;

INSERT INTO autod (registreerimismark, mark, esmaneRegistreerimine, kere, varvus, voimsuskW, kutus, kaigukast, omanik)  
VALUES  
('123ABC', 'Toyota Corolla', '2018-05-12', 'Sedaan', 'Sinine', 85, 'Bensiin', 'Automaat', 'Jaan Tamm'),  
('456DEF', 'Volkswagen Golf', '2020-08-25', 'Luukpära', 'Must', 96, 'Diisel', 'Manuaal', 'Mari Mets'),  
('789GHI', 'BMW X5', '2019-03-17', 'Maastur', 'Valge', 195, 'Bensiin', 'Automaat', 'Peeter Põld'),  
('321JKL', 'Audi A4', '2017-11-30', 'Sedaan', 'Hall', 110, 'Diisel', 'Automaat', 'Laura Kask'),  
('654MNO', 'Honda Civic', '2021-06-14', 'Luukpära', 'Punane', 90, 'Bensiin', 'Manuaal', 'Karl Kivi'),  
('987PQR', 'Ford Focus', '2016-09-05', 'Universaal', 'Sinine', 74, 'Bensiin', 'Automaat', 'Anna Saar'),  
('135STU', 'Mercedes-Benz C200', '2019-12-20', 'Sedaan', 'Must', 150, 'Diisel', 'Automaat', 'Erik Leht'),  
('246VWX', 'Škoda Octavia', '2015-04-08', 'Luukpära', 'Roheline', 77, 'Diisel', 'Manuaal', 'Piret Maasik'),  
('357YZA', 'Nissan Qashqai', '2022-01-15', 'Maastur', 'Hall', 103, 'Hübriid', 'Automaat', 'Toomas Ruut'),  
('468BCD', 'Tesla Model 3', '2023-07-10', 'Sedaan', 'Valge', 283, 'Elektri', 'Automaat', 'Kati Kask');  

SELECT * FROM autod;
SELECT * FROM logi;

CREATE TRIGGER autoUuendamine
ON autod
FOR UPDATE
AS
INSERT INTO logi(aeg, toiming, andmed, kasutaja)
SELECT
GETDATE(),
'andmete uuendamine',
CONCAT('Vanad andmed: registreerimismark:', deleted.registreerimismark, ', mark: ', deleted.mark, ', esmane registreerimine: ', deleted.esmaneRegistreerimine, ', kere: ', deleted.kere, ', varvus: ', deleted.varvus, ', voimsus (kW)', deleted.voimsuskW, ', kutus: ', deleted.kutus, ', kaigukast: ', deleted.kaigukast, ', omanik: ', deleted.omanik, ' / Uued andmed: registreerimismark: ', inserted.registreerimismark, ', mark: ', inserted.mark, ', esmane registreerimine: ', inserted.esmaneRegistreerimine, ', kere: ', inserted.kere, ', varvus: ', inserted.varvus, ', voimsus (kW)', inserted.voimsuskW, ', kutus: ', inserted.kutus, ', kaigukast: ', inserted.kaigukast, ', omanik: ', inserted.omanik),
SUSER_NAME()
FROM deleted
INNER JOIN inserted
ON deleted.autoID=inserted.autoID

UPDATE autod
SET omanik='Anna Oleks'
WHERE autoID=3;

SELECT * FROM autod;
SELECT * FROM logi;

CREATE TRIGGER autoKustutamine
ON autod
FOR DELETE
AS
INSERT INTO logi(aeg, toiming, andmed, kasutaja)
SELECT
GETDATE(),
'andmete kustutamine',
CONCAT ('registreerimismark: ', deleted.registreerimismark, ' / mark: ', deleted.mark, ' / omanik: ', deleted.omanik),
SUSER_NAME()
FROM deleted;

DELETE FROM autod
WHERE autoID=7;

SELECT * FROM autod;
SELECT * FROM logi;

---------------------------------------------------------

create database triger2tabelid;
use triger2tabelid;

Create table linnad(
linnID int identity(1,1) PRIMARY KEY,
linnanimi varchar(15),
rahvaarv int);

Create table logi(
id int identity(1,1) PRIMARY KEY,
aeg DATETIME,
toiming varchar(100),
andmed text
);

CREATE TABLE maakond(
    maakondID int primary key identity(1,1),
    maakond varchar(100) UNIQUE,
  pindala int);
    
INSERT INTO maakond(maakond)
VALUES ('Harjumaa');
INSERT INTO maakond(maakond)
VALUES ('Pärnumaa');

SELECT * FROM maakond

ALTER TABLE linnad ADD maakondID int;
ALTER TABLE linnad ADD CONSTRAINT fk_maakond
FOREIGN KEY (maakondID) References maakond(maakondID) 

SELECT * FROM linnad;
SELECT * FROM maakond;

INSERT INTO linnad(linnanimi, rahvaarv, maakondID)
VALUES ('Tallinn', 60000, 100)

--disable
CREATE TRIGGER linnalisamine
ON linnad
FOR INSERT
AS INSERT INTO logi(aeg, toiming, andmed)
SELECT 
GETDATE(),
'on tehtud INSERT',
CONCAT(m.maakond, ', ', inserted.linnanimi, ', ', inserted.rahvaarv)
FROM inserted
INNER JOIN maakond m ON m.maakondID=inserted.maakondID;

--trigeri kustustamine
drop trigger linnalisamine;

--puhasta logi tabeli
DELETE FROM logi;

--kontroll
INSERT INTO linnad(linnanimi, rahvaarv, maakondID)
VALUES ('Saue', 20000, 2)

SELECT * FROM logi;
SELECT * FROM linnad;

ALTER TABLE logi 
ADD kasutaja varchar(25);

CREATE TRIGGER linnakustutamie
ON linnad
FOR DELETE
AS INSERT INTO logi(aeg, toiming, andmed, kasutaja)
SELECT 
GETDATE(),
'on tehtud DELETE',
CONCAT(m.maakond, ', ', deleted.linnanimi, ', ', deleted.rahvaarv),
SUSER_NAME()
FROM deleted
INNER JOIN maakond m ON m.maakondID=deleted.maakondID;

SELECT * FROM linnad;

DELETE FROM linnad
WHERE linnID=5;

SELECT * FROM linnad;
SELECT * FROM logi;

CREATE TRIGGER linnauuendamine
ON linnad
FOR UPDATE
AS INSERT INTO logi(aeg, toiming, andmed, kasutaja)
SELECT 
GETDATE(),
'on tehtud UPDATE',
CONCAT('vanad andmed: ', m1.maakond, ', ', deleted.linnanimi, ', ', deleted.rahvaarv, 'uued andmed: ', m2.maakond, ', ', inserted.linnanimi, ', ', inserted.rahvaarv),
SUSER_NAME()
FROM deleted
INNER JOIN inserted ON deleted.linnID=inserted.linnID
INNER JOIN maakond m1 ON m1.maakondID=deleted.maakondID
INNER JOIN maakond m2 ON m2.maakondID=inserted.maakondID;

--kontroll
UPDATE linnad SET maakondID=1
WHERE linnID=4;

SELECT * FROM linnad;
SELECT * FROM logi;
