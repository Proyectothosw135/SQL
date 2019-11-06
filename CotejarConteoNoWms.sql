use GPALL
SELECT CUSTNMBR,CUSTNAME,SOPNUMBE, (TB.MRKDNAMT/TB.UNITPRCE)*100 FROM (
select distinct CUSTNMBR,CUSTNAME,b.ITEMNMBR,b.quantity,b.TRDISAMT,b.MRKDNAMT,b.XTNDPRCE, b.UNITPRCE, B.UNITPRCE * B.QUANTITY PRECIO
,a.sopnumbe
from sop30200 a INNER JOIN sop30300 b ON a.sopnumbe = b.sopnumbe and a.soptype = b.soptype 
where a.soptype = 3
and ( b.TRDISAMT>0 or b.MRKDNAMT>0 )
--and a.SOPNUMBE like '%63440%'
--and b.QUANTITY > 1
and docdate >= '01/06/2017'
) AS TB
where custnmbr NOT IN 
(
'0503135022001',
'1003422647',
'0501809339001',
'1311024531001',
'1891768229001',
'0602199325',
'0501968499001',
'0911449882001',
'1204133548001',
'1790007502001',
'1891747337001',
'1891757995001',
'1891709346001',
'1891728804001',
'1704899481001',
'1801243898001',
'1803172269',
'1792652421001',
'1716825532',
'1715206056001',
'1708526536001',
'0911991263001',
'1720612173',
'1791240014001',
'0502909930',
'0201838224001',
'0990022453001',
'1792115841001',
'1708200413',
'1792065771001',
'1721140729001',
'0602246837',
'1716448095001',
'1704911088001',
'1711337103',
'0990085838001',
'1002773255001',
'1701340331',
'0991311637001',
'1791840933001',
'1792129052001',
'1600529224001',
'0922606561'
)
order by sopnumbe
