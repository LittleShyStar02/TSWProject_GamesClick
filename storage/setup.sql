DROP DATABASE IF EXISTS TSWProject;
CREATE DATABASE IF NOT EXISTS TSWProject;
USE TSWProject;

/*
  TABLE: Amministratore
*/
CREATE TABLE IF NOT EXISTS Amministratore
(
  IDAdmin INT NOT NULL AUTO_INCREMENT UNIQUE,
  Email VARCHAR(128)  NOT NULL UNIQUE,
  PRIMARY KEY(IDAdmin)
);

/*
  TABLE: Gioco
*/
CREATE TABLE IF NOT EXISTS Gioco
(
  IDGioco INT NOT NULL AUTO_INCREMENT UNIQUE,
  Nome VARCHAR(32) NOT NULL UNIQUE,
  Descrizione VARCHAR(2000),
  Prezzo DOUBLE NOT NULL,
  DataRilascio DATE NOT NULL,
  EtaMinima INT,
  PreviewUrl VARCHAR(256),
  IDAdmin INT NOT NULL,
  PRIMARY KEY(IDGioco),
  FOREIGN KEY (IDAdmin) REFERENCES Amministratore(IDAdmin)
);

/*
  TABLE: Console
*/
CREATE TABLE IF NOT EXISTS Console
(
  IDConsole INT NOT NULL AUTO_INCREMENT UNIQUE,
  Nome VARCHAR(32) NOT NULL,
  Descrizione VARCHAR(2000),
  PRIMARY KEY(IDConsole)
);

/*
  TABLE: EsecuzioneGioco
*/
CREATE TABLE IF NOT EXISTS EsecuzioneGioco
(
  IDConsole INT NOT NULL,
  IDGioco INT NOT NULL,
  FOREIGN KEY (IDConsole) REFERENCES Console(IDConsole),
  FOREIGN KEY (IDGioco) REFERENCES Gioco(IDGioco)
);

/*
  TABLE: Categoria
*/
CREATE TABLE IF NOT EXISTS Categoria
(
  IDCategoria INT NOT NULL AUTO_INCREMENT UNIQUE,
  Nome VARCHAR(32) NOT NULL,
  Descrizione VARCHAR(2000),
  PRIMARY KEY(IDCategoria)
);

/*
  TABLE: CategoriaGioco
*/
CREATE TABLE IF NOT EXISTS CategoriaGioco
(
  IDCategoria INT NOT NULL,
  IDGioco INT NOT NULL,
  FOREIGN KEY (IDCategoria) REFERENCES Categoria(IDCategoria),
  FOREIGN KEY (IDGioco) REFERENCES Gioco(IDGioco)
);

/*
  TABLE: Utente
*/
CREATE TABLE IF NOT EXISTS Utente
(
  IDUtente INT NOT NULL AUTO_INCREMENT UNIQUE,
  Nome VARCHAR(32) NOT NULL,
  Cognome VARCHAR(32) NOT NULL,
  Email VARCHAR(128)  NOT NULL UNIQUE,
  Password VARCHAR(32) NOT NULL,
  DataNascita DATE,
  Indirizzo VARCHAR(64) NOT NULL,
  PRIMARY KEY(IDUtente)
);

/*
  TABLE: Metodo
*/
CREATE TABLE IF NOT EXISTS Metodo
(
  IDMetodo INT NOT NULL AUTO_INCREMENT UNIQUE,
  Nome VARCHAR(32) NOT NULL,
  Info VARCHAR(256) NOT NULL,
  IDUtente INT NOT NULL,
  PRIMARY KEY(IDMetodo),
  FOREIGN KEY (IDUtente) REFERENCES Utente(IDUtente)
);

/*
  TABLE: Recensione
*/
CREATE TABLE IF NOT EXISTS Recensione
(
  IDRecensione INT NOT NULL AUTO_INCREMENT UNIQUE,
  IDUtente INT NOT NULL,
  IDGioco INT NOT NULL,
  Testo VARCHAR(2000),
  PRIMARY KEY(IDRecensione),
  FOREIGN KEY (IDUtente) REFERENCES Utente(IDUtente),
  FOREIGN KEY (IDGioco) REFERENCES Gioco(IDGioco)
);

/*
  TABLE: Acquisto
*/
CREATE TABLE IF NOT EXISTS Acquisto
(
  IDAcquisto INT NOT NULL AUTO_INCREMENT UNIQUE,
  IDUtente INT NOT NULL,
  IDGioco INT NOT NULL,
  IDMetodo INT NOT NULL,
  Quantita INT NOT NULL,
  DataAcquisto DATE NOT NULL,
  PRIMARY KEY(IDAcquisto),
  FOREIGN KEY (IDUtente) REFERENCES Utente(IDUtente),
  FOREIGN KEY (IDGioco) REFERENCES Gioco(IDGioco),
  FOREIGN KEY (IDMetodo) REFERENCES Metodo(IDMetodo)
);

INSERT INTO Utente(Nome,Cognome,Email,Password,DataNascita,Indirizzo) VALUES("Vincenzo","Cutolo","vincenzocutolo80@gmail.com","Provola44","2002-05-30","Provola44");
INSERT INTO Amministratore(Email) VALUES("vincenzocutolo80@gmail.com");
