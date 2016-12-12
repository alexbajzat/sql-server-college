use LigaFotbal
GO

DELETE FROM Jucator
WHERE nume IN ('Badea','Albert')

DELETE FROM Echipa
WHERE idSerie = 1

DELETE FROM Tara
WHERE nume LIKE 'U%' OR idTara BETWEEN 1 AND 3