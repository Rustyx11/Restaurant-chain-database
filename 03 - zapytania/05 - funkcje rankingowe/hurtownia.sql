1. Ranking najbardziej sprzedawanego typu dania
select nazwa_typu, SUMA, ranking
from
(
select sp.id_typ_dania td_id, count(*) SUMA, Rank() over(order by count(*)desc)ranking
from Hur_sprzedaz sp
group by sp.id_typ_dania
),
Hur_typ_dania td
where td.id_typ_dania = td_id;

2. Ranking Pracowników pod względem zarobionego zysku
select
pr.id_pracownika, pr.imie, pr.nazwisko, zysk, ranking
from
(
select sp.id_pracownika pr_id, sum(da.cena) zysk,
Rank() over(order by sum(da.cena) desc) ranking
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
group by sp.id_pracownika
),
Hur_pracownik pr
where pr.id_pracownika = pr_id;

3.Ranking wojewodztw pod względem zarobionego zysku
select
woj.nazwa_woj, zysk, ranking
from
(
select sp.id_wojewodztwa woj_id, sum(da.cena) zysk,
Rank() over(order by sum(da.cena) desc) ranking
from Hur_sprzedaz sp, Hur_dania da
where sp.id_dania = da.id_dania
group by sp.id_wojewodztwa
),
Hur_wojewodztwa woj
where woj.id_wojewodztwa = woj_id;