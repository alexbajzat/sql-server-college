use Inchirieri
go

SELECT P.numePersoana, M.model
FROM Persoana P JOIN Inchirieri I ON (P.idPersoana = I.idPersoana) JOIN Masina M ON (I.idMasina = M.idMasina)
WHERE P.numePersoana = 'Vasile'

CREATE NONCLUSTERED INDEX IND_INCHIRIERI_IDPERS ON Inchirieri(idPersoana)
CREATE NONCLUSTERED INDEX IND_INCHIRIERI_IDMAS ON Inchirieri(idMasina)

SELECT P.numePersoana, M.model
FROM Persoana P JOIN Inchirieri I ON (P.idPersoana = I.idPersoana) JOIN Masina M ON (I.idMasina = M.idMasina)
WHERE P.numePersoana = 'Vasile'

DROP INDEX IND_INCHIRIERI_IDPERS ON Inchirieri
DROP INDEX IND_INCHIRIERI_IDMAS ON Inchirieri
