1. Okno pokazujące przyrost wraz z każdym zakupem w konkretniej restaruacji
select
data,
re.nazwa_restauracji,
cena,
suma
from
(
select sp.data data, re.id_restauracji re_id, da.cena cena,
sum(da.cena) over(partition by re.id_restauracji order by data range between unbounded preceding and current row) suma
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on sp.id_restauracji = re.id_restauracji
)
join restauracja re
on re.id_restauracji = re_id;

2.Okno pokazujące przyrost generowany przez pracowników konkrentych stanowisk z sprzedaży
select
st.nazwa_stanowiska,
data,
suma
from
(
select sp.data data, st.id_stanowiska st_id,
sum(da.cena) over(partition by st.id_stanowiska order by data range between unbounded preceding and current row) suma
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join pracownik pr on sp.id_pracownika = pr.id_pracownika
join stanowiska st on pr.id_stanowiska = st.id_stanowiska
)
join stanowiska st
on st.id_stanowiska = st_id;

3.Okno pokazujące przyrost kapitału w konkretnych wojewodztwach
select
wo.nazwa_woj,
data,
suma
from
(
select sp.data data, wo.id_wojewodztwa wo_id,
sum(da.cena) over(partition by wo.id_wojewodztwa order by data range between unbounded preceding and current row) suma
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on sp.id_restauracji =  re.id_restauracji
join miasta mi on re.id_miasta = mi.id_miasta
join wojewodztwa wo on mi.id_wojewodztwa = wo.id_wojewodztwa
)
join wojewodztwa wo
on wo.id_wojewodztwa = wo_id;