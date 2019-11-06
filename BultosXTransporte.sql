use BODEGAS_SCMIALVARADO

--COUNT(BOZDD_BULTO) as CantBulto 
select a.BOZDD_FECHASCMI,a.BOZRD_TRANSPORTE,a.BOZRD_TRANSPORTISTA,b.BODHA_NUMEROTRABAJOVOCOLLET,b.BODHA_CIUDAD,COUNT(BOZDD_BULTO) as CantBulto 
from BO_ZDESPACHODETALLE_EXPORTACION a with(nolock) INNER JOIN BO_DOCUMENTOHABILITANTE b with(nolock)
ON a.BOZDD_CODIGODOCUMENTO = b.BODHA_CODIGO
where BOZDD_FECHASCMI between '01/07/2017' and '31/07/2017'
and BOZDD_EXPORTAR = 2
group by BOZDD_FECHASCMI,BOZRD_TRANSPORTE,BOZRD_TRANSPORTISTA,b.BODHA_NUMEROTRABAJOVOCOLLET,b.BODHA_CIUDAD

select top 10 * from BO_ZDESPACHOCABECERA_EXPORTACION
where BOZDC_EXPORTAR = 2
and BOZDC_MUELLE <> ''

select top 10 * from BO_ZDESPACHODETALLE_EXPORTACION
where BOZDD_EXPORTAR = 2
and BOZDD_FECHASCMI between '01/07/2017' and '31/07/2017'

select top 10 * from BO_BULTOARMADO where BODHA_CODIGO = 'P-GPIAV-00088412D'


select top 10 * from BO_DOCUMENTOHABILITANTE
where BODHA_NUMERODOCUMENTO = 'P-GPIAV-00088412'