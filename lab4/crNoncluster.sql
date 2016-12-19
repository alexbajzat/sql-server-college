use Inchirieri
go

SELECT numePersoana
FROM Persoana
WHERE numePersoana LIKE 'I%' OR numePersoana LIKE'V%'

DROP INDEX IND_PERSOANA_NUMEPERSOANA ON Persoana
CREATE NONCLUSTERED INDEX IND_PERSOANA_NUMEPERSOANA ON Persoana(numePersoana)
