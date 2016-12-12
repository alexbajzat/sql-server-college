USE LigaFotbalTest
GO
IF (OBJECT_ID(N'utfgetPlayersOlderThan', N'TF') IS NOT NULL)
	DROP FUNCTION utfgetPlayersOlderThan

GO
CREATE FUNCTION utfgetPlayersOlderThan(@age int)
RETURNS TABLE
AS
RETURN 
	SELECT J.idJucator , J.idEchipa, J.nume, J.prenume,  J.varsta
	FROM Jucator J
	WHERE J.varsta > @age

