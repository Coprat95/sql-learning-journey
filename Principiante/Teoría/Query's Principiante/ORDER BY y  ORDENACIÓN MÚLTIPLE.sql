USE clasesql
GO

---------- ORDENADO CON ORDER BY ------   (valores nulos siempre se toman como primeros)-----

---------- ORDER BY ----------- quedan ordenado todo por el orden alfab�tico de las entidades (A-Z)

SELECT *
FROM dbo.votos
ORDER BY ENTIDAD 

---------- USO DE ASC ---------- se ordena por orden alfab�tico ascendente (A-Z)
SELECT * 
FROM dbo.votos
ORDER BY ENTIDAD ASC

---------- USO DE DESC --------- se ordena por orden descendente (Z-A)
SELECT * 
FROM dbo.votos
ORDER BY ENTIDAD DESC

---------- ORDENADO CON NULOS ---------- ( nulos aparecen los primeros)

SELECT * 
FROM dbo.votos
ORDER BY DISTRITO_FEDERAL ASC 

---------- ORDEN MULTIPLE --------  Primero se ordenan por la fecha de publicaci	
---------- En caso de coincidir la Fecha_Publicaci�n , se ordenan por orden alfab�tico de ENTIDAD
SELECT * 
FROM dbo.votos
ORDER BY Fecha_Publicacion, ENTIDAD
