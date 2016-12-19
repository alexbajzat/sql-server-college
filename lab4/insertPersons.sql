use Inchirieri
go

IF(OBJECT_ID(N'uspInsertPersons',N'P') is not NULL)
	DROP PROC uspInsertPersons

go
CREATE PROC uspInsertPersons
AS
BEGIN
	DECLARE @count INTEGER
	DECLARE @command VARCHAR(100)
	DECLARE @comValues VARCHAR(50)
	DECLARE @value VARCHAR(50) 
	DECLARE @nameList table (id varchar(50))
	DECLARE @cityList table (id varchar(50))

	INSERT @nameList values ('Marcel'),('Vasile'),('Mirel'),('Iures'),('Andrei')
	INSERT @cityList values ('Cluj'),('Timisoara'),('Bucuresti'),('Mures'),('Vaslui')

	SET @count = 1
	/* insert into Persona 3000 values */
	WHILE(@count <= 3000)
	BEGIN
		SET @command = 'INSERT INTO Persoana VALUES('
		
		/* varsta */
		SET @value = FLOOR(RAND()*(80-20)+20)

		SET @command = @command + cast(@count as varchar(50)) + ',' +cast(@value as varchar(50))+ ','
		
		/* nume*/
		SET @command = @command + '''' +(SELECT TOP 1 * FROM @nameList ORDER BY NEWID())+ '''' + ','

		/* oras*/
		SET @command = @command + '''' +(SELECT TOP 1 * FROM @cityList ORDER BY NEWID())+ '''' + ')'
		PRINT(@command)
		EXEC(@command)
		SET @count = @count +1
	END

END

GO
EXEC uspInsertPersons