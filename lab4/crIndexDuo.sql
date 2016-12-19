use Inchirieri
go


DROP INDEX IND_MASINA_ID_MODEL ON Masina
CREATE NONCLUSTERED INDEX IND_MASINA_ID_MODEL ON Masina(idMasina,model)

SELECT idMasina , model
FROM Masina
WHERE idMasina > 9980 AND model != 'Audi'
