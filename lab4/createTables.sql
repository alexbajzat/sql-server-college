USE Inchirieri
GO

IF(OBJECT_ID(N'Persoana',N'U') IS NOT NULL)
	DROP TABLE Persoana
GO

CREATE TABLE Persoana(
	idPersoana INTEGER PRIMARY KEY,
	varsta INTEGER ,
	numePersoana VARCHAR(50) NOT NULL,
	oras VARCHAR(50) 
)

IF(OBJECT_ID(N'Masina',N'U') IS NOT NULL)
	DROP TABLE Masina
GO

CREATE TABLE Masina(
	idMasina INTEGER PRIMARY KEY,
	serieSasiu INTEGER UNIQUE,
	anFabricatie INTEGER,
	model VARCHAR(30)
)


IF(OBJECT_ID(N'Inchirieri',N'U') IS NOT NULL)
	DROP TABLE Inchirieri
GO

CREATE TABLE Inchirieri(
	idMasina INTEGER FOREIGN KEY REFERENCES Masina(idMasina),
	idPersoana INTEGER FOREIGN KEY REFERENCES Persoana(idPersoana),
	deadline DATE,

	CONSTRAINT PK_INCHIRIERI PRIMARY KEY(idMasina,idPersoana)

)