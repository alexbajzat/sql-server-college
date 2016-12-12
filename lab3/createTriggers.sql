USE LigaFotbalTest
GO
IF (OBJECT_ID(N'utrPlayerTrigger',N'TR') IS NOT NULL)
	DROP TRIGGER utrPlayerTrigger

GO

CREATE TRIGGER utrPlayerTrigger 
ON Jucator
FOR INSERT ,DELETE , UPDATE
AS
	BEGIN
		DECLARE @inserts INTEGER
		SET @inserts  = (SELECT count(*) FROM inserted)

		DECLARE @deletes INTEGER
		SET @deletes = (SELECT count(*) FROM deleted)

		IF(@inserts > 0 AND @deletes = 0)
			PRINT cast(getdate() as varchar) + ' I ' + 'Jucator' + ' Affected :' + cast(@inserts as varchar)

		IF(@inserts = 0 AND @deletes > 0)
			PRINT cast(getdate() as varchar) + ' D ' + 'Jucator' + ' Affected :' + cast(@deletes as varchar)

		IF(@inserts > 0 AND @deletes > 0)
			PRINT cast(getdate() as varchar) + ' U ' + 'Jucator' + ' Affected :' + cast(@deletes as varchar)

		IF(@inserts = 0 AND @deletes = 0)
			PRINT ' Affected :' + cast(@deletes as varchar)

	END

GO
IF (OBJECT_ID(N'utrUpdatePlayer',N'TR') IS NOT NULL)
	DROP TRIGGER utrUpdatePlayer


GO
IF (OBJECT_ID(N'utrDeletePlayer',N'TR') IS NOT NULL)
	DROP TRIGGER utrDeletePlayer

GO
