







USE [clasesql]
GO

SELECT [ID_ENTIDAD]
      ,[ENTIDAD]
      ,[DISTRITO_FEDERAL]
      ,[Votos]
      ,[Fecha_Publicación]
  FROM [dbo].[votos]

GO

----------------------------------------------------USO DEL BETWEEN-----------------------------------------------------


------- Seleccionar valores distintivos -------

SELECT DISTINCT Fecha_Publicación
from dbo.votos 

------- Ocupando <= y >= -------

SELECT * 
FROM dbo.votos 
where ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
AND Fecha_Publicación >= '2024-06-05' AND 
Fecha_Publicación <= '2024-06-06'

------- Ocupando BETWEEN -------
------- FECHAS ------- 

SELECT * 
FROM dbo.votos 
where ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
AND Fecha_Publicación BETWEEN '2024-06-05' AND '2024-06-06'

------- NUMEROS ------- 

SELECT * 
FROM dbo.votos 
where ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
AND votos BETWEEN 180000 AND 200000


------- TEXTO ------- 

SELECT * 
FROM dbo.votos 
where  ENTIDAD BETWEEN 'CHIHUAHUA' AND 'HIDALGO'









------- COINCIDENCIAS CERCANAS ------------

-------- LIKE -------

-------- EN CUALQUIER PARTE -----------

SELECT * 
FROM dbo.votos 
where  DISTRITO_FEDERAL LIKE '%SANTIAGO%'

-------- AL INICIO -----------

SELECT * 
FROM dbo.votos 
where  DISTRITO_FEDERAL LIKE 'SAN%'

-------- AL FINAL -----------

SELECT * 
FROM dbo.votos 
where  DISTRITO_FEDERAL LIKE '%PAZ'





------------ MANEJO DE DATOS NULOS -----------------

------------ FILTRADO CON IS NULL ------------------

SELECT ENTIDAD, DISTRITO_FEDERAL as COLONIA, Votos
FROM dbo.votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE','DURANGO', 'GUANAJUATO','MICHOACÁN')
AND DISTRITO_FEDERAL IS NULL

------------ FILTRADO CON IS NOT NULL ------------------

SELECT ENTIDAD, DISTRITO_FEDERAL as COLONIA, Votos
FROM dbo.votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE','DURANGO', 'GUANAJUATO','MICHOACÁN')
AND DISTRITO_FEDERAL IS NOT NULL


------------ MODIFICACIÓN CON COALESCE ------------------

SELECT ENTIDAD, COALESCE(DISTRITO_FEDERAL, 'DISTRITO SIN NOMBRE'), Votos
FROM dbo.votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE','DURANGO', 'GUANAJUATO','MICHOACÁN')
AND DISTRITO_FEDERAL IS NULL



--------------------------------- ORDENADO CON ORDER BY ----------------------------------

SELECT * 
FROM dbo.votos 
ORDER BY ENTIDAD


------------------- USO DE ASC ------------------------

SELECT * 
FROM dbo.votos 
ORDER BY ENTIDAD ASC

------------------- USO DE DESC ------------------------

SELECT * 
FROM dbo.votos 
ORDER BY ENTIDAD DESC

------------------- ORDENADO CON NULOS ------------------------

SELECT * 
FROM dbo.votos 
ORDER BY DISTRITO_FEDERAL desc

------------------- ORDEN MULTIPLE ----------------------

SELECT * 
FROM dbo.votos 
ORDER BY Fecha_Publicación, ENTIDAD



SELECT * 
FROM dbo.votos
ORDER BY ENTIDAD 
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY



---------------------------- USO DE COUNT --------------------------------
SELECT * 
FROM dbo.votos 

---------------------------- COUNT TOTAL -----------------------------
SELECT COUNT (*)
FROM dbo.votos

SELECT COUNT (DISTRITO_FEDERAL)
FROM dbo.votos

---------------- RENOMBRANDO CON AS ----------------
SELECT COUNT(*) as Boletas_Totales
from dbo.votos 

---------------- OCUPANDO FILTROS ----------------
SELECT COUNT(Votos) as Boletas_Totales_Aguascalientes
from dbo.votos 
Where ENTIDAD = 'AGUASCALIENTES'


---------------- OCUPANDO FILTROS CON NULOS ----------------
SELECT COUNT(Votos) as Boletas_Totales_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL


SELECT COUNT(Votos) as Boletas_Totales_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE')






---------------------------- USO DE SUM --------------------------------
SELECT * 
FROM dbo.votos 

---------------------------- SUMA ERROR -----------------------------
SELECT SUM(ENTIDAD) as error
FROM dbo.votos

---------------------------- SUM TOTAL -----------------------------
SELECT SUM(Votos) 
FROM dbo.votos

---------------- RENOMBRANDO CON AS ----------------
SELECT SUM(Votos) as Suma_total_votos
from dbo.votos 

---------------- OCUPANDO FILTROS ----------------
SELECT SUM(Votos) as Suma_total_votos_Aguascalientes
from dbo.votos 
Where ENTIDAD = 'AGUASCALIENTES'


---------------- OCUPANDO FILTROS CON NULOS ----------------
SELECT SUM(Votos) as Suma_total_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL


SELECT SUM(Votos) as Suma_total_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE')




---------------------------- USO DE AVG --------------------------------
SELECT * 
FROM dbo.votos 

---------------------------- AVG TOTAL -----------------------------
SELECT AVG(Votos) 
FROM dbo.votos

---------------- RENOMBRANDO CON AS ----------------
SELECT AVG(Votos) as Promedio_total_votos
from dbo.votos 

---------------- OCUPANDO FILTROS ----------------
SELECT AVG(Votos) as Promedio_total_votos_Contenga_PAZ
from dbo.votos 
Where DISTRITO_FEDERAL LIKE '%PAZ%'


---------------- OCUPANDO FILTROS CON NULOS ----------------
SELECT AVG(Votos) as Promedio_total_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL


SELECT AVG(Votos) as Promedio_total_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE')


















---------------------------- USO DE MIN MAX -------------
-------------------
SELECT * 
FROM dbo.votos 


-----------------------------MIN MAX EN TEXTO -----------------------------------
SELECT MIN(DISTRITO_FEDERAL) , MAX(DISTRITO_FEDERAL)
FROM dbo.votos


---------------------------- MIN MAX TOTAL -----------------------------
SELECT MIN(Votos) , MAX(Votos)
FROM dbo.votos

---------------- RENOMBRANDO CON AS ----------------
SELECT MIN(Votos) as Minimo_Votos , MAX(Votos) as Maximo_votos
from dbo.votos 

---------------- OCUPANDO FILTROS ----------------
SELECT MIN(Votos) as Minimo_Votos_después_5_junio , MAX(Votos) as Maximo_votos_después_5_junio
from dbo.votos 
Where Fecha_Publicación >= '2024-06-06'


---------------- OCUPANDO FILTROS CON NULOS ----------------
SELECT MIN(Votos) as Minimo_Votos_Distritos_Sin_Nombre , MAX(Votos) as Maximo_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL


SELECT MIN(Votos) as Minimo_Votos_Distritos_Sin_Nombre , MAX(Votos) as Maximo_votos_Distritos_Sin_Nombre
from dbo.votos 
Where DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE')


SELECT ENTIDAD, MIN(Votos) as Minimo_Votos , AVG(votos) as Promedio_Votos
from dbo.votos 
group by ENTIDAD






-------------------- USO DE GROUP BY ------------------------------

Select * 
from votos

---------------- GROUP BY INDIVIDUAL ----------------
Select ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG(Votos) as Promedio_Votos, Min(Votos) as minimo_votos, Max (Votos) as maximo_votos 
from votos 
group  by ENTIDAD



---------------- GROUP BY MULTIPLE 1 ERROR ----------------
Select ENTIDAD, DISTRITO_FEDERAL, SUM(Votos) AS Suma_VOTOS, AVG(Votos) as Promedio_Votos, Min(Votos) as minimo_votos, Max (Votos) as maximo_votos 
from votos 
group  by ENTIDAD, DISTRITO_FEDERAL



---------------- GROUP BY MULTIPLE CORRECTO ----------------
Select Fecha_Publicación, ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG(Votos) as Promedio_Votos, Min(Votos) as minimo_votos, Max (Votos) as maximo_votos 
from votos 
group  by Fecha_Publicación, ENTIDAD



-------------------- USO DE HAVING ------------------------------

Select * 
from votos

---------------- HAVING INDIVIDUAL ----------------
Select ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG(Votos) as Promedio_Votos, Min(Votos) as minimo_votos, Max (Votos) as maximo_votos 
from votos 
group  by ENTIDAD
HAVING Sum(Votos) >1500000



---------------- HAVING MULTIPLE  ----------------
Select ENTIDAD, DISTRITO_FEDERAL, SUM(Votos) AS Suma_VOTOS, AVG(Votos) as Promedio_Votos, Min(Votos) as minimo_votos, Max (Votos) as maximo_votos 
from votos
WHERE ENTIDAD <> 'CIUDAD DE MÉXICO'
group  by ENTIDAD, DISTRITO_FEDERAL
HAVING MIN (Votos) > 250000



Select Fecha_Publicación, ENTIDAD, 
SUM(Votos) AS Suma_VOTOS,  ------ obtiene la suma ---------
AVG(Votos) as Promedio_Votos, ------ obtiene el promedio -------
Min(Votos) as minimo_votos, ------ obtiene el minimo -------
Max (Votos) as maximo_votos ------ obtiene el máximo -------
from votos 
group  by Fecha_Publicación, ENTIDAD
HAVING SUM(Votos) > 1500000 AND MIN (Votos) <> MAX(Votos) 










---------------- FUNCIONES DE FECHAS ----------------

---------------- GETDATE ----------------
SELECT GETDATE() as fecha_actual


---------------- GETDATE CONVERTIDO A FECHA SIN HORA----------------

SELECT CAST(GETDATE() AS DATE) as DIA

SELECT CAST(GETDATE() AS TIME) AS HORA


----------------- EJEMPLO FICTICIO DE QUERY DINAMICO ----------------
SELECT SUM(VENTAS) AS VENTA_TOTAL_DE_HOY
FROM VENTAS 
WHERE FECHA_VENTA = CAST(GETDATE() AS DATE)







---------------- AGRUPACIONES CON FECHAS  ----------------


select * 
from ventas

---------------- USO DE DATE_TRUNC ----------------

SELECT DATETRUNC(WEEK, FECHA_VENTA) AS MES, FECHA_VENTA
FROM ventas


---------------- AGRUPACIÓN DE PERIODOS DE TIEMPO ----------------

SELECT DATETRUNC(YEAR, FECHA_VENTA) AS ANYO, SUM(VENTAS) AS SUMA_VENTAS, AVG(VENTAS) AS PROM_VENTAS
FROM ventas
GROUP BY DATETRUNC(YEAR, FECHA_VENTA)
ORDER BY ANYO




---------------- FUNCIONES DE TEXTO  ----------------
select * 
from votos




---------------- USO DE CONCAT  ----------------
SELECT CONCAT(ENTIDAD,' ',Votos) AS ENTIDAD_COLONIA
FROM votos 


---------------- USO DE SUBSTRING  ----------------
SELECT SUBSTRING(ENTIDAD,6,10) AS PALABRA
FROM votos




---------------- USO DE LENGHT  ----------------
SELECT LEN(ENTIDAD) AS LARGO, ENTIDAD 
FROM votos 





---------------- AGRUPACIÓN DE PERIODOS DE TIEMPO ----------------

SELECT DATETRUNC(month, FECHA_VENTA) AS MES, AVG(VENTAS) AS PROM_VENTAS, 

ROUND(AVG(VENTAS),2) AS PROM_VENTAS_ROUND, 


FLOOR(AVG(VENTAS)) AS PROM_VENTAS_FLOOR,

CEILING(AVG(VENTAS)) AS PROM_VENTAS_CEILING


FROM ventas
GROUP BY DATETRUNC(month, FECHA_VENTA)
ORDER BY MES








SELECT * 
FROM metropolis

SELECT DISTRITO_FEDERAL AS COLONIA, DISTRITO_FEDERAL AS DISTRITO,VOTOS
FROM votos as T1 inner join metropolis as T2 
on T1.DISTRITO_FEDERAL = T2.NOM_MET


A
SELECT
FROM   JOIN 
WHERE     
GROUP BY 
HAVING 
ORDER BY 








------ USO DE LIMITES DE VISUALIZACIÓN -------

SELECT *
FROM votos
ORDER BY ENTIDAD, DISTRITO_FEDERAL
OFFSET 2 ROWS FETCH NEXT 10 ROWS ONLY;
			LIMIT


------ USO DE LIMITES DE VISUALIZACIÓN -------

SELECT *
FROM votos
ORDER BY ENTIDAD, DISTRITO_FEDERAL
LIMIT 10  OFFSET 0 ;