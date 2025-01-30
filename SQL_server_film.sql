CREATE DATABASE AndmebaasOleks;

USE AndmebaasOleks;
CREATE TABLE film(
filmID int PRIMARY KEY identity(1,1),
filmNimetus varchar(30) not null,
aasta int,
eelarveHind decimal(7,1)
);
SELECT * FROM film;

--tabeli kustutamine
--DROP TABLE film;

--andmete sisestamine tabelisse
INSERT INTO film(filmNimetus,aasta,eelarveHind)
VALUES('Barby', 2023, 10000.5)

DELETE FROM film WHERE filmID=5;

CREATE TABLE zanr(
zanrID int PRIMARY KEY identity(1,1),
zanrNimetus varchar(20) UNIQUE
)
DROP TABLE zanr

INSERT INTO zanr(zanrNimetus)
VALUES('draama'), ('detektiiv'), ('fantasy');
SELECT * FROM zanr;

--tabeli film struktuuri muutmine --> uue veergu lisamine
ALTER TABLE film ADD zanrID int;
SELECT * FROM film;
--tabeli film struktuuri muutmine -->
--FK lisamine mis on seotud tabeliga zanr(zanrID)
ALTER TABLE film ADD CONSTRAINT fk_zanr
FOREIGN KEY(zanrID) REFERENCES zanr(zanrID);

select *from film;
select *from zanr;
UPDATE film SET zanrID=1 where filmID=3

CREATE TABLE rezisoor(
rezID int PRIMARY KEY identity(1,1),
rezNimi varchar(20),
synniaeg date,
riik varchar(20)
)

ALTER TABLE film ADD rezID int;
SELECT * FROM film;

INSERT INTO rezisoor(rezNimi,synniaeg,riik)
VALUES('Quentin Tarantino', '1963-03-27', 'USA');
SELECT * FROM rezisoor;

select *from film;
select *from zanr;
select *from rezisoor;

ALTER TABLE film ADD CONSTRAINT fk_rezisoor
FOREIGN KEY(rezID) REFERENCES rezisoor(rezID);

UPDATE film SET rezID=2 where filmID=6
UPDATE film SET zanrID=2 where filmID=2

CREATE TABLE kinokava(
kavaID int PRIMARY KEY identity(1,1),
filmID int,
rezID int,
kuupaev date,
aeg time
)
DROP TABLE kinokava

select *from film;
select *from zanr;
select *from rezisoor;
select *from kinokava;

INSERT INTO kinokava(filmID,rezID,kuupaev,aeg)
VALUES(6, 2, '2025-01-30','19:00');

ALTER TABLE film ADD CONSTRAINT fk_zanr
FOREIGN KEY(zanrID) REFERENCES zanr(zanrID);

ALTER TABLE kinokava ADD CONSTRAINT fk_film
FOREIGN KEY(filmID) REFERENCES film(filmID);

ALTER TABLE kinokava ADD CONSTRAINT fkf_rezisoor
FOREIGN KEY(rezID) REFERENCES rezisoor(rezID);
