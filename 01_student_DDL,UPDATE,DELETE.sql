SHOW DATABASES;
SHOW TABLES;
SHOW FULL COLUMNS FROM student;

#------------------------------------------------------------------
#1. del je brisanje tabel - DROP TABLE napišete za vse tabele, ki jih boste ustvarili s CREATE TABLE
#------------------------------------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS vpis;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS predmet;
SET FOREIGN_KEY_CHECKS=1;	

#------------------------------------------------------------------
#2. del je kreiranje tabel
#------------------------------------------------------------------
CREATE TABLE student (
	ID_student INT AUTO_INCREMENT PRIMARY KEY, 
	ime VARCHAR(30) NOT NULL,	
	priimek VARCHAR(40) NOT NULL, 	
	vpisna_st VARCHAR(15) NOT NULL,	
	datum_rojstva DATE,	
	email VARCHAR(30),  
	visina FLOAT(4,1),    
	vpisni_stroski DECIMAL(5,2) NOT NULL,     
	spol BOOL,     
	st_majice ENUM('XS','S','M','L','XL'), 
	UNIQUE (`vpisna_st`)
);

CREATE TABLE predmet (
	ID_predmet INT AUTO_INCREMENT PRIMARY KEY, 
	koda_predmeta VARCHAR(30) NOT NULL DEFAULT '999',	
	naziv_predmeta VARCHAR(60) NOT NULL DEFAULT 'NE VEM; TO JE PRIVZETA VREDNOST', 	
	tocke_ECTS INT NOT NULL
);

ALTER TABLE predmet ADD COLUMN samostojno_delo INT;
ALTER TABLE predmet DROP COLUMN samostojno_delo;
ALTER TABLE predmet 
	CHANGE `koda_predmeta` 	`koda_predmeta1` VARCHAR(20);
ALTER TABLE predmet 
	MODIFY tocke_ECTS 	DECIMAL(3,1);

CREATE TABLE vpis (
	ID_vpis INT AUTO_INCREMENT PRIMARY KEY, 
	ocena INT,	
	leto_vpisa VARCHAR(60) NOT NULL,
	TK_student INT NOT NULL,
    TK_predmet INT	
	);
    
#------------------------------------------------------------------
#3. del je dodeljevanje tujih ključev
#------------------------------------------------------------------

ALTER TABLE vpis ADD CONSTRAINT tk_vpis_student	FOREIGN KEY (TK_student) REFERENCES student(id_student)  ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE vpis ADD CONSTRAINT tk_vpis_predmet FOREIGN KEY (TK_predmet) REFERENCES predmet(id_predmet) ON DELETE CASCADE ON UPDATE CASCADE; 
    
SHOW FULL COLUMNS FROM vpis;
#------------------------------------------------------------------
#4. del je vstavljanje podatkov
#------------------------------------------------------------------

INSERT INTO student VALUES (null, 'David', 'Novak' , 'E9320376041', '2001-12-12', 'david@feri.si', 180.3, 12.33, 1, 4);
INSERT INTO student (ime, priimek, vpisna_st, datum_rojstva, email, visina, vpisni_stroski, spol, st_majice) 
	VALUES ('Maja', 'Krajnc' , 'E3107410974', '2001-03-15', 'maja@epf.si', NULL, 15.78, 0, 3);
INSERT INTO student (ime, priimek, vpisna_st, email, visina, vpisni_stroski, spol) 
	VALUES ('Aleš', 'Novak' , 'E1234464687', 'ales@feri.si', 175.3, 12.33, 1);
INSERT INTO student (ime, priimek, vpisna_st, datum_rojstva, visina, vpisni_stroski, spol, st_majice) 
	VALUES ('Maja', 'Malič' , 'E2137410974', '2002-05-15', 165.8, 16.88, 0, 2);
    
    
INSERT INTO predmet VALUES 
		(NULL, '62V108', 'Podatkovne baze I', 5), 
        (NULL, '61V013', 'Računalniška omrežja', 5);
INSERT INTO predmet (koda_predmeta1, naziv_predmeta, tocke_ECTS) VALUES 
('62V014', 'Arhitekture informacijskih sistemov', 5),
('V035', 'Management kakovosti', 5),
('V274', 'Izvedbeni marketing', 6),
('U0003', 'Rimsko pravo', 8);
INSERT INTO predmet (naziv_predmeta, koda_predmeta1, tocke_ECTS) VALUES ('Kazensko materialno pravo', 'U005', 8);

INSERT INTO vpis VALUES (1, 8, '2020/2021', 1, 1);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (7, '2020/2021', 1, 2);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (9, '2020/2021', 2, 4);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (9, '2020/2021', 2, 5);
INSERT INTO vpis (leto_vpisa, TK_student, TK_predmet) VALUES ('2020/2021', 3, 1);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (10, '2020/2021', 3, 3);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (6, '2019/2020', 4, 6);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (8, '2019/2020', 4, 7);


SELECT * FROM student;
SELECT * FROM predmet;
SELECT * FROM vpis;


#------------------------------------------------------------------
# BRISANJE - TRUNCATE in DROP
#------------------------------------------------------------------

SELECT * FROM vpis;

#brisanje vsebine
TRUNCATE TABLE vpis;
SELECT * FROM vpis; 

#brisanje tabele
DROP TABLE IF EXISTS vpis;
SELECT * FROM vpis;

#------------------------------------------------------------------
# BRISANJE podatkov - DELETE
#------------------------------------------------------------------

SELECT * FROM student;

SET SQL_SAFE_UPDATES = 0; #ker se ne sklicujemo na identifikator, moramo izklopiti SAFE_UPDATES ali pa dodamo AND ID_student <> 0, če ni tuj ključ nastavljen na restrict npr. 
DELETE FROM student
      WHERE ime='Maja'; 
SET SQL_SAFE_UPDATES = 1; #po končane brisanju, vklopimo nazaj safe_updates

SELECT * FROM student;

DELETE FROM student	
      WHERE ID_student=1; 
      
SELECT * FROM student;

#------------------------------------------------------------------
# POSODABLJANJE - UPDATE
#------------------------------------------------------------------

#Posodabljanje podatkov - UPDATE
SET SQL_SAFE_UPDATES = 0;

SELECT * FROM predmet;
UPDATE predmet 	SET Naziv_predmeta= 'Podatkovne baze';
SELECT * FROM predmet;
UPDATE predmet 	SET Naziv_predmeta= 'nič', tocke_ECTS = 5;
SELECT * FROM predmet;
UPDATE predmet SET tocke_ECTS = tocke_ECTS + 3;
SELECT * FROM predmet;
UPDATE predmet SET koda_predmeta1 = DEFAULT; #v MySQL nam da na NULL, čeprav smo v tabeli kreirali privzeto vrednost. 
SELECT * FROM predmet;
UPDATE predmet SET Naziv_predmeta= 'Podatkovne baze' WHERE ID_predmet=1; #če še enkrat zaženemo, bo se zagnal stavek (MySQL ne preverja, če je stari vnos enak novemu). 
SELECT * FROM predmet;
UPDATE predmet SET Naziv_predmeta= 'Rimsko pravo - nov predmet' WHERE tocke_ECTS = 8; 
SELECT * FROM predmet;
UPDATE predmet SET Naziv_predmeta= 'Pravni predmeti' WHERE ID_predmet > 4; 
SELECT * FROM predmet;

SET SQL_SAFE_UPDATES = 1;

#------------------------------------------------------------------
# KOMENTARJI
#------------------------------------------------------------------

SELECT 1+1;     #ta komentar se nadaljuje do konca vrstice

SELECT 1+1;     -- ta komentar se nadaljuje do konca vrstice

SELECT 1 /* komentar */ + 1;

SELECT 1+
/*
več
vrstični
komentar 
*/
1;