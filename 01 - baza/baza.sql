DROP TABLE Sprzedaz CASCADE CONSTRAINTS;
DROP TABLE Restauracja CASCADE CONSTRAINTS;
DROP TABLE Dostawca CASCADE CONSTRAINTS;
DROP TABLE Produkt CASCADE CONSTRAINTS;
DROP TABLE Typ_Produktu CASCADE CONSTRAINTS;
DROP TABLE Faktura CASCADE CONSTRAINTS;
DROP TABLE Kurier CASCADE CONSTRAINTS;
DROP TABLE Samochod CASCADE CONSTRAINTS;
DROP TABLE Marka CASCADE CONSTRAINTS;
DROP TABLE Model CASCADE CONSTRAINTS;
DROP TABLE Pracownik CASCADE CONSTRAINTS;
DROP TABLE Wyplata CASCADE CONSTRAINTS;
DROP TABLE Stanowiska CASCADE CONSTRAINTS;
DROP TABLE Dane_osobowe CASCADE CONSTRAINTS;
DROP TABLE Dania CASCADE CONSTRAINTS;
DROP TABLE Typ_Dania CASCADE CONSTRAINTS;
DROP TABLE Menu CASCADE CONSTRAINTS;
DROP TABLE Ulica CASCADE CONSTRAINTS;
DROP TABLE Miasta CASCADE CONSTRAINTS;
DROP TABLE Wojewodztwa CASCADE CONSTRAINTS;

CREATE TABLE Wojewodztwa (
  id_wojewodztwa     NUMBER(3,0) NOT NULL,
  nazwa_woj          VARCHAR2(15) NOT NULL,
  CONSTRAINT pk_woj PRIMARY KEY (id_wojewodztwa)
);

CREATE TABLE Miasta (
  id_miasta           NUMBER(3,0) NOT NULL,
  nazwa_miasta        VARCHAR2(15) NOT NULL,
  kod_pocztowy        VARCHAR2(6) NOT NULL,
  id_wojewodztwa      NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_miasta PRIMARY KEY (id_miasta),
  CONSTRAINT fk_wojMiasta FOREIGN KEY (id_wojewodztwa) REFERENCES Wojewodztwa(id_wojewodztwa)
);

CREATE TABLE Ulica (
  id_ulicy            NUMBER(3,0) NOT NULL,
  nazwa_ulicy         VARCHAR2(15) NOT NULL,
  CONSTRAINT pk_Ulica PRIMARY KEY (id_ulicy)
);

CREATE TABLE Menu (
  id_menu             NUMBER(3,0) NOT NULL,
  nazwa_menu          VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_Menu PRIMARY KEY (id_menu)
);

CREATE TABLE Typ_Dania (
  id_typ_dania        NUMBER(3,0) NOT NULL,
  nazwa_typu          VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_typ_dania PRIMARY KEY (id_typ_dania)
);

CREATE TABLE Dania (
  id_dania           NUMBER(3,0) NOT NULL,
  nazwa_dania         VARCHAR2(20) NOT NULL,
  cena                NUMBER(3,0) NOT NULL,
  id_menu             NUMBER(3,0) NOT NULL,
  id_typ_dania        NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_dania PRIMARY KEY (id_dania),
  CONSTRAINT fk_menuDan FOREIGN KEY (id_menu) REFERENCES Menu(id_menu),
  CONSTRAINT fk_typDan FOREIGN KEY (id_typ_dania) REFERENCES Typ_dania(id_typ_dania)
);

CREATE TABLE Dane_osobowe (
  id_danych           NUMBER(4,0) NOT NULL,
  imie                VARCHAR2(20) NOT NULL,
  nazwisko            VARCHAR2(20) NOT NULL,
  pesel               VARCHAR2(20) NOT NULL,
  nr_telefonu         VARCHAR2(15) NOT NULL,
  email               VARCHAR2(50) NOT NULL,
  CONSTRAINT pk_dane_osobowe PRIMARY KEY (id_danych)
);

CREATE TABLE Stanowiska (
  id_stanowiska       NUMBER(3,0) NOT NULL,
  nazwa_stanowiska    VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_stanowiska PRIMARY KEY (id_stanowiska)
);

CREATE TABLE Wyplata (
  id_wyplata          NUMBER(3,0) NOT NULL,
  kwota_brutto         VARCHAR2(20) NOT NULL,
  kwota_netto        VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_wyplata PRIMARY KEY (id_wyplata)
);

CREATE TABLE Model (
  id_modelu            NUMBER(3,0) NOT NULL,
  nazwa_modelu         VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_model PRIMARY KEY (id_modelu)
);

CREATE TABLE Marka (
  id_marki            NUMBER(3,0) NOT NULL,
  marka               VARCHAR2(20) NOT NULL,
  id_modelu           NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_marki PRIMARY KEY (id_marki),
  CONSTRAINT fk_modMar FOREIGN KEY (id_modelu) REFERENCES Model(id_modelu)
);

CREATE TABLE Samochod (
  id_samochodu        NUMBER(3,0) NOT NULL,
  nr_rej              VARCHAR2(20) NOT NULL,
  VIN                 VARCHAR2(20) NOT NULL,
  id_marki            NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_samochodu PRIMARY KEY (id_samochodu),
  CONSTRAINT fk_marSam FOREIGN KEY (id_marki) REFERENCES Marka(id_marki)
);

CREATE TABLE Faktura (
  id_faktury          NUMBER(4,0) NOT NULL,
  kwota_netto         VARCHAR2(20) NOT NULL,
  kwota_brutto        VARCHAR2(20) NOT NULL,
  data_wystawienia    DATE NOT NULL,
  termin_platnosci    DATE NOT NULL,
  CONSTRAINT pk_faktury PRIMARY KEY (id_faktury)
);

CREATE TABLE Restauracja (
  id_restauracji      NUMBER(3,0) NOT NULL,
  nr_telefonu         VARCHAR2(15) NOT NULL,
  nazwa_restauracji   VARCHAR2(20) NOT NULL,
  id_ulicy            NUMBER(3,0) NOT NULL,
  id_miasta           NUMBER(3,0) NOT NULL,
  id_menu             NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_restauracji PRIMARY KEY (id_restauracji),
  CONSTRAINT fk_miaRes FOREIGN KEY (id_miasta) REFERENCES Miasta(id_miasta),
  CONSTRAINT fk_ulRes FOREIGN KEY (id_ulicy) REFERENCES Ulica(id_ulicy),
  CONSTRAINT fk_menuRes FOREIGN KEY (id_menu) REFERENCES Menu(id_menu) 
);

CREATE TABLE Pracownik (
  id_pracownika       NUMBER(4,0) NOT NULL,
  id_stanowiska       NUMBER(3,0) NOT NULL,
  id_wyplata          NUMBER(3,0) NOT NULL,
  id_danych           NUMBER(4,0) NOT NULL,
  id_restauracji      NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_pracownik PRIMARY KEY (id_pracownika),
  CONSTRAINT fk_stanPrac FOREIGN KEY (id_stanowiska) REFERENCES Stanowiska(id_stanowiska),
  CONSTRAINT fk_wypPrac FOREIGN KEY (id_wyplata) REFERENCES Wyplata(id_wyplata),
  CONSTRAINT fk_danPrac FOREIGN KEY (id_danych) REFERENCES Dane_osobowe(id_danych),
  CONSTRAINT fk_resPrac FOREIGN KEY (id_restauracji) REFERENCES Restauracja(id_restauracji)
);

CREATE TABLE Kurier (
  id_kuriera          NUMBER(3,0) NOT NULL,
  id_pracownika       NUMBER(4,0) NOT NULL,
  id_samochodu        NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_kuriera PRIMARY KEY (id_kuriera),
  CONSTRAINT fk_pracKur FOREIGN KEY (id_pracownika) REFERENCES Pracownik(id_pracownika),
  CONSTRAINT fk_samKur FOREIGN KEY (id_samochodu) REFERENCES Samochod(id_samochodu)
);

CREATE TABLE Dostawca (
  id_dostawcy         NUMBER(3,0) NOT NULL,
  nazwa_firmy         VARCHAR2(20) NOT NULL,
  NIP                 NUMBER(15) NOT NULL,
  id_kuriera          NUMBER(3,0) NOT NULL,
  id_faktury          NUMBER(3,0) NOT NULL,
  id_ulicy            NUMBER(3,0) NOT NULL,
  id_miasta           NUMBER(3,0) NOT NULL,
  id_restauracji      NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_dostawcy PRIMARY KEY (id_dostawcy),
  CONSTRAINT fk_resDos FOREIGN KEY (id_restauracji) REFERENCES Restauracja(id_restauracji),
  CONSTRAINT fk_kurDos FOREIGN KEY (id_kuriera) REFERENCES Kurier(id_kuriera),
  CONSTRAINT fk_fakDos FOREIGN KEY (id_faktury) REFERENCES Faktura(id_faktury),
  CONSTRAINT fk_miaDos FOREIGN KEY (id_miasta) REFERENCES Miasta(id_miasta),
  CONSTRAINT fk_ulDos FOREIGN KEY (id_ulicy) REFERENCES Ulica(id_ulicy)
);

CREATE TABLE Typ_Produktu (
  id_typ_produktu     NUMBER(3,0) NOT NULL,
  nazwa_typu_produktu VARCHAR2(20) NOT NULL,
  CONSTRAINT pk_typ_produktu PRIMARY KEY (id_typ_produktu)
);

CREATE TABLE Produkt (
  id_produktu         NUMBER(4,0) NOT NULL,
  nazwa_produktu      VARCHAR2(20) NOT NULL,
  cena_produktu       NUMBER(3,0) NOT NULL,
  id_typ_produktu     NUMBER(3,0) NOT NULL,
  id_dostawcy         NUMBER(3,0) NOT NULL,
  CONSTRAINT pk_produktu PRIMARY KEY (id_produktu),
  CONSTRAINT fk_typProdukt FOREIGN KEY (id_typ_produktu) REFERENCES Typ_produktu(id_typ_produktu),
  CONSTRAINT fk_dosProdukt FOREIGN KEY (id_dostawcy) REFERENCES Dostawca(id_dostawcy)
);

CREATE TABLE Sprzedaz (
  id_sprzedaz         NUMBER(5,0) NOT NULL,
  id_restauracji      NUMBER(3,0) NOT NULL,
  id_pracownika       NUMBER(4,0) NOT NULL,
  id_dania            NUMBER(3,0) NOT NULL,
  data                DATE NOT NULL,
  CONSTRAINT pk_sprzedaz PRIMARY KEY (id_sprzedaz),
  CONSTRAINT fk_resSprzed FOREIGN KEY (id_restauracji) REFERENCES Restauracja(id_restauracji),
  CONSTRAINT fk_pracSprzed FOREIGN KEY (id_pracownika) REFERENCES Pracownik(id_pracownika),
  CONSTRAINT fk_daniaSprzed FOREIGN KEY (id_dania) REFERENCES Dania(id_dania)
);