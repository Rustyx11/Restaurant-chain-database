1. Ranking najbardziej sprzedawanego typu dania
select nazwa_typu, SUMA, ranking
from
(
select td.id_typ_dania td_id, count(*) SUMA, Rank() over(order by count(*)desc)ranking
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join typ_dania td on da.id_typ_dania = td.id_typ_dania
group by td.id_typ_dania
)
join typ_dania td
on td.id_typ_dania = td_id;

2. Ranking Pracowników pod względem zarobionego zysku
select
pr.id_pracownika, dos.imie, dos.nazwisko, zysk, ranking
from
(
select pr.id_pracownika pr_id, dos.id_danych dos_id, sum(da.cena) zysk,
Rank() over(order by sum(da.cena) desc) ranking
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join pracownik pr on sp.id_pracownika = pr.id_pracownika
join dane_osobowe dos on pr.id_danych = dos.id_danych
group by pr.id_pracownika, dos.id_danych
)
join pracownik pr
on pr.id_pracownika = pr_id
join dane_osobowe dos
on dos.id_danych = dos_id;

3.Ranking wojewodztw pod względem zarobionego zysku
select
woj.nazwa_woj, zysk, ranking
from
(
select woj.id_wojewodztwa woj_id, sum(da.cena) zysk,
Rank() over(order by sum(da.cena) desc) ranking
from sprzedaz sp
join dania da on sp.id_dania = da.id_dania
join restauracja re on sp.id_restauracji = re.id_restauracji
join miasta mi on re.id_miasta = mi.id_miasta
join wojewodztwa woj on mi.id_wojewodztwa = woj.id_wojewodztwa
group by woj.id_wojewodztwa
)
join wojewodztwa woj
on woj.id_wojewodztwa = woj_id;
