use Inchirieri
go

/*
cluster, scan
*/
SELECT idPersoana
FROM Persoana
GROUP BY(idPersoana)


/*
cluster, seek
*/
SELECT idPersoana, numePersoana
FROM Persoana
WHERE idPersoana = 2980

/*
 non-cluster , scan
*/
SELECT idMasina
FROM Masina
ORDER BY(serieSasiu)

/*
non-cluster, seek
*/

SELECT model, serieSasiu
FROM Masina
WHERE serieSasiu = 40 OR serieSasiu = 195