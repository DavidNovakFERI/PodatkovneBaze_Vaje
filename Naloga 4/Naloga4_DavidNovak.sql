USE 2023_pb_vs_david_novak6;

#1 Izpiši ime in priimek športnikov, ki tekmujejo v “metu krogle”.
INSERT INTO Disciplina (idDisciplina, `Ime discipline`) VALUES
(30, 'met krogle');
INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, `Telesna višina`, Teža, Štartna_Lista_idŠtartna_Lista, Disciplina_idDisciplina, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(34, 'Janez', 'Kroglaš', '185', '85', 1, 30, 1, 1, 1),
(35, 'Mojca', 'Kroglova', '170', '60', 2, 30, 1, 2, 2);


SELECT Ime, Priimek 
FROM Udeleženec 
WHERE Disciplina_idDisciplina IN (SELECT idDisciplina FROM Disciplina WHERE `Ime discipline` = 'met krogle');

#2 Izpišite vse športnike in njihove uvrstitve. Izpišite tudi športnike, ki še nimajo nobene uvrstitve

SELECT 
    u.Ime, 
    u.Priimek, 
    upng.`Doseženo Mesto`
FROM 
    Udeleženec u
LEFT JOIN 
    Uspeh_Na_Prejsnjih_Igrah upng ON u.idUdeleženec = upng.Udeleženec_idUdeleženec;
    
    
#3Izračunajte razliko v metu krogle med prvim in drugim tekmovalcem na tekmi, ki se je zgodila na London stadionu
INSERT INTO Stadion (idStadion, `Ime Stadiona`, Lokacija) VALUES
(20, 'London', 'Velika Britanija');

INSERT INTO Panoga (idPanoga, `Ime Panoge`, Štartna_Lista_idŠtartna_Lista, Medalja_idMedalja, Disciplina_idDisciplina) VALUES
(20, 'Atletika - met krogle', 1, 1, 30);

INSERT INTO Tekma (idTekma, `Datum in ura`, Rezultat, Stadion_idStadion, Panoga_idPanoga) VALUES
(20, '2023-01-01 10:00:00', '22.50', 20, 20),
(21, '2023-01-01 10:00:00', '21.75', 20, 20);



SELECT 
    MAX(t.`Rezultat`) - MIN(t.`Rezultat`) AS `Razlika`
FROM 
    Tekma t
JOIN 
    Panoga p ON t.Panoga_idPanoga = p.idPanoga
JOIN 
    Disciplina d ON p.Disciplina_idDisciplina = d.idDisciplina
JOIN 
    Stadion s ON t.Stadion_idStadion = s.idStadion
WHERE 
    s.`Ime Stadiona` = 'London' AND d.`Ime discipline` = 'met krogle';

#4 Izpiši število tekmovalcev v vsaki disciplini (v odgovoru naj se izpiše naziv discipline).
INSERT INTO Disciplina (idDisciplina, `Ime discipline`) VALUES
(40, 'Met krogle'),
(41, '100m tek'),
(42, 'Skok v daljino');

INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, `Telesna višina`, Teža, Štartna_Lista_idŠtartna_Lista, Disciplina_idDisciplina, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(40, 'Janez', 'Kroglaš', '185', '85', 1, 40, 1, 1, 1),
(41, 'Mojca', 'Hitra', '170', '60', 2, 41, 2, 2, 2),
(42, 'Peter', 'Daljni', '180', '75', 3, 42, 3, 3, 3);

SELECT 
    d.`Ime discipline`,
    COUNT(u.idUdeleženec) AS `Število tekmovalcev`
FROM 
    Disciplina d
LEFT JOIN 
    Udeleženec u ON d.idDisciplina = u.Disciplina_idDisciplina
GROUP BY 
    d.`Ime discipline`;

#5 V kateri disciplini je leta 2020 “Miha Kos” dobil največ zlatih medalj?

INSERT INTO Disciplina (idDisciplina, `Ime discipline`) VALUES
(50, 'Met krogle'),
(51, '100m tek'),
(52, 'Skok v daljino');

INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, `Telesna višina`, Teža, Štartna_Lista_idŠtartna_Lista, Disciplina_idDisciplina, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(50, 'Miha', 'Kos', '180', '75', 1, 50, 1, 1, 1);

INSERT INTO Uspeh_Na_Prejsnjih_Igrah (idUspeh_Na_Prejšnjih_Igrah, `Leto iger`, `Doseženo Mesto`, Udeleženec_idUdeleženec) VALUES
(50, '2020-01-01', 'Prvo mesto', 50),
(51, '2020-01-01', 'Prvo mesto', 50);

SELECT 
    d.`Ime discipline`,
    COUNT(up.`idUspeh_Na_Prejšnjih_Igrah`) AS `Število zlatih medalj`
FROM 
    Udeleženec u
JOIN 
    Uspeh_Na_Prejsnjih_Igrah up ON u.idUdeleženec = up.Udeleženec_idUdeleženec
JOIN 
    Disciplina d ON u.Disciplina_idDisciplina = d.idDisciplina
WHERE 
    u.Ime = 'Miha' AND u.Priimek = 'Kos' AND YEAR(up.`Leto iger`) = 2020 AND up.`Doseženo Mesto` = 'Prvo mesto'
GROUP BY 
    d.`Ime discipline`
HAVING 
    COUNT(up.`idUspeh_Na_Prejšnjih_Igrah`) = (
        SELECT MAX(`Število zlatih medalj`) 
        FROM (
            SELECT 
                COUNT(up2.`idUspeh_Na_Prejšnjih_Igrah`) AS `Število zlatih medalj`
            FROM 
                Udeleženec u2
            JOIN 
                Uspeh_Na_Prejsnjih_Igrah up2 ON u2.idUdeleženec = up2.Udeleženec_idUdeleženec
            WHERE 
                u2.Ime = 'Miha' AND u2.Priimek = 'Kos' AND YEAR(up2.`Leto iger`) = 2020 AND up2.`Doseženo Mesto` = 'Prvo mesto'
            GROUP BY 
                u2.Disciplina_idDisciplina
        ) t
    );
    
#6 Kateri športniki iz “Jamajke” so v “atletiki” imeli višje štartno mesto, kot je povprečno štartno mesto za tekmovalce v tisti disciplini za vse države?

INSERT INTO Drzava (idDržava, `Ime države`) VALUES
(60, 'Jamajka'),
(70, 'Amerika');

INSERT INTO Disciplina (idDisciplina, `Ime discipline`) VALUES
(70, 'Atletika');

INSERT INTO Startna_Lista (idŠtartna_Lista, Datum, Ura) VALUES
(60, '2023-07-01', '2023-07-01 09:00:00'),
(61, '2023-07-02', '2023-07-02 10:00:00'),
(62, '2023-07-03', '2023-07-03 11:00:00');

-- Športniki iz Jamajke
INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, Drzava_idDržava, Disciplina_idDisciplina, Štartna_Lista_idŠtartna_Lista, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(300, 'Usain', 'Bolt', 60, 70, 3, 2, 2, 2),
(301, 'Yohan', 'Blake', 60, 70, 4, 2, 2, 2);

-- Športniki iz drugih držav
INSERT INTO Udeleženec (idUdeleženec, Ime, Priimek, Drzava_idDržava, Disciplina_idDisciplina, Štartna_Lista_idŠtartna_Lista, Medalja_idMedalja, Ekipa_idEkipa, Trener_idTrener) VALUES
(310, 'Tyson', 'Gay', 70, 70, 1, 1, 1, 1),
(311, 'Justin', 'Gatlin', 70, 70, 2, 1, 1, 1);



select * from Udeleženec;
select * from Drzava;
select * from Medalja;

SELECT 
    u.Ime, 
    u.Priimek, 
    u.Štartna_Lista_idŠtartna_Lista
FROM 
    Udeleženec u
JOIN 
    Drzava d ON u.Drzava_idDržava = d.idDržava
JOIN 
    Disciplina di ON u.Disciplina_idDisciplina = di.idDisciplina
JOIN 
    Startna_Lista sl ON u.Štartna_Lista_idŠtartna_Lista = sl.idŠtartna_Lista
WHERE 
    d.`Ime države` = 'Jamajka'
    AND di.`Ime discipline` = 'Atletika'
    AND sl.idŠtartna_Lista < (
        SELECT AVG(sl2.idŠtartna_Lista) AS avg_start_position
        FROM Udeleženec u2
        JOIN Startna_Lista sl2 ON u2.Štartna_Lista_idŠtartna_Lista = sl2.idŠtartna_Lista
        JOIN Disciplina di2 ON u2.Disciplina_idDisciplina = di2.idDisciplina
        WHERE di2.`Ime discipline` = 'Atletika'
    );
	
    
#7 Spremeni priimek igralca “Miha Kos” v Horvat.

UPDATE Udeleženec
SET Priimek = 'Horvat'
WHERE Ime = 'Miha' AND Priimek = 'Kos';

Select * from Udeleženec;
¸
#8 
DELETE FROM Disciplina
WHERE `Ime discipline` = 'odbojka';

select * from Disciplina;

#dodatno
select * from Ekipa;
select * from Udeleženec;

SELECT 
    e.`Ime ekipe`,
    COUNT(*) AS ŠteviloUdeležencev
FROM 
    Udeleženec u
JOIN 
    Ekipa e ON u.Ekipa_idEkipa = e.idEkipa
GROUP BY 
    u.Ekipa_idEkipa
HAVING 
    ŠteviloUdeležencev = (
        SELECT MAX(ŠteviloUdeležencev)
        FROM (
            SELECT 
                Ekipa_idEkipa, 
                COUNT(*) AS ŠteviloUdeležencev
            FROM 
                Udeleženec
            GROUP BY 
                Ekipa_idEkipa
        ) AS SubQuery
    );




