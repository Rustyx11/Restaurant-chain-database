1. Partycja pokazująca stosunek procentowy zarobionych pieniedzy przez restauracje w danym wojewodztwie
select
re.nazwa_restauracji,
wo.nazwa_woj "nazwa wojewodztwa",
suma1 "suma z sprzedazy dan przez restauracje",
suma2 "suma z sprzedazy dan na danym wojewodztwie",
udzial "udzial w %"
from
(
select sp.id_restauracji re_id, sp.id_wojewodztwa wo_id,
sum(da.cena) suma1,
sum(sum(da.cena)) over (partition by sp.id_wojewodztwa) suma2,
Round(100*sum(da.cena)/sum(sum(da.cena)) over (partition by sp.id_wojewodztwa)) udzial
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
group by sp.id_restauracji, sp.id_wojewodztwa
),
Hur_restauracja re,
Hur_wojewodztwa wo
where re.id_restauracji = re_id
and wo.id_wojewodztwa = wo_id;

2. Partycja pokazująca jaki wkład ma pracownik pracujący na stanowisku w wygenerowane przez wszystkich pracowników na tym stanowisku.

select
st.nazwa_stanowiska,
pr_id "id_pracownika",
imie,
nazwisko,
suma1 "suma z sprzedazy dan przez pracownika",
suma2 "suma z sprzedazy dan na danym stanowisku",
udzial "udzial w %"
from
(
select sp.id_stanowiska st_id, sp.id_pracownika pr_id,
sum(da.cena) suma1,
sum(sum(da.cena)) over (partition by sp.id_stanowiska) suma2,
Round(100*sum(da.cena)/sum(sum(da.cena)) over (partition by sp.id_stanowiska)) udzial
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
group by sp.id_stanowiska, sp.id_pracownika
),
Hur_stanowiska st,
Hur_pracownik pr
where st.id_stanowiska = st_id
and pr.id_pracownika = pr_id;

3. Partycja pokazująca stosunek sprzedanych dan danego typu do wszystkich sprzedanych dan tego typu

select
 td.nazwa_typu,
 da.nazwa_dania,
 count1 "suma ilosci kupionych dan danego typu",
 suma1 "suma wszystkich dan danego typu",
 udzial "udzial w %"
from
(
select sp.id_typ_dania td_id, sp.id_dania da_id,
count(*)count1,
sum(count(*)) over (partition by sp.id_typ_dania) suma1,
Round(100*count(*)/sum(count(*)) over (partition by sp.id_typ_dania)) udzial
from Hur_sprzedaz sp
group by sp.id_typ_dania, sp.id_dania
),
Hur_typ_dania td,
Hur_dania da
where td.id_typ_dania = td_id
and da.id_dania = da_id;