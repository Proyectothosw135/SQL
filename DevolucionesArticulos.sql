use BODEGAS_SCMIALVARADO

--5137
select tb3.*,quantity,e.UNITPRCE-e.MRKDNAMT-e.TRDISAMT as Precio,ltrim(rtrim(tb3.sopnumbe))+ltrim(rtrim(tb3.BOZRD_CODIGOPRODUCTO)) collate SQL_Latin1_General_CP1_CI_AS as codigo 
,(select z.STMTNAME from [192.168.0.222].gpiav.dbo.rm00101 z with(nolock) where z.custnmbr = tb3.custnmbr ) as RazonSocial
from (
select tb2.*,ORIGNUMB,SLPRSNID,CUSTNMBR,CUSTNAME from (
select tb1.*,SOPNUMBE,SOPTYPE from (
select BOZRD_CODIGOPRODUCTO,BOZRD_NUMERODOCUMENTO
,case when cast(BOZRD_NUMERODOCUMENTO as INT) < 5137 then SUM(BOZRD_CANTIDADPROCESADA+isnull(BOZRD_CANTIDADDANIADA,0)) else SUM(BOZRD_CANTIDADPROCESADA+isnull(BOZRD_CANTIDADDANIADASTOCK,0)) end as BOZRD_CANTIDADPROCESADA 
from BO_ZRECEPCIONDETALLE_EXPORTACION
where BOZRD_CODIGOBODEGA = '01'
and BOZRD_TIPODOCUMENTO = 'DV'
and len(BOZRD_NUMERODOCUMENTO) < 5
group by BOZRD_CODIGOPRODUCTO,BOZRD_NUMERODOCUMENTO
) as tb1  inner join [192.168.0.222].gpiav.dbo.SOP10106 c ON cast(tb1.BOZRD_NUMERODOCUMENTO as nvarchar(5)) COLLATE Modern_Spanish_CI_AS = c.USRTAB09
) as tb2 inner join [192.168.0.222].gpiav.dbo.sop30200 d ON d.sopnumbe =tb2.sopnumbe and  d.soptype = tb2.SOPTYPE
) as tb3 inner join [192.168.0.222].gpiav.dbo.sop30300 e ON e.sopnumbe = tb3.sopnumbe and e.soptype = tb3.soptype and e.itemnmbr COLLATE SQL_Latin1_General_CP1_CI_AS = tb3.BOZRD_CODIGOPRODUCTO
--where BOZRD_NUMERODOCUMENTO = '322'
where tb3.BOZRD_CANTIDADPROCESADA <> quantity
--and cast(BOZRD_NUMERODOCUMENTO as INT) > 5136
--AND TB3.SOPNUMBE = '001-003-000031097

/*
select top 10 * from BO_ZRECEPCIONDETALLE_EXPORTACION 
where BOZRD_CODIGOBODEGA = '01'
and BOZRD_TIPODOCUMENTO = 'DV'
and len(BOZRD_NUMERODOCUMENTO) < 5
and BOZRD_NUMERODOCUMENTO = '451'
*/