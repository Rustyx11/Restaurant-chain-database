1. Okno pokazujące przyrost wraz z każdym zakupem w konkretniej restaruacji

select
data,
re.nazwa_restauracji,
cena,
suma
from
(
select data, sp.id_restauracji re_id, da.cena cena,
sum(da.cena) over(partition by sp.id_restauracji order by data range between unbounded preceding and current row) suma
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
),
Hur_restauracja re
where re.id_restauracji = re_id

2.Okno pokazujące przyrost generowany przez pracowników konkrentych stanowisk z sprzedaży

select
st.nazwa_stanowiska,
data,
suma
from
(
select data, sp.id_stanowiska st_id,
sum(da.cena) over(partition by sp.id_stanowiska order by data range between unbounded preceding and current row) suma
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
),
Hur_stanowiska st
where st.id_stanowiska = st_id;

3.Okno pokazujące przyrost kapitału w konkretnych wojewodztwach

select
wo.nazwa_woj,
data,
suma
from
(
select data, sp.id_wojewodztwa wo_id,
sum(da.cena) over(partition by sp.id_wojewodztwa order by data range between unbounded preceding and current row) suma
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
),
Hur_wojewodztwa wo
where wo.id_wojewodztwa = wo_id;