SELECT * FROM student;
SELECT * FROM vpis;
SELECT * FROM predmet; 

ALTER TABLE predmet 
	CHANGE `koda_predmeta1` 	`koda_predmeta` VARCHAR(20);

SELECT ID_student, ID_predmet, ime, priimek, vpisna_st, datum_rojstva, koda_predmeta, naziv_predmeta, tocke_ECTS, ocena
FROM student, predmet, vpis
WHERE ID_student=TK_student
AND ID_predmet = TK_predmet; 
# ------------------------------------
# SELECT, FROM, *
# ------------------------------------
SELECT * FROM vpis;

# ------------------------------------
# SELECT, FROM, AS
# ------------------------------------
#Želimo izpis vseh IDjev študentov in njihovih ocen.
SELECT TK_student AS 'Študent št.',  leto_vpisa AS 'Leto vpisa', ocena AS 'Ocena studenta'
FROM vpis;

# ------------------------------------
# SELECT, FROM, WHERE
# ------------------------------------
#Želimo izpis predmetov, ki imajo več kot 5 ECTS točk. 
SELECT * 
FROM predmet
WHERE tocke_ECTS > 5; 

# ------------------------------------
# Primerjalni operatorji >, >=, <, <>, !=, <=, =
# ------------------------------------

#Želimo izpis naziva predmetov in ECTS točk predmetov, ki imajo več kot 5 ECTS točk. 
SELECT naziv_predmeta, tocke_ECTS 
FROM predmet
WHERE tocke_ECTS > 5; 
                  #Lahko tudi če smo dali tocke_ECTS v pogoj, ne rabimo dejansko jih izpisat v SELECT
SELECT naziv_predmeta 
FROM predmet
WHERE tocke_ECTS > 5;

# ------------------------------------
# Primerjalni operatorji >, >=, <, <>, !=, <=, =
# ------------------------------------

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS > 6;

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS >= 6;

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS < 6; 

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS <> 6; #ali !=

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS <= 6;

SELECT naziv_predmeta, tocke_ECTS  
FROM predmet
WHERE tocke_ECTS = 6;

# ------------------------------------
# Primerjalni operator BETWEEN ... AND ... / NOT BETWEEN ... AND ...
# ------------------------------------

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva BETWEEN '2001-03-15' AND '2002-01-01';

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva >= '2001-03-15' 
AND datum_rojstva <= '2002-01-01';

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva NOT BETWEEN '2001-03-15' AND '2002-01-01';

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva < '2001-03-15' 
OR datum_rojstva > '2002-01-01';


SELECT * 
FROM predmet; 

# če izbereš samo črke pri VARCHAR podatkovnem tipu, gleda prvo črko v besedi. 
SELECT *
FROM predmet
WHERE naziv_predmeta BETWEEN 'A' AND 'Management kakovosti'; #če bi dali tukaj samo M, bi gledalo, če obstaja predmet, ki ima naziv samo 'M' in nič naprej
#torej ne bi vključilo managementa kakovosti, če bi dali samo M, ker je management > kot samo 'M', ni <= 'M'

SELECT *
FROM predmet
WHERE naziv_predmeta >= 'A' 
AND naziv_predmeta <= 'Management kakovosti';


SELECT 'c' BETWEEN 'a' AND 'c';

# ------------------------------------
# Primerjalni operator IS / IS NOT & GREATEST() 
# ------------------------------------
#IS
SELECT * FROM student;

SELECT ime, priimek, spol 
FROM student 
WHERE spol IS true;


#IS NOT
SELECT ime, priimek, spol 
FROM student 
WHERE spol IS NOT true;

#GREATEST
SELECT GREATEST(5, 6, 7);

# ------------------------------------
# Primerjalni operator IS NULL / IS NOT NULL
# ------------------------------------

#IS NULL
SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva IS NULL;

#če imate npr. v ceni datum_od in datum_do in morate vedeti, katera cena je zadnja, lahko preverite, v kateri vrstici je datum_do še prazen (NULL)

#IS NOT NULL
SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva IS NOT NULL;

# ------------------------------------
# Primerjalni operator LIKE / NOT LIKE
# ------------------------------------

#LIKE
SELECT ocena, leto_vpisa
FROM vpis
WHERE leto_vpisa LIKE '__19/20%';

# deluje tudi na številkah, ampak moramo tudi tam uporabiti ''. 	

# ------------------------------------
# Logični operator AND
# ------------------------------------

SELECT * 
FROM student
WHERE datum_rojstva <= '2001-12-31'
AND ime = 'Maja';

# ------------------------------------
# Logični operator OR
# ------------------------------------

#Želimo izpis študentov, ki so rojeni po letu 2001, in jim je ime Maja in tudi študente s priimkom Novak. 
SELECT * 
FROM student
WHERE datum_rojstva > '2001-12-31'
AND ime = 'Maja'
OR priimek = 'Novak';

SELECT * 
FROM student
WHERE (datum_rojstva > '2001-12-31'
AND ime = 'Maja')
OR priimek = 'Novak';

#razlika, kako postavimo oklepaje!!!
SELECT * 
FROM student
WHERE datum_rojstva > '2001-12-31'
AND (ime = 'Maja'
OR priimek = 'Novak');

# ------------------------------------
# Logični operator NOT
# ------------------------------------

#Želimo izpis študentov, ki se pišejo Novak in jim ni ime David. 
#AND NOT
SELECT * 
FROM student
WHERE priimek = 'Novak'
AND NOT ime = 'David';

# ------------------------------------
# Izpis iz več tabel brez pogojev
# ------------------------------------

#kartezični produkt
SELECT * 
FROM student, vpis;

##Želimo izpis imen predmetov in študentov. 
SELECT ime, naziv_predmeta
FROM student, predmet;

# ------------------------------------
# Združevanje tabel	
# ------------------------------------

#Želimo izpis podatkov o študentih      in vpisu na predmete. 
SELECT *
FROM student, vpis
WHERE student.ID_student = vpis.TK_student;

#Želimo izpis imen in priimkov študentov in njihovih ocen. 
SELECT ime, priimek, ocena
FROM student, vpis
WHERE student.ID_student = vpis.TK_student;

#Želimo izpis imen in priimkov študentov ter vseh stolpcev iz tabele vpis. 
SELECT ime, priimek, vpis.*
FROM student, vpis
WHERE student.ID_student = vpis.TK_student;

# ------------------------------------
# Združevanje tabel	 
# ------------------------------------
SELECT *
FROM student, vpis
WHERE student.ID_student = vpis.TK_student
AND ocena > 7;


# ------------------------------------
# DISTINCT 
# ------------------------------------
#Želimo izpis imen in priimkov študentov, rojenih po letu 2000, ki so dosegli ocene, višje od 7. 
SELECT ime, priimek 
FROM student, vpis
WHERE student.ID_student = vpis.TK_student
AND datum_rojstva > '2000-12-31'
AND ocena > 7;

SELECT DISTINCT ime, priimek 
FROM student, vpis
WHERE student.ID_student = vpis.TK_student
AND datum_rojstva > '2000-12-31'
AND ocena > 7;


# ------------------------------------
# Združevanje več kot 2 tabel hkrati
# ------------------------------------
#Želimo izpis imen in priimkov študentov, rojenih po letu 2000, ki so dosegli ocene, višje od 7 pri predmetih, ki imajo več kot 5 ECTS točk. 
SELECT DISTINCT ime, priimek
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet
AND datum_rojstva > '2000-12-31'
AND ocena > 7
AND tocke_ECTS > 5;


# ------------------------------------
# ORDER BY
# ------------------------------------
#Želimo izpis ocen, predmetov in ime in priimek študentov, tako da bodo najvišje ocene najvišje na seznamu. 
SELECT ime, priimek, naziv_predmeta, ocena
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet
ORDER BY ocena desc;

SELECT ime, priimek, naziv_predmeta, ocena
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet
ORDER BY ocena desc, naziv_predmeta;

# ------------------------------------
# LIMIT
# ------------------------------------

SELECT * FROM predmet ORDER BY ID_predmet ASC;

SELECT ID_predmet, naziv_predmeta, tocke_ECTS
FROM predmet
WHERE tocke_ECTS > 3
LIMIT 3;


#Želimo izpis prvih treh vpisanih predmetov, ki imajo več kot 3 ECTS točke.  
SELECT ID_predmet, naziv_predmeta, tocke_ECTS
FROM predmet
WHERE tocke_ECTS > 3
ORDER BY ID_predmet ASC
LIMIT 3;


SELECT ID_predmet, naziv_predmeta, tocke_ECTS
FROM predmet
WHERE tocke_ECTS > 3
ORDER BY ID_predmet ASC
LIMIT 2,3; #preskoči prva 2 vnosa in zapiše naslednje 3 -> tukaj izpiše samo 2, ker sta samo 2 do konca seznama

SELECT ID_predmet, naziv_predmeta, tocke_ECTS
FROM predmet
WHERE tocke_ECTS > 3
ORDER BY ID_predmet ASC
LIMIT 3 OFFSET 2; #isto kot zgornji primer

SELECT ID_predmet, naziv_predmeta, tocke_ECTS
FROM predmet  
ORDER BY RAND ( )  #izbere random vrednost
LIMIT 2;  

# ------------------------------------
# Računske operacije in operacije nad besedilom
# ------------------------------------

#Računske operacije
SELECT naziv_predmeta, tocke_ECTS, ocena, 
tocke_ECTS+ocena #seštevanje
, tocke_ECTS-ocena #odštevanje
, -tocke_ECTS-ocena #sprememba predznaka
, tocke_ECTS*ocena #množenje
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet;

SELECT naziv_predmeta, ocena, tocke_ECTS, 
ocena/tocke_ECTS #deljenje
, ocena DIV tocke_ECTS #celoštevilsko deljenje
, ocena % tocke_ECTS #modul
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet;


SELECT naziv_predmeta, tocke_ECTS, ocena, tocke_ECTS*(ocena/10) AS 'izmišljeno'
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet;

# Operacije nad besedilom

SELECT naziv_predmeta, leto_vpisa, 
CONCAT(naziv_predmeta, ' -> ', leto_vpisa) #združevanje tekstov v en stolpec
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND ID_predmet < 3;

SELECT naziv_predmeta, leto_vpisa, 
CONCAT(naziv_predmeta, ' -> ', leto_vpisa) #združevanje tekstov v en stolpec
, LCASE(naziv_predmeta), 
UPPER(naziv_predmeta)
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet;

SELECT naziv_predmeta, tocke_ECTS, ocena, 
HEX(naziv_predmeta), 
LENGTH(naziv_predmeta),
SUBSTRING(naziv_predmeta, 3, 5) #odreže prvi 2 črki in nadaljuje s 5 črkami
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet;

# ------------------------------------
# Izbira stolpcev pri združevanju tabel
# ------------------------------------
SELECT student.ime, vpis.ocena
FROM student, vpis
WHERE student.ID_student=vpis.TK_student;

# ------------------------------------
# Poimenovanje tabel
# ------------------------------------
SELECT DISTINCT S.ime as 'Ime študenta', S.priimek as 'Priimek študenta'
FROM student S, vpis V, predmet P
WHERE S.ID_student = V.TK_student
AND P.ID_predmet = V.TK_predmet
AND datum_rojstva > '2000-12-31'	
AND ocena > 7
AND tocke_ECTS > 5;

# ------------------------------------
# IN / NOT IN 
# ------------------------------------
SELECT * 
FROM predmet;

SELECT * 
FROM predmet
WHERE tocke_ECTS IN (5,8);

#NOT IN
SELECT * 
FROM student;

SELECT * 
FROM student
WHERE priimek NOT IN ('Novak','Krajnc');

# ------------------------------------
# Gnezdeni stavki v WHERE, IN
# ------------------------------------
#Želimo izpis nazivov predmetov, v katere so vpisani študenti in so prejeli ocene, višje od 7. 
SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet IN 
(SELECT TK_predmet
FROM vpis
WHERE ocena > 7); 

#isto bi bilo
SELECT ID_predmet, naziv_predmeta
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet 
AND ocena > 7;

SELECT * FROM predmet;
INSERT INTO predmet (koda_predmeta, naziv_predmeta, tocke_ECTS) VALUES ('test', 'Nikogaršnji predmet', 8);

SELECT ID_predmet, naziv_predmeta
FROM predmet
WHERE ID_predmet NOT IN (
SELECT TK_predmet
FROM vpis);

# ------------------------------------
# Gnezdeni stavki v WHERE, IN , NOT IN
# ------------------------------------
SELECT * FROM vpis; 
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (8, '2020/2021', 1, 1);
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (NULL, '2020/2021', 3, 1);

#Želimo izpis nazivov predmetov, v katere so vpisani študenti in so prejeli ocene, višje od 6 ne v letu 2019/2020. 
SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet IN 
	(SELECT TK_predmet
	FROM vpis
	WHERE ocena > 6)
AND NOT ID_predmet IN 
	(SELECT TK_predmet 
	FROM vpis
	WHERE leto_vpisa  = '2019/2020'); 


# ------------------------------------
# Gnezdeni stavki v WHERE, EXISTS, NOT EXISTS
# ------------------------------------

# Želimo izpis nazivov vseh predmetov, če je katerikoli študent pri kateremkoli predmetu prejel oceno več kot 6 in noben študent ni bil vpisan na predmete leta 2018/2019.
	SELECT TK_predmet
	FROM vpis, predmet
	WHERE vpis.TK_predmet = predmet.ID_predmet AND 
    ocena > 6;
    
	SELECT TK_predmet
	FROM vpis, predmet
	WHERE vpis.TK_predmet = predmet.ID_predmet AND 
    leto_vpisa  = '2019/2020';

SELECT ID_predmet, naziv_predmeta
FROM predmet
WHERE EXISTS
	(SELECT *
	FROM vpis
	WHERE vpis.TK_predmet = predmet.ID_predmet AND #pri exists moramo povezati obe tabeli, ker lahko znotraj gnezdenega stavka izpisujemo več stolpcev za razliko od IN!
    ocena > 6) 
AND NOT EXISTS 
	(SELECT *
	FROM vpis
	WHERE vpis.TK_predmet = predmet.ID_predmet AND 
    leto_vpisa  = '2019/2020'); 
    
# ------------------------------------
# Gnezdeni stavki v WHERE, ANY
# ------------------------------------

#Želimo izpis nazivov vseh predmetov, če je katerikoli študent pri kateremkoli predmetu prejel oceno več kot 6, ampak ne v letu 2019/2020.
SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet = ANY 
	(SELECT TK_predmet
	FROM vpis
	WHERE ocena > 6)
AND NOT ID_predmet = ANY 
	(SELECT TK_predmet 
	FROM vpis
	WHERE leto_vpisa  = '2019/2020'); 
    
    
SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet = ANY 
	(SELECT 1);

# ------------------------------------
# Gnezdeni stavki v WHERE, ALL
# ------------------------------------

#Želimo izpis nazivov predmetov, kjer so študenti dobili oceno, višjo od 9, ampak ne v letu 2019/2020.

SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet = ALL 
	(SELECT TK_predmet
	FROM vpis
	WHERE ocena > 9)
AND NOT ID_predmet = ALL 
	(SELECT TK_predmet 
	FROM vpis
	WHERE leto_vpisa  = '2019/2020'); 
    
#Želimo izpis nazivov predmetov, kjer ID predmeta ni 1 ali 3.    
SELECT ID_predmet, naziv_predmeta
FROM predmet 
WHERE ID_predmet <> ALL (SELECT 1)
    AND ID_predmet <> ALL (SELECT 3);

# ------------------------------------
# Operacija UNION 
# ------------------------------------
#UNION / UNION ALL- izbriše podvojene rezultate, če ne napišemo all
SELECT ime as ime FROM student
UNION ALL
SELECT naziv_predmeta as ime FROM predmet
ORDER BY ime;

#brez UNION ALL, se npr. Maja izpiše samo 1x.
SELECT ime as ime FROM student
UNION
SELECT naziv_predmeta as ime FROM predmet
ORDER BY ime;


# ------------------------------------
# Operacija INTERSECT 
# ------------------------------------
#INTERSECT / PRESEK - ne dela v MySQL
#SELECT ocena FROM vpis
#INTERSECT
#SELECT tocke_ECTS FROM predmet;

#lahko se reši intersect / presek tako v MySQL
#Želimo izpis samo ocen, ki so tudi ECTS točke.
SELECT DISTINCT ocena FROM vpis
WHERE ocena IN 
(SELECT tocke_ECTS FROM predmet);

# ------------------------------------
# Operacija EXCEPT / MINUS
# ------------------------------------
#EXCEPT - ne dela, nadomestek je:

#Želimo izpis ocen, ki niso tudi ECTS točke.
SELECT DISTINCT ocena FROM vpis
WHERE ocena NOT IN 
(SELECT tocke_ECTS  FROM predmet);




# ------------------------------------
# INNER JOIN
# ------------------------------------
#Želimo izpis podatkov o študentih, ki so prejeli oceno višjo od 7. 
#primer cross joina - kartezični produkt
SELECT * 
FROM student 
CROSS JOIN vpis  
WHERE ocena > 7;


SELECT *
FROM student
INNER JOIN vpis
ON student.ID_student = vpis.TK_student
WHERE ocena > 7;

SELECT *
FROM student, vpis
WHERE student.ID_student = vpis.TK_student
AND ocena > 7;


# ------------------------------------
# QUERY OPTIMIZATION - vabljeno predavanje
# ------------------------------------
#Nikos

SELECT *
FROM vpis
WHERE ocena > 7 and TK_student > 2;

ANALYZE TABLE vpis;


EXPLAIN FORMAT=TREE
SELECT *
FROM vpis
WHERE ocena > 7;



# ------------------------------------
# INNER JOIN – 3 tabele
# ------------------------------------
#Želimo izpis imen in priimkov študentov, rojenih po letu 2000, ki so dosegli ocene, višje od 7 pri predmetih, ki imajo več kot 5 ECTS točk. 
SELECT DISTINCT ime, priimek
FROM student 
JOIN vpis ON student.ID_student = vpis.TK_student
JOIN predmet ON predmet.ID_predmet = vpis.TK_predmet
WHERE datum_rojstva > '2000-12-31'
AND ocena > 7
AND tocke_ECTS > 5;

SELECT ime, priimek
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet
AND datum_rojstva > '2000-12-31'
AND ocena > 7
AND tocke_ECTS > 5;


# ------------------------------------
# NATURAL JOIN
# ------------------------------------
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS vpis1;
DROP TABLE IF EXISTS student1;
DROP TABLE IF EXISTS predmet1;
SET FOREIGN_KEY_CHECKS=1;	

CREATE TABLE student1 (
	ID_student INT AUTO_INCREMENT PRIMARY KEY, 
	ime VARCHAR(30) NOT NULL,	
	priimek VARCHAR(40) NOT NULL, 	
	vpisna_st VARCHAR(15) NOT NULL,	
	datum_rojstva DATE
);

CREATE TABLE predmet1 (
	ID_predmet INT AUTO_INCREMENT PRIMARY KEY, 
	koda_predmeta VARCHAR(30) NOT NULL,	
	naziv_predmeta VARCHAR(60) NOT NULL DEFAULT 'NE VEM; TO JE PRIVZETA VREDNOST', 	
	tocke_ECTS INT NOT NULL
);

CREATE TABLE vpis1 (
	ID_vpis INT AUTO_INCREMENT PRIMARY KEY, 
	ocena INT,	
	leto_vpisa VARCHAR(60) NOT NULL,
	ID_student INT NOT NULL,
    ID_predmet INT
	);
    
    ALTER TABLE vpis1 ADD CONSTRAINT tk_vpis_student1 FOREIGN KEY (ID_student) REFERENCES student1(ID_student);
    ALTER TABLE vpis1 ADD CONSTRAINT tk_vpis_predmet1	FOREIGN KEY (ID_predmet) REFERENCES predmet1(ID_predmet);
    
INSERT INTO student1 (ime, priimek, vpisna_st, datum_rojstva) VALUES 
('David', 'Novak' , 'E9320376041', '2001-12-12'),
('Maja', 'Krajnc' , 'E3107410974', '2001-03-15'),
('Aleš', 'Novak' , 'E1234464687', NULL),
('Maja', 'Malič' , 'E2137410974', '2002-05-15');

INSERT INTO predmet1 (koda_predmeta, naziv_predmeta, tocke_ECTS) VALUES 
('62V108', 'Podatkovne baze I', 5), 
('61V013', 'Računalniška omrežja', 5),
('62V014', 'Arhitekture informacijskih sistemov', 5),
('V035', 'Management kakovosti', 5),
('V274', 'Izvedbeni marketing', 6),
('U0003', 'Rimsko pravo', 8),
('U005', 'Kazensko materialno pravo', 8);

TRUNCATE TABLE vpis1;
INSERT INTO vpis1 (ocena, leto_vpisa, ID_student, ID_predmet) VALUES 
(8, '2020/2021', 1, 1),
(7, '2020/2021', 1, 2),
(9, '2020/2021', 2, 4),
(9, '2020/2021', 2, 5),
(NULL, '2020/2021', 3, 1),
(10, '2020/2021', 3, 3),
(6, '2019/2020', 4, 6),
(8, '2019/2020', 4, 7);

SELECT * FROM student1;
SELECT * FROM vpis1;
SELECT * FROM predmet1;



# ------------------------------------
# NATURAL JOIN
# ------------------------------------
SELECT ime, priimek, ocena
FROM student1 NATURAL JOIN vpis1;

#isto
SELECT ime, priimek, ocena
FROM student1 JOIN vpis1 USING(ID_student);

ALTER TABLE vpis1 CHANGE ID_student TK_student INT;
ALTER TABLE vpis1 ADD CONSTRAINT tk_vpis_student2 FOREIGN KEY (TK_student) REFERENCES student1(ID_student);
ALTER TABLE vpis1 CHANGE ID_predmet TK_predmet INT;
ALTER TABLE vpis1 ADD CONSTRAINT tk_vpis_predmet2 FOREIGN KEY (TK_predmet) REFERENCES predmet1(ID_predmet);

SHOW COLUMNS FROM vpis1;

SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS vpis1;
DROP TABLE IF EXISTS student1;
DROP TABLE IF EXISTS predmet1;
SET FOREIGN_KEY_CHECKS=1;	

# ------------------------------------
# INNER JOIN
# ------------------------------------
SELECT P.ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet  P
JOIN vpis V
ON P.ID_predmet = V.TK_predmet; 

# ------------------------------------
# LEFT OUTER JOIN
# ------------------------------------

INSERT INTO predmet (koda_predmeta, naziv_predmeta, tocke_ECTS) VALUES 
('0196', 'Teorija sistemov', 7); 

#navadni join (brez left) nima teorije sistemov
SELECT P1.ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet P1
JOIN vpis V1
ON P1.ID_predmet = V1.TK_predmet;

#left outer join
#izpiše vse predmete, tudi tiste, ki niso vpisani v tabeli VPIS (še nimajo vpisanih študentov)
# - vrstni red je pomemben! najprej izbere vse predmete, nato pripiše zraven podatke iz vpisa,
# pri tistih, kjer ni rezultata pa doda NULL povsod, kar ni iz tabele predmet

#SELECT ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
#FROM predmet1 
#LEFT JOIN vpis1 #lahko tudi LEFT OUTER JOIN, je isto
#USING(ID_predmet); #NATURAL JOIN - ne dela

SELECT P1.ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet P1
LEFT JOIN vpis V1 #lahko tudi LEFT OUTER JOIN, je isto
ON P1.ID_predmet = V1.TK_predmet;

#če želimo isti stavek z RIGHT join, obrnemo predmet in vpis in zamenjamo left z right
SELECT ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM vpis 
RIGHT JOIN predmet
ON predmet.ID_predmet = vpis.TK_predmet;


# ------------------------------------
# RIGHT OUTER JOIN
# ------------------------------------
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES 
(NULL, '2020/2021', 1, NULL);

# Če pa zamenjamo pri left join vpis in predmet, potem pa dobimo vse vrstice iz vpisa 
# (tudi če v vrstici ni vpisanega predmeta)
# in pripadajoče atribute iz predmeta, nimamo pa predmeta, na katerega ni vpisan nihče. 
SELECT ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM vpis
LEFT JOIN  predmet #lahko tudi LEFT OUTER JOIN, je isto
ON vpis.TK_predmet = predmet.ID_predmet; 

#isto kot če pustimo isti vrstni red in damo right
SELECT ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet 
RIGHT JOIN vpis
ON vpis.TK_predmet = predmet.ID_predmet; 

# ------------------------------------
# FULL OUTER JOIN, UNION
# ------------------------------------
#SELECT ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
#FROM predmet1
#FULL OUTER JOIN  vpis1 #ni podprt v MySQL, je v postgreSQL, tukaj lahko sestaviš z LEFT UNION RIGHT!
#USING(ID_predmet); 

SELECT P1.ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet P1
LEFT JOIN vpis V1 
ON P1.ID_predmet = V1.TK_predmet
UNION
SELECT P1.ID_predmet, naziv_predmeta, tocke_ECTS, ocena, leto_vpisa
FROM predmet P1
RIGHT JOIN vpis V1 
ON P1.ID_predmet = V1.TK_predmet;

# ------------------------------------
# MAX, MIN
# ------------------------------------
SELECT *
FROM vpis;

SELECT MAX(ocena)
FROM vpis;
# ------------------------------------
SELECT *
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND ocena IS NOT NULL;

SELECT MIN(tocke_ECTS)
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND ocena IS NOT NULL;

#Če bi želeli izpisane imeti še predmete, pri katerih je 5 ECTS točk, je spodnji primer HAVING:  - za kasneje!!!
SELECT naziv_predmeta, MIN(tocke_ECTS) as minimalne_tocke
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND ocena IS NOT NULL
group by id_predmet
HAVING minimalne_tocke =
		(SELECT MIN(tocke_ECTS) as minimalne_tocke
		FROM vpis, predmet
		WHERE predmet.ID_predmet = vpis.TK_predmet
		AND ocena IS NOT NULL);

SELECT * FROM predmet;

SELECT MAX(naziv_predmeta)
FROM predmet;

# ------------------------------------
# SUM
# ------------------------------------

SELECT SUM(DISTINCT tocke_ECTS)
FROM predmet
WHERE ID_predmet < 6;


# ------------------------------------
# AVG
# ------------------------------------
SELECT avg(ocena)
FROM vpis;

SELECT avg(DISTINCT ocena)
FROM vpis;

SELECT avg(ocena)
FROM vpis
WHERE ID_vpis > 3;

#Želimo izpis povprečnega števila ECTS točk pri predmetih, na katere so bili vpisani študenti leta 2020/2021. 
#pozor - če bilo več študentov vpisanih na isti predmet, bi morali pri izračunu 
#avg gnezditi select stavek, drugače bi bil rezultat napačen, ker bi predmet štelo večkrat
SELECT * FROM vpis;
SELECT * FROM predmet;

#Podatkovne baze I so 2x notri!
SELECT *
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND leto_vpisa='2020/2021';

#Spodnje NI PRAV, ker nam šteje vse izpise predmetov v vpis (torej če je v enem predmetu vpisanih več štundetov, tisti predmet šteje večkrat)
SELECT avg(tocke_ECTS)
FROM vpis, predmet
WHERE predmet.ID_predmet = vpis.TK_predmet
AND leto_vpisa='2020/2021';

SELECT *
FROM predmet
WHERE ID_predmet IN 
(select TK_predmet 
from vpis 
WHERE leto_vpisa='2020/2021');

#je prav, ker izbere samo vsak predmet enkrat
SELECT avg(tocke_ECTS)
FROM predmet
WHERE ID_predmet IN 
(select DISTINCT TK_predmet 
from vpis
WHERE leto_vpisa='2020/2021');

# ------------------------------------
# COUNT
# ------------------------------------
SELECT * 
FROM predmet
WHERE tocke_ECTS > 6;

SELECT COUNT(*) 
FROM predmet
WHERE tocke_ECTS > 6;

SELECT * 
FROM vpis; 

SELECT COUNT(*) 
FROM vpis
WHERE leto_vpisa = '2020/2021';

SELECT COUNT(distinct TK_predmet) 
FROM vpis
WHERE leto_vpisa = '2020/2021';



# ------------------------------------
# GROUP BY, SUM
# ------------------------------------
#koliko ECTS točk so študenti zbrali v vsakem študijskem letu
#brez group by ne bo delalo
SELECT leto_vpisa, SUM(tocke_ECTS) AS 'Število ECTS točk'
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet;

SELECT leto_vpisa, SUM(tocke_ECTS) AS 'Število ECTS točk'
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet
GROUP BY vpis.leto_vpisa;

# ------------------------------------
# GROUP BY, ORDER BY, COUNT
# ------------------------------------
#Izpišimo, koliko študentov je vpisano na posamezni predmet (predmeti po abecednem redu). 
#napačno, ker ni group by!
SELECT naziv_predmeta, COUNT(*) AS 'Število študentov'
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet;

#pravilno
SELECT naziv_predmeta, COUNT(*) AS 'Število študentov'
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet
GROUP BY vpis.TK_predmet
ORDER BY naziv_predmeta;

# ------------------------------------
# GROUP BY, COUNT
# ------------------------------------
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES 
(9, '2020/2021', 2, 1),
(6, '2020/2021', 3, 1),
(8, '2020/2021', 4, 3);

#spodaj je napačni query, ker je leto vpisa iz druge tabele kot je ID_student, po katerem grupiramo!! zato nam izpiše samo 1. leto vpisa!! SQL nam ne da napake, ampak ni pravi rezultat!

SELECT ime, priimek, COUNT(DISTINCT TK_predmet), leto_vpisa	
FROM student, vpis
WHERE student.ID_student = vpis.TK_student	
GROUP BY student.ID_student;

SELECT ime, priimek, COUNT(DISTINCT TK_predmet) AS 'Število predmetov'
FROM student, vpis
WHERE student.ID_student = vpis.TK_student	
GROUP BY student.ID_student;

SELECT ime, priimek, leto_vpisa, COUNT(DISTINCT TK_predmet)	#izpišemo za vsako leto posebej kateri študent je imel koliko predmetov. 
FROM student, vpis
WHERE student.ID_student = vpis.TK_student	
GROUP BY student.ID_student, leto_vpisa
ORDER BY ime;

# ------------------------------------
# GROUP BY, MAX
# ------------------------------------
SELECT * FROM vpis;

SELECT naziv_predmeta, MIN(ocena) AS minimalna, MAX(ocena) as maksimalna, MAX(ocena)-MIN(ocena) as razlika 
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet
GROUP BY ID_predmet;

#najvišja razlika med najvišjo in najnižjo oceno
#TUKAJ JE NUJNO POIMENOVANJE MIN, MAKS in tistega, kar je v FROM!
SELECT MAX(maks-min)
FROM(
	SELECT naziv_predmeta, MIN(ocena) AS min, MAX(ocena) AS maks, MAX(ocena) - MIN(ocena)
	FROM predmet, vpis
	WHERE predmet.ID_predmet = vpis.TK_predmet
	GROUP BY predmet.ID_predmet
) ocene; #nujno mora biti gnezden stavek poimenovan


SELECT MAX(maks-min)
FROM(
	SELECT naziv_predmeta, MIN(ocena) AS min, MAX(ocena) AS maks, MAX(ocena) - MIN(ocena)
	FROM predmet, vpis
	WHERE predmet.ID_predmet = vpis.TK_predmet
	GROUP BY predmet.ID_predmet
) ocene; #nujno mora biti gnezden stavek poimenovan


#dodaten primer, kjer je razvidno, kaj naredi SUM, kaj COUNT, kaj AVG = SUM/COUNT

SELECT ime, priimek, ocena
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet;

SELECT ime, priimek, SUM(ocena), COUNT(ocena), SUM(ocena)/COUNT(ocena), AVG(ocena), MAX(ocena), MIN(ocena)
FROM student, vpis, predmet
WHERE student.ID_student = vpis.TK_student
AND predmet.ID_predmet = vpis.TK_predmet
GROUP BY student.ID_student;

# ------------------------------------
# Operacije nad množicami, AVG
# ------------------------------------
select*from vpis;
select*from predmet;

#povprečna ocena pri predmetih Podatkovne baze I, Računalniška omrežja in Arhitektur informacijskih sistemov
SELECT naziv_predmeta, ocena
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet;


SELECT AVG(ocena) as povpr_ocen 
FROM vpis
WHERE vpis.TK_predmet in (
	SELECT predmet.ID_predmet 
    FROM predmet 
    WHERE naziv_predmeta LIKE '%Podatkovne baze%' 
    OR naziv_predmeta LIKE '%Računalniška omre%' 
    OR naziv_predmeta LIKE '%Arhitekture inf%' );
    
#povprečna ocena pri predmetih Managementa kakovosti in izvedbenega marketinga
SELECT AVG(ocena) as povpr_ocen 
FROM vpis
WHERE vpis.TK_predmet in (
	SELECT predmet.ID_predmet 
    FROM predmet
    WHERE naziv_predmeta LIKE '%Management kako%' 
    OR naziv_predmeta LIKE '%Izvedbeni marketing%' );
    
    
SELECT FERI.povpr_ocena - EPF.povpr_ocena
FROM
	(SELECT AVG(ocena) as povpr_ocena
	FROM vpis
	WHERE vpis.TK_predmet in 
		(SELECT predmet.ID_predmet FROM predmet WHERE ID_predmet = 1 OR ID_predmet = 2 OR ID_predmet = 3)) AS FERI,
 	(SELECT AVG(ocena) as povpr_ocena 
	FROM vpis
	WHERE vpis.TK_predmet in 
		(SELECT predmet.ID_predmet FROM predmet WHERE ID_predmet = 4 OR ID_predmet = 5)) AS EPF; 




# ------------------------------------
# LIMIT / MIN primer
# ------------------------------------

SELECT naziv_predmeta, tocke_ECTS
FROM predmet
ORDER BY tocke_ECTS
LIMIT 1; 

SELECT naziv_predmeta, tocke_ECTS
FROM predmet
WHERE tocke_ECTS = 
	(SELECT MIN(tocke_ECTS) 
    FROM predmet); 



# ------------------------------------
# HAVING 1
# ------------------------------------
#Izpišimo predmete, na katere je vpisan več kot 1 študent. 
SELECT* from vpis;

	SELECT predmet.ID_predmet, naziv_predmeta, COUNT(DISTINCT vpis.TK_student) AS stevilo_studentov
	FROM predmet, vpis
	WHERE predmet.ID_predmet = vpis.TK_predmet
	GROUP BY predmet.ID_predmet;

	SELECT predmet.ID_predmet, naziv_predmeta, COUNT(DISTINCT vpis.TK_student) AS stevilo_studentov
	FROM predmet, vpis
	WHERE predmet.ID_predmet = vpis.TK_predmet
	GROUP BY predmet.ID_predmet
    HAVING stevilo_studentov > 1;
    
    #še dodaten primer za group by, max, kjer smo dodali še, da se izpišejo samo predmeti, ki imajo kakšno razliko med minimalno in maksimalno oceno. 
SELECT naziv_predmeta, MIN(ocena) AS min, MAX(ocena) AS maks, MAX(ocena) - MIN(ocena) AS maksimalna_razlika
FROM predmet, vpis
WHERE predmet.ID_predmet = vpis.TK_predmet
GROUP BY predmet.ID_predmet
HAVING maksimalna_razlika > 0;
    
# ------------------------------------
# HAVING 2
# ------------------------------------
#Izpišimo predmete, pri katerih so študenti prejeli višje ocene od povprečja vseh ocen.
    SELECT predmet.ID_predmet, naziv_predmeta, MAX(ocena) as najvisja_ocena
    FROM predmet, vpis
	WHERE predmet.ID_predmet = vpis.TK_predmet
	#AND tocke_ECTS > 5 #tak stavek lahko damo notri, če pa se sklicujemo na agregatno funkcijo, pa ne. 
    GROUP BY predmet.ID_predmet
    HAVING najvisja_ocena >  
		(SELECT AVG(ocena) from vpis); 
        
       
# ------------------------------------
# HAVING 3
# ------------------------------------
#Izpišimo študenta, ki je prejel najvišjo povprečno oceno.
SELECT ID_student, ime, priimek, AVG(ocena) as povpr_ocena 
FROM vpis
JOIN student ON vpis.TK_student = student.ID_student
GROUP BY TK_student
HAVING povpr_ocena =  
	(SELECT MAX(povpr_ocena) FROM
		(SELECT ID_student, ime, priimek, AVG(ocena) as povpr_ocena 
		FROM vpis
		JOIN student ON vpis.TK_student = student.ID_student
		GROUP BY TK_student) najvisja_povpr); 
        

#krajše za ta primer
SELECT ID_student, ime, priimek, AVG(ocena) as povpr_ocena 
FROM vpis
JOIN student ON vpis.TK_student = student.ID_student
GROUP BY TK_student
HAVING povpr_ocena =  
	(SELECT MAX(povpr_ocena) FROM
		(SELECT TK_student, AVG(ocena) as povpr_ocena 
        FROM vpis  #v tem stavku nismo združili študenta in vpisa, ker ni bilo potrebno, a največkrat je lažje, da prvi del v celoti prekopiramo v ta del. 
        GROUP BY TK_student) najvisja_povpr); 

# ------------------------------------
# CREATE VIEW
# ------------------------------------
DROP VIEW IF EXISTS povprecne_ocene_studentov;
CREATE VIEW povprecne_ocene_studentov AS
SELECT ime, priimek, AVG(ocena) as povpr_ocena 
FROM vpis
JOIN student ON vpis.TK_student = student.ID_student
GROUP BY TK_student;

SELECT * FROM povprecne_ocene_studentov; 
        
SELECT * 
FROM povprecne_ocene_studentov 
WHERE povpr_ocena=(
		SELECT MAX(povpr_ocena) 
		FROM povprecne_ocene_studentov);     



# ------------------------------------
# NULL
# ------------------------------------

SELECT * FROM student; 

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva > '2001-12-12' OR
		datum_rojstva <= '2001-12-12';
#študenta z NULL datumom v tem primeru ni, tudi če izgleda kot da smo vse opcije vključili. 

SELECT ime, priimek, datum_rojstva
FROM student
WHERE datum_rojstva > '2001-12-11' OR #kljub temu, da tega Aleš ne izpolnjuje, izpolni naslednji pogoj
	ime='Aleš';
    
    SELECT COUNT(*) #4
	FROM student;

    SELECT COUNT(*) #3
	FROM student
	WHERE datum_rojstva IS NOT NULL;
    
	SELECT COUNT(datum_rojstva) #3
	FROM student
	WHERE datum_rojstva IS NOT NULL;
    
	SELECT COUNT(datum_rojstva) #3
	FROM student;
    
	SELECT datum_rojstva #4
	FROM student;

# ------------------------------------
# Nepovezani gnezdeni stavki
# ------------------------------------

#gnezdenje v WHERE
#Izpiši študente, ki so prejeli ocene, višje od 8. 
SELECT ime, priimek
FROM student 
WHERE ID_student IN
	(SELECT TK_student
	FROM vpis
	WHERE ocena > 8);
    
#gnezdenje v FROM
#Izpiši, koliko je najmanjše število predmetov, na katerega so študenti vpisani. 
SELECT TK_student, COUNT(TK_predmet) as st_predmetov 
FROM vpis
GROUP BY TK_student;

SELECT MIN(st_predmetov) 
FROM 	
	(SELECT TK_student, COUNT(TK_predmet) as st_predmetov 
    FROM vpis 
    GROUP BY TK_student) st_predmetov_na_studenta; #tabela mora biti poimenovana, ker je izpeljana
 
#če bi želeli zraven minimalnega števila še izpis, za katerega študenta gre, se sam stavek podaljša z HAVING: 
SELECT ime, priimek, COUNT(TK_predmet) AS st_predmetov
FROM vpis, student
WHERE vpis.TK_student = student.ID_student
GROUP BY TK_student
HAVING st_predmetov = 
 (SELECT MIN(st_predmetov) FROM 
	 (SELECT ime, priimek, COUNT(TK_predmet) AS st_predmetov
	FROM vpis, student
	WHERE vpis.TK_student = student.ID_student
	GROUP BY TK_student) stevilo_predmetov);



# ------------------------------------
# Povezani gnezdeni stavki
# ------------------------------------

SELECT ID_predmet, naziv_predmeta
FROM predmet P;

SELECT TK_predmet, naziv_predmeta, COUNT(TK_student) 
    FROM vpis, predmet
    WHERE vpis.TK_predmet=predmet.ID_predmet
    GROUP BY TK_predmet;

SELECT ID_predmet, naziv_predmeta,
	(SELECT COUNT(TK_student) 
    FROM vpis
    WHERE vpis.TK_predmet=P.ID_predmet) as st_studentov #notranji stavek ne ve, kaj je P.ID_predmet, zato ne bo samostojno ga možno zagnati. 
FROM predmet P;



# ------------------------------------
# TIMESTAMP / DATETIME
# ------------------------------------

#time stamp primer
DROP TABLE IF EXISTS test_timestamp;
CREATE TABLE test_timestamp (
	ID_test INT AUTO_INCREMENT PRIMARY KEY, 
	datum_od TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    datum_do TIMESTAMP
);

INSERT INTO test_timestamp (datum_od, datum_do) VALUES ('2020-05-15 00:05:00', '2020-05-15 00:07:00'), ('2020-03-14 00:14:00', '2020-03-15 00:07:00'), ('2020-03-14 00:06:00', '2020-03-15 00:07:00');
INSERT INTO test_timestamp (datum_do) VALUES ('2020-05-15 00:05:00');
    
SELECT * FROM test_timestamp;

SELECT UNIX_TIMESTAMP(datum_od), UNIX_TIMESTAMP(datum_do)
FROM test_timestamp;

#SELECT TIMESTAMPDIFF(<INTERVAL>,<timestampFrom>,<timestampTo>);
SELECT datum_od, datum_do, TIMESTAMPDIFF(SECOND, datum_od, datum_do) as razlika_v_času FROM test_timestamp;

SELECT datum_od, datum_do, TIMESTAMPDIFF(DAY, datum_od, datum_do) as razlika_v_času FROM test_timestamp; #tukaj je razlika v 2. vnosu, kjer je manj kot 24 ur razlike in je zato 0 dni razlike, 
#pri datediff (spodaj) pa bo 1 dan razlike, ker primerja samo dneve, ne tudi ure). 

SELECT datum_od, datum_do, DATEDIFF(datum_do, datum_od) as datediff FROM test_timestamp;

SELECT datum_od, DATE(datum_od), TIME(datum_od), YEAR(datum_od), MONTH(datum_od), WEEKDAY(datum_od), DAY(datum_od) FROM test_timestamp; #izbere se npr. samo dan iz DATETIME ali samo čas ali leto

# DATETIME primer - V SPODNJIH PRIMERIH NI RAZLIKE, ČE UPORABIMO DATETIME / TIMESTAMP - so enaki kot zgoraj!
SELECT datum_od, DATE(datum_od)
FROM test_timestamp
WHERE DATE(datum_od) = CURRENT_DATE();

DROP TABLE IF EXISTS test_datetime;
CREATE TABLE test_datetime (
	ID_test INT AUTO_INCREMENT PRIMARY KEY, 
	datum_od DATETIME  DEFAULT CURRENT_TIMESTAMP,
    datum_do DATETIME
);

INSERT INTO test_datetime (datum_od, datum_do) VALUES ('2020-05-15 00:05:00', '2020-05-15 00:07:00'), ('2020-03-14 00:14:00', '2020-03-15 00:07:00'), ('2020-03-14 00:06:00', '2020-03-15 00:07:00');
INSERT INTO test_datetime (datum_do) VALUES ('2020-05-15 00:05:00');

SELECT * FROM test_datetime;

SELECT UNIX_TIMESTAMP(datum_od), UNIX_TIMESTAMP(datum_do)
FROM test_datetime;

#SELECT TIMESTAMPDIFF(<INTERVAL>,<timestampFrom>,<timestampTo>);
SELECT TIMESTAMPDIFF(DAY, datum_od, datum_do) as razlika_v_času FROM test_datetime; #tukaj je razlika v 2. vnosu, kjer je manj kot 24 ur razlike in je zato 0 dni razlike, 
#pri datediff (spodaj) pa bo 1 dan razlike, ker primerja samo dneve, ne tudi ure). 

SELECT DATEDIFF(datum_do, datum_od) as datediff FROM test_datetime;