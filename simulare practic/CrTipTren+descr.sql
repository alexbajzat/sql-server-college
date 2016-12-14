
/*
1. design baza 4p
2. o procedura stocata care primeste o ruta , o statie , un timp de sosire unul de plecare , daca statia exista pe ruta , se modifica
sosirea si plecarea , daca nu , se adauga statia cu valorile corespunzatoare 2p
3. scrieti un view care sa selecteze rutele care contin toate statiile 1p
4. o functie care sa returneze toate statiile prin care trec cel putin doua trenuri la un moment dat 2p
*/

use simularePractic
go

DROP TABLE Orar
DROP TABLE Statie
DROP TABLE Ruta
DROP TABLE Tren
DROP TABLE Tip_Tren


CREATE TABLE Tip_Tren(
	idTip int,
	descriere varchar(50),

	CONSTRAINT PK_TIP_TREN PRIMARY KEY(idTip)
)

CREATE TABLE Tren(
	idTren int,
	numeTren varchar(50),
	idTip int,

	CONSTRAINT PK_TREN PRIMARY KEY(idTren),
	CONSTRAINT FK_TREN_TIP_TREN FOREIGN KEY(idTip) REFERENCES Tip_Tren(idTip)
)


CREATE TABLE Statie(
	idStatie int,
	numeStatie varchar(50),

	CONSTRAINT PK_STATIE PRIMARY KEY(idStatie)
)

CREATE TABLE Ruta(
	idRuta int,
	numeRuta varchar(50),
	idTren int,

	CONSTRAINT PK_RUTA PRIMARY KEY(idRuta),
	CONSTRAINT FK_RUTA_TREN FOREIGN KEY(idTren) REFERENCES Tren
)

CREATE TABLE Orar(
	idRuta int ,
	idStatie int,
	sosire time,
	plecare time,
	
	CONSTRAINT FK_ORAR_RUTA FOREIGN KEY(idRuta) REFERENCES Ruta,
	CONSTRAINT FK_ORAR_STATIE FOREIGN KEY(idStatie) REFERENCES Statie,
	CONSTRAINT PK_ORAR PRIMARY KEY(idRuta,idStatie)
)

INSERT Tip_Tren(idTip, descriere) VALUES (1,'tip1'), (2,'tip2')
INSERT Tren(idtren , numeTren, idTip) VALUES (1,'t1',1), (2,'t2',1),(3,'t3',1)
INSERT Ruta(idRuta,numeRuta,idTren)	VALUES (1,'r1',1), (2,'r2',2),(3,'r3',1)
INSERT Statie(idStatie,numeStatie) VALUES (1,'s1'), (2,'s2'), (3,'s3')
INSERT Orar(idRuta,idStatie,sosire,plecare) VALUES 
(1,1,'5:00 PM', '5:10 PM'),(1,2,'6:00 PM', '6:10 PM'),(1,3,'7:00 PM', '7:10 PM'),
(2,1,'4:55 PM', '5:05 PM'),(2,2,'7:55 PM', '8:10 PM'),(3,1,'9:00 PM', '9:05 PM')

GO

--PROCEDURA STOCATA
ALTER PROC uspStatiePeRuta(@numeStatie VARCHAR(50), @numeRuta VARCHAR(50), @sosire TIME ,@plecare TIME)
AS
	DECLARE @idStatie INT = (SELECT idStatie FROM Statie WHERE numeStatie = @numeStatie)
	DECLARE	@idRuta INT = (SELECT idRuta FROM Ruta WHERE @numeRuta = numeRuta)

	IF NOT EXISTS (SELECT * FROM Orar WHERE idRuta = @idRuta AND idStatie = @idStatie)
		INSERT Orar(idStatie,idRuta , plecare, sosire)
			VALUES (@idStatie,@idRuta,@plecare,@sosire)
	ELSE
		UPDATE Orar	
		SET sosire = @sosire , plecare = @plecare
		WHERE idRuta = @idRuta AND @idStatie = idStatie

GO

EXEC uspStatiePeRuta @numeStatie = 's1', @numeRuta = 'r3' , @sosire = '10:00 AM', @plecare= '10:10 AM'

SELECT *
FROM ORAR

GO

--VIEW

ALTER VIEW RuteCuToateStatiile
AS
	SELECT numeRuta
	FROM Ruta
	WHERE idRuta IN 
	(SELECT idRuta
	 FROM Orar
	 GROUP BY idRuta
	 HAVING COUNT(idStatie) = (SELECT COUNT(idStatie) FROM Statie)
	)

go

SELECT * FROM RuteCuToateStatiile

go
--functia
ALTER FUNCTION StatiiAglomerate(@moment TIME)
RETURNS TABLE
AS
	RETURN 
		SELECT numeStatie
		FROM Statie
		WHERE idStatie IN
			(SELECT idStatie
			FROM Orar
			WHERE @moment BETWEEN sosire AND plecare
			GROUP BY idStatie
			HAVING COUNT(*)  >= 2)

			
GO
SELECT *
FROM StatiiAglomerate('5:00 PM')

SELECT idRuta , idStatie, sosire, plecare
FROM Orar
ORDER BY idRuta, idStatie




















