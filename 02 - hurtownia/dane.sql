INSERT /* +APPEND */ INTO Hur_Wojewodztwa (id_wojewodztwa, nazwa_woj)
SELECT * from Wojewodztwa;

INSERT /* +APPEND */ INTO Hur_Typ_Dania (id_typ_dania,nazwa_typu)
SELECT * from Typ_Dania;

INSERT  /* +APPEND*/ INTO Hur_Dania(id_dania, nazwa_dania, cena)
SELECT id_dania, nazwa_dania, cena from Dania;

INSERT  /* +APPEND*/ INTO Hur_Stanowiska(id_stanowiska, nazwa_stanowiska)
SELECT * from Stanowiska;

INSERT  /* +APPEND*/ INTO Hur_Pracownik(id_pracownika, imie, nazwisko)
SELECT p.id_pracownika, d.imie, d.nazwisko from Pracownik p, dane_osobowe d where p.id_danych = d.id_danych;

INSERT  /* +APPEND*/ INTO Hur_Restauracja(id_restauracji, nazwa_restauracji)
SELECT id_restauracji, nazwa_restauracji from Restauracja;

INSERT  /* +APPEND*/ INTO Hur_Sprzedaz(id_sprzedaz, id_restauracji, id_pracownika, id_stanowiska, id_dania, id_typ_dania, id_wojewodztwa, data)
SELECT sp.id_sprzedaz, sp.id_restauracji, sp.id_pracownika,p.id_stanowiska, sp.id_dania, da.id_typ_dania, mi.id_wojewodztwa, sp.data from Sprzedaz sp, Pracownik p, Dania da, Restauracja re, Miasta mi where sp.id_pracownika = p.id_pracownika 
and sp.id_dania = da.id_dania 
and re.id_restauracji = sp.id_restauracji 
and re.id_miasta = mi.id_miasta;