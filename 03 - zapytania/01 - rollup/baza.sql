1.Rollup pokazuje nam sume dochodu ze sprzedazy dań w poszczególnych restauracjach

select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Zysk w restauracji' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN re.nazwa_restauracji IS NULL THEN 'Wszystkie restauracje' ELSE re.nazwa_restauracji END nazwa_resutaracji,
SUMA from (

select da.id_dania da_id, re.id_restauracji re_id, SUM(da.cena) SUMA from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on re.id_restauracji = sp.id_restauracji
GROUP BY ROLLUP(re.id_restauracji, da.id_dania)
ORDER BY re.id_restauracji, da.id_dania
)
left join dania da on da_id = da.id_dania
left join restauracja re on re_id = re.id_restauracji

2.Rollup pokazujący ilosc sprzedach dan w poszczególnych wojewodztwach

select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Ilosc sprzedazy w danym wojewodztwie' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN wo.nazwa_woj IS NULL THEN 'Wszystkie wojewodztwa' ELSE wo.nazwa_woj END nazwa_wojewodztwa,
ilosc 
from (

select da.id_dania da_id, wo.id_wojewodztwa wo_id, count(*) ilosc from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on re.id_restauracji = sp.id_restauracji
join miasta mi on mi.id_miasta = re.id_miasta
join wojewodztwa wo on wo.id_wojewodztwa = mi.id_wojewodztwa
GROUP BY ROLLUP(wo.id_wojewodztwa, da.id_dania)
ORDER BY wo.id_wojewodztwa, da.id_dania
)
left join dania da on da_id = da.id_dania
left join wojewodztwa wo on wo_id = wo.id_wojewodztwa

3.Rollup pokazuje sume dochodu z poszczegolnego stanowiska.
select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Zysk z danego stanowiska' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN st.nazwa_stanowiska IS NULL THEN 'Wszystkie stanowiska' ELSE st.nazwa_stanowiska END nazwa_stanowiska,
SUMA from (

select da.id_dania da_id, st.id_stanowiska st_id, SUM(da.cena) SUMA from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join pracownik pr on pr.id_pracownika = sp.id_pracownika
join stanowiska st on st.id_stanowiska = pr.id_stanowiska
GROUP BY ROLLUP(st.id_stanowiska, da.id_dania)
ORDER BY st.id_stanowiska, da.id_dania
)
left join dania da on da_id = da.id_dania
left join stanowiska st on st.id_stanowiska = st_id;