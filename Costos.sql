USE BODEGAS_SCMIALVARADO
 

select Articulo,Descripcion,Marca,CantidadWMS,CantidadGP,CantidadWMS-CantidadGP as DiferenciaCantidad,
(select currcost from [192.168.0.222].GPIAV.dbo.iv00101 where itemnmbr COLLATE SQL_Latin1_General_CP1_CI_AS= Articulo)*CantidadWMS AS CostoWMS,
(select currcost from [192.168.0.222].GPIAV.dbo.iv00101 where itemnmbr COLLATE SQL_Latin1_General_CP1_CI_AS= Articulo)*CantidadGP AS CostoGP,
(select currcost from [192.168.0.222].GPIAV.dbo.iv00101 where itemnmbr COLLATE SQL_Latin1_General_CP1_CI_AS= Articulo)*CantidadWMS -
(select currcost from [192.168.0.222].GPIAV.dbo.iv00101 where itemnmbr COLLATE SQL_Latin1_General_CP1_CI_AS= Articulo)*CantidadGP AS DifenciaCosto
from (
SELECT SUBSTRING(a.BOPRO_CODIGO,1,14) AS Articulo
,(SELECT z.BOPRO_DESCRIPCION FROM BO_PRODUCTO z WHERE z.BOPRO_CODIGO = a.BOPRO_CODIGO AND BOPRO_CODIGOBODEGA = '01') AS Descripcion
,(SELECT z.BOMAR_CODIGO FROM BO_PRODUCTO z WHERE z.BOPRO_CODIGO = a.BOPRO_CODIGO AND BOPRO_CODIGOBODEGA = '01') AS Marca
,SUM(a.BOAUB_CANTIDAD) AS CantidadWMS, b.QTYONHND AS CantidadGP
FROM BO_ASIGNACIONUBICACION a INNER JOIN [192.168.0.222].GPIAV.dbo.IV00102 b 
ON SUBSTRING(a.BOPRO_CODIGO,1,14) COLLATE Modern_Spanish_CI_AS = b.ITEMNMBR
WHERE a.BOAUB_TIPOPROCESO = 'Despacho'
AND a.BOBOD_BODEGADESTINO = '01'
AND b.LOCNCODE = 'MATRIZ'
GROUP BY a.BOPRO_CODIGO,b.QTYONHND 
) as tb2
where CantidadWMS-CantidadGP > 0