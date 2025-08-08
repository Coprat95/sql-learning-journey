USE clasesql
GO

------------- MANEJO DE DATOS NULOS ---------------

------------- FILTRADO CON IS NULL -------------
--- seleccionamos entidad distrito ( como colonia ) y votos de aquellas entidadades dentro de aguascalientes etc que
--- tengan como distrinto federal un valor nulo
SELECT ENTIDAD, DISTRITO_FEDERAL AS COLONIA , Votos
FROM dbo.votos
WHERE ENTIDAD IN ('AGUASCALIENTES' , 'CAMPECHE', 'DURANGO', 'GUANAJuATO', 'MICHOAC�N')
AND DISTRITO_FEDERAL IS NULL

------------- FILTRADO CON IS NOT NULL ------------
---- tengan como distrito federal un valor diferente de nulo 
SELECT ENTIDAD, DISTRITO_FEDERAL AS COLONIA , Votos
FROM dbo.votos
WHERE ENTIDAD IN ('AGUASCALIENTES' , 'CAMPECHE', 'DURANGO', 'GUANAJUATO', 'MICHOAC�N')
AND DISTRITO_FEDERAL IS NOT NULL

------------- MODIFICACI�N CON COALESCE -------------
----- lo que hace es asignar un valor a los valores nulos
----- despues de COALESCE ponemos (columnaquequeremos_modificar, 'valorquequeremos_introducir')
----- tenemos que renombrar si o s� con el AS  la columna , sino aparecer� la columna sin nombre. 
SELECT ENTIDAD, COALESCE (DISTRITO_FEDERAL , 'DISTRITO SIN NOMBRE') AS COLONIA, Votos
FROM dbo.votos
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE' , 'DURANGO', 'GUANAJUATO', 'MICHOAC�N')
AND DISTRITO_FEDERAL IS NULL
