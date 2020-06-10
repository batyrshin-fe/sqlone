with smain as (select дата, цена, rownum as lvl from (select дата, цена from prices order by дата)),
sa as (SELECT case when (lvl in (select max(lvl) from smain)) then null else дата end AS "Ќачало спада", rownum as rwn
from smain outer
WHERE ((lvl = 1 AND цена>(select цена from smain where lvl=outer.lvl+1))
OR (цена>(select цена from smain where lvl=outer.lvl-1) AND цена>(select цена from smain where lvl=outer.lvl+1))
OR (цена=(select цена from smain where lvl=outer.lvl-1) AND цена>(select цена from smain where lvl=outer.lvl+1))or lvl in (select max(lvl) from smain))),
sb as (SELECT case when (lvl in (select min(lvl) from smain)) then null else дата end AS "ќкончание спада", rownum as rwn
from smain outer
WHERE ((цена<(select цена from smain where lvl=outer.lvl-1) AND lvl in (select max(lvl) from smain))
OR (цена<(select цена from smain where lvl=outer.lvl-1) AND цена<(select цена from smain where lvl=outer.lvl+1))
OR (цена<(select цена from smain where lvl=outer.lvl-1) AND цена=(select цена from smain where lvl=outer.lvl+1))or lvl in (select min(lvl) from smain))),
sc as (SELECT case when (lvl in (select max(lvl) from smain)) then null else дата end AS "Ќачало роста", rownum as rwn
from smain outer
WHERE ((lvl = 1 AND цена<(select цена from smain where lvl=outer.lvl+1))
OR (цена<(select цена from smain where lvl=outer.lvl-1) AND цена<(select цена from smain where lvl=outer.lvl+1))
OR (цена=(select цена from smain where lvl=outer.lvl-1) AND цена<(select цена from smain where lvl=outer.lvl+1))or lvl in (select max(lvl) from smain))),
sd as (SELECT case when (lvl in (select min(lvl) from smain)) then null else дата end AS "ќкончание роста", rownum as rwn
from smain outer
WHERE ((цена>(select цена from smain where lvl=outer.lvl-1) AND lvl in (select max(lvl) from smain))
OR (цена>(select цена from smain where lvl=outer.lvl-1) AND цена>(select цена from smain where lvl=outer.lvl+1))
OR (цена>(select цена from smain where lvl=outer.lvl-1) AND цена=(select цена from smain where lvl=outer.lvl+1))or lvl in (select min(lvl) from smain)))
SELECT sa."Ќачало спада", sb."ќкончание спада", sc."Ќачало роста", sd."ќкончание роста"
from sa, sb, sc, sd where (sa.rwn = (sb.rwn - 1) and (sb.rwn - 1) = sc.rwn and sc.rwn = (sd.rwn - 1)) 
    or (sa.rwn = (sb.rwn - 1) and (sb.rwn - 1) = sc.rwn and sd.rwn=1 and sc."Ќачало роста" is null) 
    or (sc.rwn = (sd.rwn - 1) and (sd.rwn - 1) = sa.rwn and sb.rwn=1 and sa."Ќачало спада" is null);