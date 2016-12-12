USE LigaFotbalTest
GO
if(OBJECT_ID(N'uspAdaugare',N'P') IS NOT NULL)
	DROP PROCEDURE uspAdaugare

GO
/*
 Pentru aceeasi echipa creaza:
	-Creaza un jucator (idEchipa, nume , prenume ,varsta)
	-Creaza o relatie Sponsor_Echipa (idSponsor , idEchipa, beneficiu , suma)
	-Creeaza o relatie Campionat_Echipa (idCampionat , idEchipa, an , puncte)
	-Creeaza un manager (idEchipa , Nume)
	
Creeaza o Tara  (Tara)
*/
CREATE PROC uspAdaugare(@idEchipa INT,@numeJucator VARCHAR(50), @prenumeJucator VARCHAR(50), @varsta INT, @idSponsor INT,@bun VARCHAR(50), @sum INT,
			@idCampionat INT,@an INT,@pct INT,@venit INT, @tara VARCHAR(50), @numeManager VARCHAR(50))
AS
BEGIN
	DECLARE @checkVarsta INT
	DECLARE @checkIdEchipa INT
	DECLARE @checkIdSponsor INT
	DECLARE @checkBun INT
	DECLARE @checkSum INT
	DECLARE @checkIdCampionat INT 
	DECLARE @checkAn INT
	DECLARE @checkPct INT


	EXEC uspValidateVarsta @varsta, @out= @checkVarsta OUTPUT
	EXEC uspValidateIdEchipa @idEchipa, @out=@checkIdEchipa OUTPUT
	EXEC uspValidateIdSponsor @idSponsor, @out =@checkIdSponsor OUTPUT
	EXEC uspValidateBeneficiu @bun, @out = @checkBun OUTPUT
	EXEC uspValidateSum @sum, @out =@checkSum OUTPUT
	EXEC uspValidateIdCampionat @idCampionat, @out=@checkIdCampionat OUTPUT
	EXEC uspValidateAnCampionat @an , @out= @checkAn OUTPUT
	EXEC uspValidatePuncteCampionat @pct , @out = @checkPct OUTPUT



	/*
	ADAUGA JUCATOR check varsta, idechipa
	*/
	IF (@checkVarsta = 1 AND @checkIdEchipa = 1)
	BEGIN
		INSERT INTO Jucator
		VALUES (@idEchipa,@numeJucator,@prenumeJucator, @varsta) 
	END
	ELSE
	BEGIN
		PRINT 'INCORRECT INPUT FOR JUCATOR'
		PRINT 'CHECK VARSTA: '
		PRINT @checkVarsta
		PRINT 'CHECKIDECHIPA: '
		PRINT @checkidEchipa
		PRINT @prenumeJucator
		PRINT @numeJucator
		PRINT @varsta
		PRINT @idEchipa
	END

	/*
	-Creaza o relatie Sponsor_Echipa (idSponsor , idEchipa, beneficiu , suma)
	check idSPonsor, idEchipa, beneficiu , suma
	*/
	IF (@checkIdSponsor =1 AND @checkIdEchipa = 1 AND  @checkBun = 1 AND (dbo.usfValidateSum(@sum) = 1) )
	BEGIN
		INSERT INTO Echipa_Sponsor
		VALUES (@idEchipa, @idSponsor, @bun, @sum)
	END
	ELSE
	BEGIN
		PRINT 'ERROR IN ADAUGARE ECHIPA_SPONSOR'
		PRINT 'CHECK IDSPONSOR : '
		PRINT @checkIdSponsor
		PRINT 'CHECK IDECHIPA'
		PRINT @checkIdEchipa
		PRINT 'CHECKBUN: ' 
		PRINT @checkBun 
		PRINT 'CHECKSUM: '
		PRINT @checkSum 

	END

	/*
	-Creeaza o relatie Campionat_Echipa (idCampionat , idEchipa, an , puncte)
	check idCampionat , idEchipa , an , puncte
	*/
	IF (@checkIdCampionat =1 AND @checkIdEchipa = 1 AND  @checkAn = 1 AND @checkPct =1 )
	BEGIN
		INSERT INTO Campionat_Echipa
		VALUES (@idEchipa, @idCampionat, @an, @pct ,@venit)
	END
	ELSE
	BEGIN
		PRINT 'ERROR IN ADAUGARE ECHIPA_CAMPIONAT'
		PRINT 'CHECK IDCAMPIONAT : '
		PRINT @checkIdCampionat
		PRINT 'CHECK IDECHIPA'
		PRINT @checkIdEchipa
		PRINT 'CHECKAN: ' 
		PRINT @checkAn 
		PRINT 'CHECKPCT: '
		PRINT @checkPct 

	END

	/*
	Creeaza un manager (idEchipa, nume)
	check idEchipa
	*/
	IF( @checkIdEchipa = 1 )
	BEGIN
		INSERT INTO Manager
		VALUES (@idEchipa , @numeManager)
	END
	ELSE
	BEGIN
		PRINT 'ERROR IN ADAUGA MANAGER:'
		PRINT 'CHECKID:'
		PRINT @checkIdEchipa
	END

	/*
	Creeaza o tara
	*/

	INSERT INTO Tara
	VALUES (@tara)

END
