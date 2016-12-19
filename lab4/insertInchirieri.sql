use Inchirieri
go


DELETE FROM Inchirieri WHERE 1=1
go

ALTER PROC InsertInchirieri
AS
BEGIN
	
	DECLARE insertCursor CURSOR FOR
	SELECT idPersoana
	FROM Persoana

	DECLARE @idPersoana INTEGER
	DECLARE @idMasina INTEGER
	DECLARE @count INTEGER
	
	OPEN insertCursor
	FETCH NEXT FROM insertCursor INTO @idPersoana
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @count = 0

		WHILE @count < 10
		BEGIN
		BEGIN TRY
			SET @idMasina = ROUND(RAND()*(10000),0)
			print @idMasina
			INSERT INTO Inchirieri VALUES(@idMasina,@idPersoana)
			SET @count = @count +1
		END TRY
		BEGIN CATCH

		END CATCH
			
		END
	FETCH NEXT FROM insertCursor INTO @idPersoana
	END
	CLOSE insertCursor
	DEALLOCATE insertCursor
END


GO
EXEC InsertInchirieri