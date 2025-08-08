

------------ AGRUPACIONES CON FECHAS ---------

SELECT* 
FROM Ventas

------------ USO DE DATE_TRUNC -----------

SELECT DATETRUNC(MONTH, FECHA_VENTA) AS MES , FECHA_VENTA  --truncar una fecha o marca de tiempo a una parte especificada 
														   --( mes año trimestre etc)
															--datetrunc(+palabra de fecha de tiempo que queremos , en este caso MONTH)
															-- Puede ser YEAR, MONTH, WEEK, DAY...
FROM Ventas									  

------------ AGRUPACIÓN DE PERIODOS DE TIEMPO -----------

SELECT DATETRUNC(MONTH, FECHA_VENTA) AS MES , SUM(VENTAS) AS SUMA_VENTAS, AVG(VENTAS) AS PROM_VENTAS
FROM ventas
GROUP BY DATETRUNC(MONTH , FECHA_VENTA) -- tenemos que repetirlo entero el trunc porque el group corre antes que el select y no da tiempo
										-- a que se renombre
ORDER BY MES							--  order by sí que va después de SELECT y por eso SI que lo lee como MES 