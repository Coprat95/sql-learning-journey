

---------- AGRUPACIÓN DE PERIODOS DE TIEMPO----------
---------- ROUND , FLOOR Y CEILING-------------------	
--ROUND: Nos permite escoger nº de decimales a  los que queremos redondear
--FLOOR: Redondea hacia abajo, sin importar decimales
--CEILING: Redondea hacia arriba, sin importar decimales


-- en este ejemplo agrupamos el promedio de las ventas por mes : 

SELECT DATETRUNC(MONTH, FECHA_VENTA) AS MES, 

AVG(VENTAS) AS PROM_VENTAS,						--promedio de ventas

ROUND(AVG(VENTAS),2) AS PROM_VENTAS_ROUND,		--promedio de ventas redondeado a 2 decimales

FLOOR(AVG(VENTAS)) AS PROM_VENTAS_FLOOR,		--promedio de ventas redondeado hacia abajo (el decimal)

CEILING(AVG(VENTAS)) AS PROM_VENTAS_CEILING		--promedio de ventas redondeado hacia arriba (el decimal)

FROM Ventas
GROUP BY DATETRUNC(MONTH, FECHA_VENTA)
ORDER BY MES 



SELECT DATETRUNC(MONTH, FECHA_VENTA) AS MES ,
AVG(VENTAS) AS PROM_VENTAS,
ROUND(AVG(VENTAS),2) AS PROM_VENTAS_ROUND,
FLOOR(AVG(VENTAS)) AS PROM_VENTAS_FLOOR,
CEILING(AVG(VENTAS)) AS PROM_VENTAS_CEILING
FROM Ventas
GROUP BY DATETRUNC(MONTH, FECHA_VENTA)
ORDER BY MES
