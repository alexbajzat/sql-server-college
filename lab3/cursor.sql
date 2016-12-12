use LigaFotbalTest
GO

DECLARE my1_cursor CURSOR FOR 
SELECT  T.object_id, T.name 
FROM sys.objects T
WHERE type= 'U'

DECLARE @table VARCHAR(100)
DECLARE @id INTEGER
DECLARE @count INTEGER
DECLARE @baseCommand VARCHAR(200)
DECLARE @pk VARCHAR(100)
DECLARE @fk VARCHAR(100)
DECLARE @compKey INTEGER

OPEN my1_cursor
FETCH NEXT FROM my1_cursor INTO @id,@table
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @baseCommand = 'ALTER TABLE '+@table+' DROP CONSTRAINT '
	SET @count = (SELECT count(*) FROM sys.objects O WHERE type='F' AND O.parent_object_id=@id)
	SET @compKey = (SELECT count(*) 
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS S JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE KC ON (S.CONSTRAINT_NAME = KC.CONSTRAINT_NAME) 
	WHERE S.TABLE_NAME= @table AND S.CONSTRAINT_TYPE='PRIMARY KEY')
	SET @pk = ( SELECT O.CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS O WHERE O.TABLE_NAME =@table AND O.CONSTRAINT_TYPE='PRIMARY KEY')
	SET @fk = (SELECT TOP(1) O.name FROM sys.objects O WHERE TYPE = 'F' AND O.parent_object_id = @id)
	
	
	IF(@count = 2 AND @compKey > 1) 
		BEGIN
			PRINT @table
			PRINT @count
			PRINT 'CHEIE COMPUSA :'
			PRINT @compKey
			PRINT @pk
			PRINT @fk
			DECLARE @command VARCHAR(200)
			SET @command = @baseCommand + @pk + ',' + @fk
			PRINT @command
 			EXEC (@command)
		END
	
			
	FETCH NEXT FROM my1_cursor INTO @id,@table
	
END
CLOSE my1_cursor
DEALLOCATE my1_cursor