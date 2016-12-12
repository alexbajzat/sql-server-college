use LigaFotbal
GO

DELETE FROM Tara;
DBCC CHECKIDENT (Tara, RESEED, 0);
INSERT INTO Tara(nume)
	values('Romania'),
	('Germania'),
	('Franta'),
	('Ungaria')

DELETE FROM Federatie;
DBCC CHECKIDENT (Federatie, RESEED, 0);
INSERT INTO Federatie(nume,idTara)
	values('FRF',1),
	('DFF',2)

DELETE FROM Liga;
DBCC CHECKIDENT (Liga , RESEED, 0 );
INSERT INTO Liga(idFederatie,numeLiga)
	values(1,'Liga Bucegi'),
	(1, 'Liga Zuzu'),
	(2, 'Bundes Liga')

DELETE FROM Serie;
DBCC CHECKIDENT (Serie, RESEED, 0 );
INSERT INTO Serie(idLiga, nrSerie)
	values(1,1),
	(1,2),
	(2,1)

DELETE FROM Echipa;
DBCC CHECKIDENT (Echipa, RESEED, 0 );
INSERT INTO Echipa(idSerie,numeEchipa)
	values(1,'Steaua'),
	(1,'Dinamo'),
	(2,'Uta'),
	(3,'Bayern')

DELETE FROM Jucator;
DBCC CHECKIDENT (Jucator, RESEED, 0 );
INSERT INTO Jucator(nume,prenume,idEchipa)
	values('Alibec','Daniel',1),
	('Danciulescu','Mircea',2),
	('Neuer','Albert',4)

