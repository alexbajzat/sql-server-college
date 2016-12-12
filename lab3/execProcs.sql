use LigaFotbalTest
GO


Execute uspResetConstraints

/*
uspAdaugare (idEchipa , numeJucator, prenumeJucator, varstaJucator, idSponsor, beneficiu,suma, idCampionat,an,pct,venit,tara,numeManager
*/

EXEC uspAdaugare 5, 'test' , 'laurentio' , -5, 1 , 'haine', -1, 1,2005,-15,-19,'Polonia', 'Vasiliu'
