with smain as (select ����, ����, rownum as lvl from (select ����, ���� from prices order by ����)),
sa as (SELECT case when (lvl in (select max(lvl) from smain)) then null else ���� end AS "������ �����", rownum as rwn
from smain outer
WHERE ((lvl = 1 AND ����>(select ���� from smain where lvl=outer.lvl+1))
OR (����>(select ���� from smain where lvl=outer.lvl-1) AND ����>(select ���� from smain where lvl=outer.lvl+1))
OR (����=(select ���� from smain where lvl=outer.lvl-1) AND ����>(select ���� from smain where lvl=outer.lvl+1))or lvl in (select max(lvl) from smain))),
sb as (SELECT case when (lvl in (select min(lvl) from smain)) then null else ���� end AS "��������� �����", rownum as rwn
from smain outer
WHERE ((����<(select ���� from smain where lvl=outer.lvl-1) AND lvl in (select max(lvl) from smain))
OR (����<(select ���� from smain where lvl=outer.lvl-1) AND ����<(select ���� from smain where lvl=outer.lvl+1))
OR (����<(select ���� from smain where lvl=outer.lvl-1) AND ����=(select ���� from smain where lvl=outer.lvl+1))or lvl in (select min(lvl) from smain))),
sc as (SELECT case when (lvl in (select max(lvl) from smain)) then null else ���� end AS "������ �����", rownum as rwn
from smain outer
WHERE ((lvl = 1 AND ����<(select ���� from smain where lvl=outer.lvl+1))
OR (����<(select ���� from smain where lvl=outer.lvl-1) AND ����<(select ���� from smain where lvl=outer.lvl+1))
OR (����=(select ���� from smain where lvl=outer.lvl-1) AND ����<(select ���� from smain where lvl=outer.lvl+1))or lvl in (select max(lvl) from smain))),
sd as (SELECT case when (lvl in (select min(lvl) from smain)) then null else ���� end AS "��������� �����", rownum as rwn
from smain outer
WHERE ((����>(select ���� from smain where lvl=outer.lvl-1) AND lvl in (select max(lvl) from smain))
OR (����>(select ���� from smain where lvl=outer.lvl-1) AND ����>(select ���� from smain where lvl=outer.lvl+1))
OR (����>(select ���� from smain where lvl=outer.lvl-1) AND ����=(select ���� from smain where lvl=outer.lvl+1))or lvl in (select min(lvl) from smain)))
SELECT sa."������ �����", sb."��������� �����", sc."������ �����", sd."��������� �����"
from sa, sb, sc, sd where (sa.rwn = (sb.rwn - 1) and (sb.rwn - 1) = sc.rwn and sc.rwn = (sd.rwn - 1)) 
    or (sa.rwn = (sb.rwn - 1) and (sb.rwn - 1) = sc.rwn and sd.rwn=1 and sc."������ �����" is null) 
    or (sc.rwn = (sd.rwn - 1) and (sd.rwn - 1) = sa.rwn and sb.rwn=1 and sa."������ �����" is null);