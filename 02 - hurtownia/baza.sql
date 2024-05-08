DROP TABLE Hur_Sprzedaz CASCADE CONSTRAINTS;
DROP TABLE Hur_Restauracja CASCADE CONSTRAINTS;
DROP TABLE Hur_Pracownik CASCADE CONSTRAINTS;
DROP TABLE Hur_Stanowiska CASCADE CONSTRAINTS;
DROP TABLE Hur_Dania CASCADE CONSTRAINTS;
DROP TABLE Hur_Typ_Dania CASCADE CONSTRAINTS;
DROP TABLE Hur_Wojewodztwa CASCADE CONSTRAINTS;

CREATE TABLE Hur_Wojewodztwa (
  id_wojewodztwa     NUMBER(3,0) NOT NULL,
  nazwa_woj          VARCHAR2(15) NOT NULL,
  CONSTRAINT pk_wojHur PRIMARY KEY (id_wojewodztwa)
);

CREATE TABLE Hur_Typ_Dania (
  id_typ_dania        NUMBER(3,0) NOT NULL,
  nazwa_typu          VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_typ_daniaHur PRIMARY KEY (id_typ_dania)
);

CREATE TABLE Hur_Dania (
  id_dania           NUMBER(3,0) NOT NULL,
  nazwa_dania         VARCHAR2(20) NOT NULL,
  cena                NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_daniaHur PRIMARY KEY (id_dania)
);

CREATE TABLE Hur_Stanowiska (
  id_stanowiska       NUMBER(3,0) NOT NULL,
  nazwa_stanowiska    VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_stanowiskaHur PRIMARY KEY (id_stanowiska)
);

CREATE TABLE Hur_Pracownik (
  id_pracownika       NUMBER(4,0) NOT NULL,
  imie                VARCHAR2(20) NOT NULL,
  nazwisko            VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_pracownikHur PRIMARY KEY (id_pracownika)
);

CREATE TABLE Hur_Restauracja (
  id_restauracji      NUMBER(3,0) NOT NULL,
  nazwa_restauracji   VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_restauracjiHur PRIMARY KEY (id_restauracji)
);

CREATE TABLE Hur_Sprzedaz (
  id_sprzedaz         NUMBER(5,0) NOT NULL,
  id_restauracji      NUMBER(3,0) NOT NULL,
  id_pracownika       NUMBER(4,0) NOT NULL,
  id_stanowiska       NUMBER(3,0) NOT NULL, 
  id_dania            NUMBER(3,0) NOT NULL,
  id_typ_dania        NUMBER(3,0) NOT NULL,
  id_wojewodztwa      NUMBER(3,0) NOT NULL,  
  data                DATE NOT NULL,
  CONSTRAINT pk_sprzedazHur PRIMARY KEY (id_sprzedaz),
  CONSTRAINT fk_resSprzedHur FOREIGN KEY (id_restauracji) REFERENCES Hur_Restauracja(id_restauracji),
  CONSTRAINT fk_pracSprzedHur FOREIGN KEY (id_pracownika) REFERENCES Hur_Pracownik(id_pracownika),
  CONSTRAINT fk_stanSprzedHur FOREIGN KEY (id_stanowiska) REFERENCES Hur_Stanowiska(id_stanowiska),  
  CONSTRAINT fk_daniaSprzedHur FOREIGN KEY (id_dania) REFERENCES Hur_Dania(id_dania),
  CONSTRAINT fk_typdaniaSprzedHur FOREIGN KEY (id_typ_dania) REFERENCES Hur_Typ_Dania(id_typ_dania),
  CONSTRAINT fk_wojSprzedHur FOREIGN KEY (id_wojewodztwa) REFERENCES Hur_Wojewodztwa(id_wojewodztwa) 
);
