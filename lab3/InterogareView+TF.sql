/* 
Toti jucatori de la echipe romanesti cu varsta mai mare decat o varsta data
*/

SELECT P.nume, P.prenume , P.varsta, E.numeEchipa
FROM utfgetPlayersOlderThan(15) P JOIN [Echipe Romanesti] E ON (P.idEchipa = E.idEchipa) 