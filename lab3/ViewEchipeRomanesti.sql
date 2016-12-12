USE LigaFotbalTest
GO
DROP VIEW [Echipe Romanesti]
GO
CREATE VIEW [Echipe Romanesti] AS
SELECT E.idEchipa, E.idSerie , E.numeEchipa
FROM Echipa E  INNER JOIN (Serie S INNER JOIN (Liga L INNER JOIN (Federatie F INNER JOIN Tara T ON (F.idTara =  T.idTara AND T.nume='Romania')) ON (L.idFederatie = F.idFederatie))
ON (S.idLiga = L.idLiga)) ON (E.idSerie = S.idSerie)

