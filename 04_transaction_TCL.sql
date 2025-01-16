SELECT * FROM student;
SELECT * FROM vpis;
SELECT * FROM predmet;

-- 1. transakcija - uporabljat moramo InnoDB engine
-- Primer z izvedeno transakcijo
# spremenimo datum rojstva. ko je commit, ni več poti nazaj :) 

START TRANSACTION;
SELECT * FROM student;

UPDATE student 
#SET datum_rojstva = NULL
SET datum_rojstva='2000-12-24' #Datum rojstva.
WHERE ID_student=3;

COMMIT;
SELECT * FROM student;



-- 2 rollback
#zbrišemo in povrnemo

START TRANSACTION;
SELECT * FROM vpis;

DELETE FROM vpis 
WHERE vpis.ID_vpis > 2;

SELECT * FROM vpis;
ROLLBACK;

SELECT * FROM vpis;

-- 3. shranjevanje v spremenljivko
SELECT * FROM student;
UPDATE student SET povprecna_ocena = NULL WHERE ID_student=2;
SELECT * FROM student;

START TRANSACTION;
SELECT @povprecna_ocena:= AVG(ocena) FROM vpis WHERE TK_student =2;
UPDATE student SET povprecna_ocena = @povprecna_ocena WHERE ID_student=2;

SELECT * FROM student;

COMMIT;

SELECT * FROM student;


-- Iskanje naslednjega prostega IDja

SELECT * FROM predmet;

START TRANSACTION;

SELECT @id_predmeta:=MAX(ID_predmet)+1
FROM predmet;

INSERT INTO predmet(ID_predmet, koda_predmeta, naziv_predmeta, tocke_ECTS)
VALUES(@id_predmeta,'61V015','Uporabniški vmesniki',5);

SELECT * FROM predmet;
ROLLBACK;

SELECT * FROM predmet;
COMMIT;


