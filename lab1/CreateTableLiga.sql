use LigaFotbal

CREATE TABLE Liga(
	idLiga INT PRIMARY KEY IDENTITY(1,1),
	idFederatie INT,
	numeLiga VARCHAR(50) DEFAULT ''

	CONSTRAINT FK_LIGA_FEDERATIE FOREIGN KEY (idFederatie) REFERENCES Federatie ON DELETE CASCADE ON UPDATE NO ACTION
	
)