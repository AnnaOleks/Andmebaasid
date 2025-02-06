--SQL SALVESTATUD PROTSEDUURID-- Funktsioonid - mitu SQL käsku käivitakse järjest

--SQL SERVER--

CREATE DATABASE procTARgv24;

USE procTARgv24;
CREATE TABLE uudised(
uudisID int PRIMARY KEY identity(1,1),
uudiseTeema varchar(50),
kkupaev date,
autor varchar(25),
kirjeldus text
)
SELECT*FROM uudised;
insert into uudised(uudiseTeema, kkupaev,autor,kirjeldus)
VALUES(
'udune ilm','2025-02-06','postimees','lõunani on udune ilm')

--proceduuri loomine
--sisestab uudised tabelisse ja kohe näitab
CREATE PROCEDURE lisaUudis
@uusTeema varchar(50),
@paev date,
@autor varchar(20),
@kirjeldus text
AS
BEGIN

insert into uudised(uudiseTeema, kkupaev,autor,kirjeldus)
VALUES(
@uusTeema,@paev,@autor,@kirjeldus)
SELECT*from uudised;

END;
--kutse
EXEC lisaUudis 'windows11','2025-02-06','õpetaja Pant','w11 ei tööta multimeedia klassis';
--teine kutse võimalus
EXEC lisaUudis @uusTeema='1.märts on juba kevad',
@paev='2025-02-06',
@autor='test',
@kirjeldus='puudub';

--protseduur, mis kustutab tabelist id järgi
CREATE PROCEDURE kustutaUudis
@id int
AS
BEGIN
SELECT*FROM uudised;
DELETE FROM uudised WHERE uudisID=@id;
SELECT*FROM uudised;
END;

--kutse
EXEC kustutaUudis 3;
EXEC kustutaUudis @id=3;

UPDATE uudised SET kirjeldus='uus kirjeldus'
WHERE kirjeldus Like 'puudub';
SELECT*FROM uudised;

--prodseduur, mis uuendab andmeid tabelis/UPDATE
CREATE PROCEDURE uuendaKirjeldus
@uuskirjeldus text
AS
BEGIN
SELECT*FROM uudised;
UPDATE uudised SET kirjeldus=@uuskirjeldus
WHERE kirjeldus Like 'puudub';
SELECT*FROM uudised;
END;

--kutse
EXEC uuendaKirjeldus 'uus tekst kirjelduses';

--protseduur, mis otsib ja näitab uudise esimese tähe järgi
CREATE PROCEDURE otsingUudiseTeema
@taht char(1)
AS
BEGIN
SELECT*FROM uudised
WHERE uudiseTeema LIKE @taht+'%'; 
END;
--% - "все остальные буквы"
