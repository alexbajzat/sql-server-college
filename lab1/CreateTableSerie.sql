use LigaFotbal

CREATE TABLE SERIE (
	idSerie INT PRIMARY KEY IDENTITY(1,1),
	idLiga INT FOREIGN KEY REFERENCES Liga,
	nrSerie INT

	CONSTRAINT FK_SERIE_LIGA FOREIGN KEY (idLiga) REFERENCES Liga ON DELETE CASCADE ON UPDATE NO ACTION

)