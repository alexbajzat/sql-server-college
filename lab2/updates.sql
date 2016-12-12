UPDATE Jucator
SET nume='Badea', prenume='Mircea'
WHERE nume IN ('Alibec','Danciulescu')

UPDATE Echipa
SET numeEchipa = 'FC Voluntari'
WHERE idSerie = 1 AND numeEchipa LIKE 'S%'

UPDATE Echipa
SET idSerie = 3
WHERE idSerie BETWEEN 1 AND 2

UPDATE Serie
SET nrSerie = 5
WHERE idLiga = 1