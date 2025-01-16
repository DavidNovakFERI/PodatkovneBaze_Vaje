# ------------------------------------
# TRIGGERS
# ------------------------------------

SET SQL_SAFE_UPDATES = 0;
# ------------------------------------
#Trigger - BEFORE INSERT (sprememba na velike črke pred vstavljanjem podatkov)
# ------------------------------------
DROP TRIGGER IF EXISTS predmet_z_veliko;
CREATE TRIGGER predmet_z_veliko
BEFORE INSERT ON predmet
FOR EACH ROW
SET NEW.naziv_predmeta = UPPER(NEW.naziv_predmeta); 


SELECT * FROM predmet;
INSERT INTO predmet VALUES (NULL, '61V018', 'Razvoj aplikacij za internet', 5); 
SELECT * FROM predmet;

# ------------------------------------
#Trigger - AFTER INSERT (posodobitev povprečne ocene študenta glede na ocene v vpisu)
# ------------------------------------
#dodajanje stolpca za povprecno_oceno študenta
SHOW COLUMNS FROM student;
ALTER TABLE student ADD COLUMN povprecna_ocena DECIMAL(4,2);
SHOW COLUMNS FROM student;

SELECT * FROM student; 

#izračun stolpca za povprečno oceno študenta 
UPDATE student s JOIN
		(SELECT TK_student, AVG(ocena) AS povprecna_ocena
		FROM vpis
		GROUP BY TK_student) v
	ON s.ID_student=v.TK_student
SET s.povprecna_ocena = v.povprecna_ocena;


SELECT * FROM student; 

#posodobitev povprečne ocene študenta vedno (prožilec) glede na ocene v vpisu. 
SHOW TRIGGERS FROM lili_pb_vs; 
DROP TRIGGER IF EXISTS povprecna_ocena_studenta1;
CREATE TRIGGER povprecna_ocena_studenta1
AFTER INSERT ON vpis 
FOR EACH ROW
	UPDATE student s JOIN
			(SELECT TK_student, AVG(ocena) AS povprecna_ocena
			FROM vpis
			GROUP BY TK_student) v
		ON s.ID_student=v.TK_student
	SET s.povprecna_ocena = v.povprecna_ocena;

SELECT * FROM student;
SELECT * FROM vpis;
#dodajanje nove ocene v vpis in nato se izvede prožilec, kjer se izračuna nova povprečna ocena študenta. 
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (10, '2020/2021', 1, 5);
SELECT * FROM vpis;
SELECT * FROM student;

# ------------------------------------
SHOW TRIGGERS FROM lili_pb_vs; 
DROP TRIGGER IF EXISTS povprecna_ocena_studenta2;

DELIMITER $$
CREATE TRIGGER povprecna_ocena_studenta2
AFTER INSERT ON vpis 
FOR EACH ROW
BEGIN
    SELECT AVG(ocena) INTO @povprecna_ocena FROM vpis WHERE TK_student = NEW.TK_student; #shranimo povprečno oceno v spremenljivko
    
    UPDATE student s 
    SET s.povprecna_ocena = @povprecna_ocena
    WHERE ID_student = NEW.TK_student;
END $$
DELIMITER ;

SELECT * FROM student;
SELECT * FROM vpis;
#dodajanje nove ocene v vpis in nato se izvede prožilec, kjer se izračuna nova povprečna ocena študenta. 
INSERT INTO vpis (ocena, leto_vpisa, TK_student, TK_predmet) VALUES (10, '2020/2021', 1, 5);
SELECT * FROM vpis;
SELECT * FROM student;

# ------------------------------------
#Trigger  AFTER UPDATE
# ------------------------------------
SHOW TRIGGERS FROM lili_pb_vs; 
DROP TABLE IF EXISTS ocene_predmetov;
CREATE TABLE ocene_predmetov
	(ID_ocena_pred INT auto_increment primary key,
    datum_spremembe DATETIME,
    ID_vpis INT,
    ID_predmet INT,
    ID_student INT,
    ocena_prej DECIMAL(4,2),
    ocena_potem DECIMAL(4,2)
    );

DROP TRIGGER IF EXISTS zgodovina_ocen;
DELIMITER $$
CREATE TRIGGER zgodovina_ocen 
AFTER UPDATE ON vpis 
FOR EACH ROW BEGIN
	INSERT INTO ocene_predmetov VALUES 
		(NULL, NOW(), OLD.ID_vpis, OLD.TK_predmet, OLD.TK_student, OLD.ocena, NEW.ocena);
	END$$
DELIMITER ;

SELECT * FROM ocene_predmetov;
SELECT * FROM vpis; 
UPDATE vpis SET ocena=7 WHERE ID_vpis=5; 
SELECT * FROM ocene_predmetov;
SELECT * FROM vpis; 
 
SET SQL_SAFE_UPDATES = 1;
