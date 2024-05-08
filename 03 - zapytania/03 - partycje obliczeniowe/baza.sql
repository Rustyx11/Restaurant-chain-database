1. Partycja pokazująca stosunek procentowy zarobionych pieniedzy przez restauracje w danym wojewodztwie
select
re.nazwa_restauracji,
wo.nazwa_woj "nazwa wojewodztwa",
suma1 "suma z sprzedazy dan przez restauracje",
suma2 "suma z sprzedazy dan na danym wojewodztwie",
udzial "udzial w %"
from
(
select re.id_restauracji re_id, wo.id_wojewodztwa wo_id,
sum(da.cena) suma1,
sum(sum(da.cena)) over (partition by wo.id_wojewodztwa) suma2,
Round(100*sum(da.cena)/sum(sum(da.cena)) over (partition by wo.id_wojewodztwa)) udzial
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on sp.id_restauracji = re.id_restauracji
join miasta mi on re.id_miasta = mi.id_miasta
join wojewodztwa wo on mi.id_wojewodztwa = wo.id_wojewodztwa
group by re.id_restauracji, wo.id_wojewodztwa
)
join restauracja re
on re.id_restauracji = re_id
join wojewodztwa wo
on wo.id_wojewodztwa = wo_id;

2. Partycja pokazująca jaki wkład ma pracownik pracujący na stanowisku w wygenerowane przez wszystkich pracowników na tym stanowisku.
select
st.nazwa_stanowiska,
pr_id "id_pracownika",
dos.imie,
dos.nazwisko,
suma1 "suma z sprzedazy dan przez pracownika",
suma2 "suma z sprzedazy dan na danym stanowisku",
udzial "udzial w %"
from
(
select st.id_stanowiska st_id, pr.id_pracownika pr_id, dos.id_danych dos_id,
sum(da.cena) suma1,
sum(sum(da.cena)) over (partition by st.id_stanowiska) suma2,
Round(100*sum(da.cena)/sum(sum(da.cena)) over (partition by st.id_stanowiska)) udzial
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join pracownik pr on sp.id_pracownika = pr.id_pracownika
join stanowiska st on pr.id_stanowiska = st.id_stanowiska
join dane_osobowe dos on pr.id_danych = dos.id_danych
group by st.id_stanowiska, pr.id_pracownika, dos.id_danych
)
join stanowiska st
on st.id_stanowiska = st_id
join pracownik pr
on pr.id_pracownika = pr_id
join dane_osobowe dos
on dos.id_danych = dos_id;

3. Partycja pokazująca stosunek sprzedanych dan danego typu do wszystkich sprzedanych dan tego typu
select
 td.nazwa_typu,
 da.nazwa_dania,
 count1 "suma ilosci kupionych dan danego typu",
 suma1 "suma wszystkich dan danego typu",
 udzial "udzial w %"
from
(
select td.id_typ_dania td_id, da.id_dania da_id,
count(*)count1,
sum(count(*)) over (partition by td.id_typ_dania) suma1,
Round(100*count(*)/sum(count(*)) over (partition by td.id_typ_dania)) udzial
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join typ_dania td on da.id_typ_dania = td.id_typ_dania
group by td.id_typ_dania, da.id_dania
)
join typ_dania td
on td.id_typ_dania = td_id
join dania da
on da.id_dania = da_id;