USE LigaFotbalTest
GO


/*
Sponsor_Echipa
*/
DROP PROCEDURE uspValidateSum
GO
CREATE PROC uspValidateSum(@sum INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 1
	IF (@sum < 0)
		SET @out = 0
END

GO
IF (OBJECT_ID(N'usfValidateSum',N'FN') IS NOT NULL)
	DROP FUNCTION usfValidateSum
GO

CREATE FUNCTION usfValidateSum(@sum INTEGER)
RETURNS INTEGER
BEGIN
	IF (@sum < 0)
		RETURN 0
	RETURN 1
END

GO

/*
Echipa_Sponsor
*/
DROP PROCEDURE uspValidateBeneficiu
GO
CREATE PROC uspValidateBeneficiu(@bun VARCHAR(50) , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 1

	IF (@bun NOT IN ('haine','bani','mancare','echipament medical'))
		SET @out = 0

END


GO

/*
Jucator
*/
DROP PROCEDURE uspValidateVarsta
GO
CREATE PROC uspValidateVarsta(@varsta INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 1

	IF ( @varsta < 0 )
		SET @out = 0
END

GO

/*
Campionat_Echipa
*/
DROP PROCEDURE uspValidateAnCampionat
GO
CREATE PROC uspValidateAnCampionat(@an INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 1
	
	IF(@an < 0)
		SET @out = 0 
END

GO

/*
Campionat_Echipa
*/
DROP PROCEDURE uspValidatePuncteCampionat
GO
CREATE PROC uspValidatePuncteCampionat(@pct INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 1
	IF (@pct < 0 )
		SET @out = 0
END

GO

/*
Campionat
*/
DROP PROCEDURE uspValidateIdCampionat
GO
CREATE PROC uspValidateIdCampionat(@idE INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 0
	IF (@idE IN (SELECT E.idEchipa FROM Echipa E))
		SET @out = 1
END

GO

/*
Echipa
*/
DROP PROCEDURE uspValidateIdEchipa
GO
CREATE PROC uspValidateIdEchipa(@idE INTEGER , @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 0
	IF (@idE IN (SELECT E.idEchipa FROM Echipa E))
		SET @out = 1
END

GO

/*
Sponsor
*/
DROP PROCEDURE uspValidateIdSponsor
GO
CREATE PROC uspValidateIdSponsor( @idS INTEGER, @out INTEGER OUTPUT)
AS
BEGIN
	SET @out = 0
	IF (@idS IN (SELECT S.idSponsor FROM Sponsor S))
		SET @out = 1
END