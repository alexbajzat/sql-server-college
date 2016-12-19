USE Inchirieri
GO

DROP TABLE Inchirieri
DROP TABLE Persoana
DROP TABLE Masina

CREATE TABLE Persoana(
	idPersoana INTEGER PRIMARY KEY,
	varsta INTEGER ,
	numePersoana VARCHAR(50) NOT NULL,
	oras VARCHAR(50) 
)


CREATE TABLE Masina(
	idMasina INTEGER PRIMARY KEY,
	serieSasiu INTEGER UNIQUE,
	anFabricatie INTEGER,
	model VARCHAR(30)
)



CREATE TABLE Inchirieri(
	idMasina INTEGER FOREIGN KEY REFERENCES Masina(idMasina),
	idPersoana INTEGER FOREIGN KEY REFERENCES Persoana(idPersoana),

	CONSTRAINT PK_INCHIRIERI PRIMARY KEY(idMasina,idPersoana)

)