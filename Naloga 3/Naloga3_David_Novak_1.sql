set foreign_key_checks = 0;
 
USE 2023_pb_vs_david_novak6;
 
DROP TABLE IF EXISTS Novinar;
DROP TABLE IF EXISTS Delegacija;
DROP TABLE IF EXISTS Sodnik;
DROP TABLE IF EXISTS Zdravnik;
DROP TABLE IF EXISTS Panoga;
DROP TABLE IF EXISTS Tekma;
DROP TABLE IF EXISTS Stadion;
DROP TABLE IF EXISTS Uspeh_Na_Prejsnjih_Igrah;
DROP TABLE IF EXISTS Drzava;
DROP TABLE IF EXISTS Udeleženec;
DROP TABLE IF EXISTS Trener;
DROP TABLE IF EXISTS Ekipa;
DROP TABLE IF EXISTS Medalja;
DROP TABLE IF EXISTS Disciplina;
DROP TABLE IF EXISTS Startna_Lista;

set foreign_key_checks = 1;

#2 KREIRANJE TABEL

-- -----------------------------------------------------
-- Table `mydb`.`Štartna_Lista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Startna_Lista` (
  `idŠtartna_Lista` INT NOT NULL,
  `Datum` DATE NULL,
  `Ura` DATETIME NULL,
  PRIMARY KEY (`idŠtartna_Lista`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Disciplina` (
  `idDisciplina` INT NOT NULL,
  `Ime discipline` VARCHAR(45) NULL,
  PRIMARY KEY (`idDisciplina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Medalja`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Medalja` (
  `idMedalja` INT NOT NULL,
  `Vrsta medalje` VARCHAR(45) NULL,
  PRIMARY KEY (`idMedalja`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ekipa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Ekipa` (
  `idEkipa` INT NOT NULL,
  `Ime ekipe` VARCHAR(45) NULL,
  PRIMARY KEY (`idEkipa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Trener`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Trener` (
  `idTrener` INT NOT NULL,
  `Ime in priimek` VARCHAR(45) NULL,
  PRIMARY KEY (`idTrener`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Udeleženec`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Udeleženec` (
  `idUdeleženec` INT NOT NULL,
  `Ime` VARCHAR(45) NULL,
  `Priimek` VARCHAR(45) NULL,
  `Telesna višina` VARCHAR(45) NULL,
  `Teža` VARCHAR(45) NULL,
  `Štartna_Lista_idŠtartna_Lista` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  `Medalja_idMedalja` INT NOT NULL,
  `Ekipa_idEkipa` INT NOT NULL,
  `Trener_idTrener` INT NOT NULL,
  PRIMARY KEY (`idUdeleženec`),
  INDEX `fk_Udeleženec_Štartna_Lista1_idx` (`Štartna_Lista_idŠtartna_Lista` ASC) VISIBLE,
  INDEX `fk_Udeleženec_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  INDEX `fk_Udeleženec_Medalja1_idx` (`Medalja_idMedalja` ASC) VISIBLE,
  INDEX `fk_Udeleženec_Ekipa1_idx` (`Ekipa_idEkipa` ASC) VISIBLE,
  INDEX `fk_Udeleženec_Trener1_idx` (`Trener_idTrener` ASC) VISIBLE,
  CONSTRAINT `fk_Udeleženec_Štartna_Lista1`
    FOREIGN KEY (`Štartna_Lista_idŠtartna_Lista`)
    REFERENCES `2023_pb_vs_david_novak6`.`Startna_Lista` (`idŠtartna_Lista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Udeleženec_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `2023_pb_vs_david_novak6`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Udeleženec_Medalja1`
    FOREIGN KEY (`Medalja_idMedalja`)
    REFERENCES `2023_pb_vs_david_novak6`.`Medalja` (`idMedalja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Udeleženec_Ekipa1`
    FOREIGN KEY (`Ekipa_idEkipa`)
    REFERENCES `2023_pb_vs_david_novak6`.`Ekipa` (`idEkipa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Udeleženec_Trener1`
    FOREIGN KEY (`Trener_idTrener`)
    REFERENCES `2023_pb_vs_david_novak6`.`Trener` (`idTrener`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Država`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Drzava` (
  `idDržava` INT NOT NULL,
  `Ime države` VARCHAR(45) NULL,
  `Udeleženec_idUdeleženec` INT NOT NULL,
  PRIMARY KEY (`idDržava`),
  INDEX `fk_Država_Udeleženec_idx` (`Udeleženec_idUdeleženec` ASC) VISIBLE,
  CONSTRAINT `fk_Država_Udeleženec`
    FOREIGN KEY (`Udeleženec_idUdeleženec`)
    REFERENCES `2023_pb_vs_david_novak6`.`Udeleženec` (`idUdeleženec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Uspeh_Na_Prejšnjih_Igrah`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Uspeh_Na_Prejsnjih_Igrah` (
  `idUspeh_Na_Prejšnjih_Igrah` INT NOT NULL,
  `Leto iger` DATETIME NULL,
  `Doseženo Mesto` VARCHAR(45) NULL,
  `Udeleženec_idUdeleženec` INT NOT NULL,
  PRIMARY KEY (`idUspeh_Na_Prejšnjih_Igrah`),
  INDEX `fk_Uspeh_Na_Prejšnjih_Igrah_Udeleženec1_idx` (`Udeleženec_idUdeleženec` ASC) VISIBLE,
  CONSTRAINT `fk_Uspeh_Na_Prejšnjih_Igrah_Udeleženec1`
    FOREIGN KEY (`Udeleženec_idUdeleženec`)
    REFERENCES `2023_pb_vs_david_novak6`.`Udeleženec` (`idUdeleženec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Panoga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Panoga` (
  `idPanoga` INT NOT NULL,
  `Ime Panoge` VARCHAR(45) NULL,
  `Štartna_Lista_idŠtartna_Lista` INT NOT NULL,
  `Medalja_idMedalja` INT NOT NULL,
  `Disciplina_idDisciplina` INT NOT NULL,
  PRIMARY KEY (`idPanoga`),
  INDEX `fk_Panoga_Štartna_Lista1_idx` (`Štartna_Lista_idŠtartna_Lista` ASC) VISIBLE,
  INDEX `fk_Panoga_Medalja1_idx` (`Medalja_idMedalja` ASC) VISIBLE,
  INDEX `fk_Panoga_Disciplina1_idx` (`Disciplina_idDisciplina` ASC) VISIBLE,
  CONSTRAINT `fk_Panoga_Štartna_Lista1`
    FOREIGN KEY (`Štartna_Lista_idŠtartna_Lista`)
    REFERENCES `2023_pb_vs_david_novak6`.`Startna_Lista` (`idŠtartna_Lista`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Panoga_Medalja1`
    FOREIGN KEY (`Medalja_idMedalja`)
    REFERENCES `2023_pb_vs_david_novak6`.`Medalja` (`idMedalja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Panoga_Disciplina1`
    FOREIGN KEY (`Disciplina_idDisciplina`)
    REFERENCES `2023_pb_vs_david_novak6`.`Disciplina` (`idDisciplina`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stadion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Stadion` (
  `idStadion` INT NOT NULL,
  `Ime Stadiona` VARCHAR(45) NULL,
  `Lokacija` VARCHAR(45) NULL,
  PRIMARY KEY (`idStadion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tekma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Tekma` (
  `idTekma` INT NOT NULL,
  `Datum in ura` DATETIME NULL,
  `Rezultat` VARCHAR(45) NULL,
  `Stadion_idStadion` INT NOT NULL,
  `Panoga_idPanoga` INT NOT NULL,
  PRIMARY KEY (`idTekma`),
  INDEX `fk_Tekma_Stadion1_idx` (`Stadion_idStadion` ASC) VISIBLE,
  INDEX `fk_Tekma_Panoga1_idx` (`Panoga_idPanoga` ASC) VISIBLE,
  CONSTRAINT `fk_Tekma_Stadion1`
    FOREIGN KEY (`Stadion_idStadion`)
    REFERENCES `2023_pb_vs_david_novak6`.`Stadion` (`idStadion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tekma_Panoga1`
    FOREIGN KEY (`Panoga_idPanoga`)
    REFERENCES `2023_pb_vs_david_novak6`.`Panoga` (`idPanoga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Zdravnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Zdravnik` (
  `idZdravnik` INT NOT NULL,
  `Ime in priimek` VARCHAR(45) NULL,
  `Udeleženec_idUdeleženec` INT NOT NULL,
  PRIMARY KEY (`idZdravnik`),
  INDEX `fk_Zdravnik_Udeleženec1_idx` (`Udeleženec_idUdeleženec` ASC) VISIBLE,
  CONSTRAINT `fk_Zdravnik_Udeleženec1`
    FOREIGN KEY (`Udeleženec_idUdeleženec`)
    REFERENCES `2023_pb_vs_david_novak6`.`Udeleženec` (`idUdeleženec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Sodnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Sodnik` (
  `idSodnik` INT NOT NULL,
  `Ime in priimek` VARCHAR(45) NULL,
  `Tekma_idTekma` INT NOT NULL,
  PRIMARY KEY (`idSodnik`),
  INDEX `fk_Sodnik_Tekma1_idx` (`Tekma_idTekma` ASC) VISIBLE,
  CONSTRAINT `fk_Sodnik_Tekma1`
    FOREIGN KEY (`Tekma_idTekma`)
    REFERENCES `2023_pb_vs_david_novak6`.`Tekma` (`idTekma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Delegacija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Delegacija` (
  `idDelegacija` INT NOT NULL,
  `Ime delegacije` VARCHAR(45) NULL,
  `Tekma_idTekma` INT NOT NULL,
  PRIMARY KEY (`idDelegacija`),
  INDEX `fk_Delegacija_Tekma1_idx` (`Tekma_idTekma` ASC) VISIBLE,
  CONSTRAINT `fk_Delegacija_Tekma1`
    FOREIGN KEY (`Tekma_idTekma`)
    REFERENCES `2023_pb_vs_david_novak6`.`Tekma` (`idTekma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Novinar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `2023_pb_vs_david_novak6`.`Novinar` (
  `idNovinar` INT NOT NULL,
  `Ime` VARCHAR(45) NULL,
  `Priimek` VARCHAR(45) NULL,
  `Tekma_idTekma` INT NOT NULL,
  PRIMARY KEY (`idNovinar`),
  INDEX `fk_Novinar_Tekma1_idx` (`Tekma_idTekma` ASC) VISIBLE,
  CONSTRAINT `fk_Novinar_Tekma1`
    FOREIGN KEY (`Tekma_idTekma`)
    REFERENCES `2023_pb_vs_david_novak6`.`Tekma` (`idTekma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE 2023_pb_vs_david_novak6;

-- Insert into Startna_Lista
INSERT INTO Startna_Lista (idŠtartna_Lista, Datum, Ura) VALUES
(1, '2023-01-01', '2023-01-01 10:00:00'),
(2, '2023-02-01', '2023-02-01 14:30:00'),
(3, '2023-03-01', '2023-03-01 09:45:00'),
(4, '2023-04-01', '2023-04-01 16:15:00'),
(5, '2023-05-01', '2023-05-01 11:30:00'),
(6, '2023-06-01', '2023-06-01 13:45:00'),
(7, '2023-07-01', '2023-07-01 15:30:00'),
(8, '2023-08-01', '2023-08-01 18:00:00'),
(9, '2023-09-01', '2023-09-01 12:15:00'),
(10, '2023-10-01', '2023-10-01 17:30:00');

-- Insert into Disciplina
INSERT INTO Disciplina (idDisciplina, `Ime discipline`) VALUES
(1, 'Disciplina1'),
(2, 'Disciplina2'),
(3, 'Disciplina3'),
(4, 'Disciplina4'),
(5, 'Disciplina5'),
(6, 'Disciplina6'),
(7, 'Disciplina7'),
(8, 'Disciplina8'),
(9, 'Disciplina9'),
(10, 'Disciplina10');

-- Insert into Medalja
INSERT INTO Medalja (idMedalja, `Vrsta medalje`) VALUES
(1, 'Zlata'),
(2, 'Srebrna'),
(3, 'Bronasta'),
(4, 'Srebrna'),
(5, 'Zlata'),
(6, 'Bronasta'),
(7, 'Zlata'),
(8, 'Bronasta'),
(9, 'Zlata'),
(10, 'Srebrna');

-- Insert into Ekipa
INSERT INTO Ekipa (idEkipa, `Ime ekipe`) VALUES
(1, 'Ekipa1'),
(2, 'Ekipa2'),
(3, 'Ekipa3'),
(4, 'Ekipa4'),
(5, 'Ekipa5'),
(6, 'Ekipa6'),
(7, 'Ekipa7'),
(8, 'Ekipa8'),
(9, 'Ekipa9'),
(10, 'Ekipa10');

-- Insert into Trener
INSERT INTO Trener (idTrener, `Ime in priimek`) VALUES
(1, 'Trener1'),
(2, 'Trener2'),
(3, 'Trener3'),
(4, 'Trener4'),
(5, 'Trener5'),
(6, 'Trener6'),
(7, 'Trener7'),
(8, 'Trener8'),
(9, 'Trener9'),
(10, 'Trener10');

-- Insert into Udeleženec
INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, `Telesna višina`, Teža, Štartna_Lista_idŠtartna_Lista, Disciplina_idDisciplina, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(1, 'Udeleženec1', 'Priimek1', '180', '70', 1, 1, 1, 1, 1),
(2, 'Udeleženec2', 'Priimek2', '175', '65', 2, 2, 2, 2, 2),
(3, 'Udeleženec3', 'Priimek3', '182', '75', 3, 3, 3, 3, 3),
(4, 'Udeleženec4', 'Priimek4', '178', '68', 4, 4, 4, 4, 4),
(5, 'Udeleženec5', 'Priimek5', '185', '80', 5, 5, 5, 5, 5),
(6, 'Udeleženec6', 'Priimek6', '176', '72', 6, 6, 6, 6, 6),
(7, 'Udeleženec7', 'Priimek7', '183', '78', 7, 7, 7, 7, 7),
(8, 'Udeleženec8', 'Priimek8', '177', '69', 8, 8, 8, 8, 8),
(9, 'Udeleženec9', 'Priimek9', '181', '77', 9, 9, 9, 9, 9),
(10, 'Udeleženec10', 'Priimek10', '179', '73', 10, 10, 10, 10, 10);

-- Insert into Drzava
INSERT INTO Drzava (idDržava, `Ime države`, Udeleženec_idUdeleženec) VALUES
(1, 'Država1', 1),
(2, 'Država2', 2),
(3, 'Država3', 3),
(4, 'Država4', 4),
(5, 'Država5', 5),
(6, 'Država6', 6),
(7, 'Država7', 7),
(8, 'Država8', 8),
(9, 'Država9', 9),
(10, 'Država10', 10);

-- Insert into Uspeh_Na_Prejsnjih_Igrah
INSERT INTO Uspeh_Na_Prejsnjih_Igrah (idUspeh_Na_Prejšnjih_Igrah, `Leto iger`, `Doseženo Mesto`, Udeleženec_idUdeleženec) VALUES
(1, '2022-01-01', 'Prvo mesto', 1),
(2, '2022-02-01', 'Drugo mesto', 2),
(3, '2022-03-01', 'Tretje mesto', 3),
(4, '2022-04-01', 'Četrto mesto', 4),
(5, '2022-05-01', 'Petsto mesto', 5),
(6, '2022-06-01', 'Šesto mesto', 6),
(7, '2022-07-01', 'Sedmo mesto', 7),
(8, '2022-08-01', 'Osmo mesto', 8),
(9, '2022-09-01', 'Deveto mesto', 9),
(10, '2022-10-01', 'Deseto mesto', 10);

-- Insert into Panoga
INSERT INTO Panoga (idPanoga, `Ime Panoge`, Štartna_Lista_idŠtartna_Lista, Medalja_idMedalja, Disciplina_idDisciplina) VALUES
(1, 'Panoga1', 1, 1, 1),
(2, 'Panoga2', 2, 2, 2),
(3, 'Panoga3', 3, 3, 3),
(4, 'Panoga4', 4, 4, 4),
(5, 'Panoga5', 5, 5, 5),
(6, 'Panoga6', 6, 6, 6),
(7, 'Panoga7', 7, 7, 7),
(8, 'Panoga8', 8, 8, 8),
(9, 'Panoga9', 9, 9, 9),
(10, 'Panoga10', 10, 10, 10);

-- Insert into Stadion
INSERT INTO Stadion (idStadion, `Ime Stadiona`, Lokacija) VALUES
(1, 'Stadion1', 'Lokacija1'),
(2, 'Stadion2', 'Lokacija2'),
(3, 'Stadion3', 'Lokacija3'),
(4, 'Stadion4', 'Lokacija4'),
(5, 'Stadion5', 'Lokacija5'),
(6, 'Stadion6', 'Lokacija6'),
(7, 'Stadion7', 'Lokacija7'),
(8, 'Stadion8', 'Lokacija8'),
(9, 'Stadion9', 'Lokacija9'),
(10, 'Stadion10', 'Lokacija10');

-- Insert into Tekma
INSERT INTO Tekma (idTekma, `Datum in ura`, Rezultat, Stadion_idStadion, Panoga_idPanoga) VALUES
(1, '2023-03-01 15:00:00', '2-1', 1, 1),
(2, '2023-03-02 18:30:00', '1-0', 2, 2),
(3, '2023-03-03 12:45:00', '3-2', 3, 3),
(4, '2023-03-04 17:15:00', '0-0', 4, 4),
(5, '2023-03-05 11:30:00', '4-1', 5, 5),
(6, '2023-03-06 13:45:00', '2-2', 6, 6),
(7, '2023-03-07 15:30:00', '3-0', 7, 7),
(8, '2023-03-08 18:00:00', '1-2', 8, 8),
(9, '2023-03-09 12:15:00', '2-1', 9, 9),
(10, '2023-03-10 17:30:00', '0-3', 10, 10);

-- Insert into Zdravnik
INSERT INTO Zdravnik (idZdravnik, `Ime in priimek`, Udeleženec_idUdeleženec) VALUES
(1, 'Zdravnik1', 1),
(2, 'Zdravnik2', 2),
(3, 'Zdravnik3', 3),
(4, 'Zdravnik4', 4),
(5, 'Zdravnik5', 5),
(6, 'Zdravnik6', 6),
(7, 'Zdravnik7', 7),
(8, 'Zdravnik8', 8),
(9, 'Zdravnik9', 9),
(10, 'Zdravnik10', 10);

-- Insert into Sodnik
INSERT INTO Sodnik (idSodnik, `Ime in priimek`, Tekma_idTekma) VALUES
(1, 'Sodnik1', 1),
(2, 'Sodnik2', 2),
(3, 'Sodnik3', 3),
(4, 'Sodnik4', 4),
(5, 'Sodnik5', 5),
(6, 'Sodnik6', 6),
(7, 'Sodnik7', 7),
(8, 'Sodnik8', 8),
(9, 'Sodnik9', 9),
(10, 'Sodnik10', 10);

-- Insert into Delegacija
INSERT INTO Delegacija (idDelegacija, `Ime delegacije`, Tekma_idTekma) VALUES
(1, 'Delegacija1', 1),
(2, 'Delegacija2', 2),
(3, 'Delegacija3', 3),
(4, 'Delegacija4', 4),
(5, 'Delegacija5', 5),
(6, 'Delegacija6', 6),
(7, 'Delegacija7', 7),
(8, 'Delegacija8', 8),
(9, 'Delegacija9', 9),
(10, 'Delegacija10', 10);

-- Insert into Novinar
INSERT INTO Novinar (idNovinar, `Ime`, `Priimek`, Tekma_idTekma) VALUES
(1, 'Novinar1', 'Priimek1', 1),
(2, 'Novinar2', 'Priimek2', 2),
(3, 'Novinar3', 'Priimek3', 3),
(4, 'Novinar4', 'Priimek4', 4),
(5, 'Novinar5', 'Priimek5', 5),
(6, 'Novinar6', 'Priimek6', 6),
(7, 'Novinar7', 'Priimek7', 7),
(8, 'Novinar8', 'Priimek8', 8),
(9, 'Novinar9', 'Priimek9', 9),
(10, 'Novinar10', 'Priimek10', 10);

-- Select from Udeleženec
SELECT * FROM Udeleženec;

-- Select from Drzava
SELECT * FROM Drzava;


SELECT * FROM Disciplina;

-- Select from Zdravnik
SELECT * FROM Zdravnik;

-- Select from Ekipa
SELECT * FROM Ekipa;

-- Select from Trener
SELECT * FROM Trener;

-- Select from Uspeh_Na_Prejsnjih_Igrah
SELECT * FROM Uspeh_Na_Prejsnjih_Igrah;

-- Select from Panoga
SELECT * FROM Panoga;

-- Select from Medalja
SELECT * FROM Medalja;

-- Select from Startna_lista
SELECT * FROM Startna_Lista;

-- Select from Tekma
SELECT * FROM Tekma;

-- Select from Delegacija
SELECT * FROM Delegacija;

-- Select from Stadion
SELECT * FROM Stadion;

-- Select from Sodnik
SELECT * FROM Sodnik;

-- Select from Novinar
SELECT * FROM Novinar;

-- Set old settings back



