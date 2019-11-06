
use GPCAL

select rtrim(itemnmbr),sum(quantity) from sop30200 a inner join sop30300 b on a.sopnumbe = b.sopnumbe and a.soptype = b.soptype
where a.soptype = 3 and b.soptype = 3
and year(docdate) = 2016 and month(docdate) = 12
and ORIGNUMB collate SQL_Latin1_General_CP1_CI_AS IN (select distinct BOZDD_NUMERODOCUMENTO from [192.168.0.220].BODEGAS_SCMIALVARADO.dbo.BO_ZDESPACHODETALLE_EXPORTACION where BOZDD_EXPORTAR = 2)
group by itemnmbr


select rtrim(itemnmbr),sum(quantity) from sop30200 a inner join sop30300 b on a.sopnumbe = b.sopnumbe and a.soptype = b.soptype
where a.soptype = 2 and b.soptype = 2
and year(docdate) = 2016 and month(docdate) = 12
and a.SOPNUMBE collate SQL_Latin1_General_CP1_CI_AS IN (select distinct BOZDD_NUMERODOCUMENTO from [192.168.0.220].BODEGAS_SCMIALVARADO.dbo.BO_ZDESPACHODETALLE_EXPORTACION where BOZDD_EXPORTAR = 2)
group by itemnmbr 

use BODEGAS_SCMIALVARADO

select BOZDD_CODIGOPRODUCTO as Articulo,SUM(BOZDD_CANTIDADPROCESADA) as Cantidad 
from BO_ZDESPACHODETALLE_EXPORTACION 
where BOZDD_NUMERODOCUMENTO collate Modern_Spanish_CI_AS IN (select sopnumbe from [192.168.0.246].gpcal.dbo.sop30200 where year(docdate) = 2016 and MONTH(docdate) = 12 )
and BOZDD_EXPORTAR = 2
group by BOZDD_CODIGOPRODUCTO
