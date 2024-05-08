1.Cube pokazuje nam sume dochodu ze sprzedazy dań w poszczególnych restauracjach

select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Zysk w restauracji' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN re.nazwa_restauracji IS NULL THEN 'Wszystkie restauracje' ELSE re.nazwa_restauracji END nazwa_resutaracji,
SUMA from (

select da.id_dania da_id, sp.id_restauracji re_id, SUM(da.cena) SUMA from Hur_sprzedaz sp,Hur_dania da where sp.id_dania = da.id_dania
GROUP BY CUBE(sp.id_restauracji, da.id_dania)
ORDER BY sp.id_restauracji, da.id_dania
), 
Hur_dania da,
Hur_restauracja re 
where da.id_dania (+)= da_id 
and re.id_restauracji (+)= re_id

2.Cube pokazujący ilosc sprzedach dan w poszczególnych wojewodztwach

select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Ilosc sprzedazy w danym wojewodztwie' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN wo.nazwa_woj IS NULL THEN 'Wszystkie wojewodztwa' ELSE wo.nazwa_woj END nazwa_wojewodztwa,
ilosc 
from (

select sp.id_dania da_id, sp.id_wojewodztwa wo_id, count(*) ilosc from Hur_sprzedaz sp
GROUP BY CUBE(sp.id_wojewodztwa, sp.id_dania)
ORDER BY sp.id_wojewodztwa, sp.id_dania
),
Hur_dania da,
Hur_wojewodztwa wo
where da.id_dania (+)= da_id
and wo.id_wojewodztwa (+)= wo_id;

3.Cube pokazuje sume dochodu z poszczegolnego stanowiska.

select 
CASE WHEN da.nazwa_dania IS NULL THEN 'Zysk z danego stanowiska' ELSE da.nazwa_dania END nazwa_dania,
CASE WHEN st.nazwa_stanowiska IS NULL THEN 'Wszystkie stanowiska' ELSE st.nazwa_stanowiska END nazwa_stanowiska,
SUMA from (

select sp.id_dania da_id, sp.id_stanowiska st_id, SUM(cena) SUMA from Hur_sprzedaz sp, Hur_dania da
where da.id_dania = sp.id_dania
GROUP BY CUBE(sp.id_stanowiska, sp.id_dania)
ORDER BY sp.id_stanowiska, sp.id_dania
),
Hur_dania da,
Hur_stanowiska st
where da.id_dania (+)= da_id
and st.id_stanowiska (+)= st_id;