use Inchirieri
go


DELETE FROM Masina WHERE 1=1
go
ALTER PROC InsertValues
AS
BEGIN
	DECLARE @count INTEGER
	DECLARE @command VARCHAR(150)
	DECLARE @comValues VARCHAR(100)
	DECLARE @value VARCHAR(100) 
	DECLARE @modelList table (id varchar(100))

	INSERT @modelList values('BMW'),('Mercedes'),('Skoda'),('Audi'),('Dacia')

	SET @count = 1
	/* insert into Masina 10000 values */
	WHILE(@count <= 10000)
	BEGIN
		SET @command = 'INSERT INTO Masina VALUES('
		
		/* nr sasiu */
		SET @value = 10000- @count

		SET @command = @command + cast(@count as varchar(100)) + ',' +cast(@value as varchar(100))+ ','

		/* an de fabricatie*/
		SET @value= FLOOR(RAND()*(2016-1990)+1990)
		SET @command=@command + cast(@value as varchar(100))+ ','
		
		/* model*/
		SET @command = @command + '''' +(SELECT TOP 1 * FROM @modelList ORDER BY NEWID())+ '''' + ')'
		EXEC(@command)
		SET @count = @count +1
	END

END

GO
EXEC InsertValues