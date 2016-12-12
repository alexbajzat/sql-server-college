use LigaFotbal
Go

/*
1
UNION
*/

SELECT E.numeEchipa
FROM Echipa E 
WHERE idSerie = 3

UNION ALL

SELECT E.numeEchipa
FROM Echipa E
WHERE idSerie = 1
ORDER BY E.numeEchipa
/*
2
OR
*/

SELECT J.nume ,J.prenume
FROM Jucator J
WHERE idEchipa= 4
OR prenume LIKE 'M%'
ORDER BY J.nume
/*
3
INTERSECT
*/

SELECT E.numeEchipa
FROM Echipa E
WHERE idSerie = 3

INTERSECT

SELECT E.numeEchipa
FROM Echipa E, Echipa_Sponsor ES
WHERE E.idEchipa = ES.idEchipa

/*
4
IN
*/
SELECT E.numeEchipa
FROM Echipa E
WHERE (
SELECT E.numeEchipa
FROM Echipa E , Echipa_Fan EF
WHERE E.idEchipa = EF.idEchipa AND EF.idFan=1) 
IN
(SELECT E.numeEchipa
FROM Echipa E
WHERE idSerie = 3)
ORDER BY E.numeEchipa

/*
5 
EXCEPT

Numele, prenumele, idEchipa la jucatorii care au particiat la campionat dar
echipa lor a avut sub 30 de puncte acumulate in campionat
*/

SELECT J.nume, J.prenume, J.idEchipa
FROM Jucator J, Echipa E
WHERE E.idSerie = 3 AND E.idEchipa = J.idEchipa

EXCEPT

SELECT J.nume , J.prenume, J.idEchipa
FROM Jucator J, Echipa E, Campionat_Echipa CE
WHERE J.idEchipa = E.idEchipa AND E.idEchipa = CE.idEchipa AND CE.puncte > 30

/*
6
NOT IN

*/
SELECT E.numeEchipa
FROM Echipa E
WHERE E.idEchipa 

NOT IN(

SELECT E.idEchipa
FROM Echipa E JOIN Echipa_Sponsor ES ON E.idEchipa = ES.idEchipa
WHERE E.idSerie = 3 AND ES.suma > 10
)

/*
7
LEFT JOIN
Sa se afiseze toti sponsorii si fanii echipelor care nu au participat in 1998 sau 2016 la 
vreun campionat
*/
SELECT DISTINCT F.numeFan, S.nume
FROM Campionat_Echipa CE LEFT JOIN ( Echipa_Sponsor ES JOIN Sponsor S ON ( ES.idSponsor = S.idSponsor)) ON (CE.idEchipa = ES.idEchipa)
	JOIN (Echipa_Fan EF JOIN FAN F ON (EF.idFan = F.idFan))  ON (CE.idEchipa = EF.idFan) 
WHERE ES.beneficiu IS NULL


/*11
IMBRICARE

Numele echipelor sponsorizate de un sponsor cu "T" la inceput
*/

SELECT E.numeEchipa
FROM Echipa E
WHERE E.idEchipa IN(
	SELECT E.idEchipa
	FROM Echipa E JOIN Campionat_Echipa CE ON (E.idEchipa = CE.idEchipa) JOIN Echipa_Sponsor ES ON (E.idEchipa = ES.idEchipa)
	WHERE ES.idSponsor IN (
		SELECT S.idSponsor
		FROM Sponsor S
		WHERE S.nume LIKE 'T%'
	)
	)
/*
12
IMBRICARE

Numele jucatorilor care apartin echipelor 
sponsorizate cu altceva decat haine si bani
*/

SELECT J.nume, J.prenume
FROM Jucator J
WHERE J.idEchipa NOT IN (
	SELECT E.idEchipa
	FROM Echipa E JOIN Echipa_Sponsor ES ON ( E.idEchipa = ES.idEchipa )
	WHERE ES.beneficiu IN ('haine','bani')
)

/*
13
EXISTS
*/

SELECT S.nume
FROM Sponsor S
WHERE EXISTS(
	SELECT S2.idSponsor
	FROM Sponsor S2 JOIN (Echipa_Sponsor ES JOIN Echipa_Fan EF ON (ES.idEchipa = EF.idEchipa))ON (S2.idSponsor = ES.idSponsor)
	WHERE S2.nume LIKE 'O%' OR EF.nrMelodii> 50
)
/*
14
EXISTS
*/

SELECT E.numeEchipa
FROM Echipa E
WHERE EXISTS( SELECT NULL)

/*
15
Imbricare in caluza from

Sa se afiseze toate echipele din seria 3 care au maxim 15 puncte
in orice campionat
*/

SELECT DISTINCT E.numeEchipa
FROM (SELECT E2.idEchipa, E2.numeEchipa
	  FROM Echipa E2 JOIN Serie S ON (E2.idSerie = S.idSerie)
	  WHERE E2.idSerie = 3
	  ) E JOIN Campionat_Echipa CE ON (E.idEchipa = CE.idEchipa)

WHERE CE.puncte <=15
/*
16
Imbricare in clauza from

Sa se afiseze toate campionatele unde cel putin o echipa
a strans cel putin 30 de puncte si a participat un din echipele (UTA, Bayern,FC Voluntari)
*/
SELECT DISTINCT C.numeCampionat
FROM (SELECT C2.idCampionat, C2.numeCampionat
	FROM Campionat C2 JOIN Campionat_Echipa CE ON (C2.idCampionat = CE.idCampionat)
	WHERE CE.puncte>= 30
) C JOIN Campionat_Echipa CE ON (C.idCampionat = CE.idCampionat) JOIN Echipa E ON (CE.idEchipa = E.idEchipa)
WHERE E.numeEchipa IN ('UTA' , 'Bayern', 'FC Voluntari')

/*
17
GROUP BY 
CU HAVING
CU MAX
Sa se afiseze numele tuturor campionatelor in care 
punctajul maxim pentru o echipa nu depaseste 35
*/


SELECT C.numeCampionat, MAX(CE.puncte) AS [Total pcts]
FROM Campionat C JOIN Campionat_Echipa CE ON (C.idCampionat = CE.idCampionat)
GROUP BY C.numeCampionat
HAVING MAX(CE.puncte) < 50

/*
18
GROUP BY
CU HAVING
CU COUNT

Sa se afiseze sponsorii care au sponsorizat o echipa 
care a participat la un campionat, si sa se afiseze numarul
de participari al acelei echipe la campionat (daca sunt minim 2 participari)

*/

SELECT  S.nume,E.numeEchipa , COUNT(ES.idEchipa) AS Participari
FROM Echipa E JOIN Echipa_Sponsor ES ON (E.idEchipa = ES.idEchipa) 
		JOIN Sponsor S ON (ES.idSponsor=S.idSponsor) 
			JOIN Campionat_Echipa CE ON (E.idEchipa = CE.idEchipa)
GROUP BY E.numeEchipa,S.nume
HAVING COUNT(ES.idEchipa) > 1


/*
19
GROUP BY 
CU MIN 

Sa se afiseze toate echipele , impreuna cu sponsorii care au fost 
sponsorizati cu minim 500 de lei
*/

SELECT E.numeEchipa, S.nume , MIN(ES.suma) AS [Suma minima]
FROM Echipa E JOIN Echipa_Sponsor ES ON ( E.idEchipa = ES.idEchipa ) JOIN Sponsor S ON ( ES.idSponsor = S.idSponsor)
GROUP BY S.nume , E.numeEchipa
HAVING MIN(ES.suma) > 500

/*
20
GROUP BY
CU SUM 

Sa se afiseze toate echipele cu suma totala de sponsorizare
*/

SELECT E.numeEchipa, SUM(ES.suma) AS [Suma totala]
FROM Echipa E JOIN Echipa_Sponsor ES ON (E.idEchipa = ES.idEchipa)
GROUP BY E.numeEchipa


/*
21
ANY

Sa se afiseze sponsorii care au sponsorizat cel putin o echipa
cu o suma mai mare decat cel putin venitul unei echipa de la un campionat
(minim 1000 lei)
*/

SELECT S.nume, ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON ( S.idSponsor = ES.idSponsor)
WHERE  ES.suma > ANY (
		SELECT CE.venit
		FROM Campionat_Echipa CE
		WHERE CE.venit > 1000
		)

/*
22
ANY 
CU OPERATORI DE AGREGARE
*/
SELECT S.nume , ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON (S.idSponsor = ES.idSponsor)
WHERE ES.suma > (
	SELECT MIN(CE.venit) AS MINIM
	FROM Campionat_Echipa CE
	WHERE CE.venit > 1000
	)

/*
23
ALL

Afisati sponsorii care au suma sponsorizata la o echipa 
mai mica decat toate veniturile castigate de echipe
in timpul campionatelor
*/

SELECT S.nume, ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON ( S.idSponsor = ES.idSponsor)
WHERE ES.suma < ALL(
		SELECT CE.venit
		FROM Campionat_Echipa CE 
	)

/*
24
ALL
CU OPERATORI DE AGREGARE
*/


SELECT S.nume, ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON ( S.idSponsor = ES.idSponsor)
WHERE ES.suma < (SELECT MIN(CE.venit)
		FROM Campionat_Echipa CE
	)


/*
25
ALL 
CU <> =

Sa se afiseze sponsorii care nu sustin un campionat
*/


SELECT S.nume, ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON ( S.idSponsor = ES.idSponsor)
WHERE  S.nume != ALL (
		SELECT C.numeCampionat
		FROM Campionat_Echipa CE JOIN Campionat C ON ( CE.idCampionat = C.idCampionat)
		)

/*
26
ALL 
CU <> =

Sa se afiseze sponsorii care au sustinut un campionat
*/


SELECT S.nume, ES.suma
FROM Sponsor S JOIN Echipa_Sponsor ES ON ( S.idSponsor = ES.idSponsor)
WHERE  S.nume = ANY (
		SELECT C.numeCampionat
		FROM Campionat_Echipa CE JOIN Campionat C ON ( CE.idCampionat = C.idCampionat)
		)