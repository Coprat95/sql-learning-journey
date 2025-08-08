-- Selección básica
USE clasesql;

SELECT ID_ENTIDAD, ENTIDAD, DISTRITO_FEDERAL, Votos, Fecha_Publicacion
FROM votos;

-- --------------------------- BETWEEN ---------------------------

-- Valores distintos
SELECT DISTINCT Fecha_Publicacion FROM votos;

-- Rango con <= y >=
SELECT * 
FROM votos 
WHERE ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
  AND Fecha_Publicacion >= '2024-06-05' 
  AND Fecha_Publicacion <= '2024-06-06';

-- BETWEEN (Fechas)
SELECT * 
FROM votos 
WHERE ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
  AND Fecha_Publicacion BETWEEN '2024-06-05' AND '2024-06-06';

-- BETWEEN (Números)
SELECT * 
FROM votos 
WHERE ENTIDAD IN ('NUEVO LEÓN', 'OAXACA', 'VERACRUZ')
  AND Votos BETWEEN 180000 AND 200000;

-- BETWEEN (Texto)
SELECT * 
FROM votos 
WHERE ENTIDAD BETWEEN 'CHIHUAHUA' AND 'HIDALGO';

-- --------------------------- LIKE ---------------------------

-- En cualquier parte
SELECT * 
FROM votos 
WHERE DISTRITO_FEDERAL LIKE '%SANTIAGO%';

-- Al inicio
SELECT * 
FROM votos 
WHERE DISTRITO_FEDERAL LIKE 'SAN%';

-- Al final
SELECT * 
FROM votos 
WHERE DISTRITO_FEDERAL LIKE '%PAZ';

-- ------------------ IS NULL y COALESCE -------------------

SELECT ENTIDAD, DISTRITO_FEDERAL AS COLONIA, Votos
FROM votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE', 'DURANGO', 'GUANAJUATO', 'MICHOACÁN')
  AND DISTRITO_FEDERAL IS NULL;

SELECT ENTIDAD, DISTRITO_FEDERAL AS COLONIA, Votos
FROM votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE', 'DURANGO', 'GUANAJUATO', 'MICHOACÁN')
  AND DISTRITO_FEDERAL IS NOT NULL;

SELECT ENTIDAD, COALESCE(DISTRITO_FEDERAL, 'DISTRITO SIN NOMBRE') AS COLONIA, Votos
FROM votos 
WHERE ENTIDAD IN ('AGUASCALIENTES', 'CAMPECHE', 'DURANGO', 'GUANAJUATO', 'MICHOACÁN')
  AND DISTRITO_FEDERAL IS NULL;

-- -------------------- ORDER BY --------------------

SELECT * FROM votos ORDER BY ENTIDAD;
SELECT * FROM votos ORDER BY ENTIDAD ASC;
SELECT * FROM votos ORDER BY ENTIDAD DESC;
SELECT * FROM votos ORDER BY DISTRITO_FEDERAL DESC;
SELECT * FROM votos ORDER BY Fecha_Publicacion, ENTIDAD;

-- Límite de visualización (MySQL usa LIMIT)
SELECT * 
FROM votos
ORDER BY ENTIDAD
LIMIT 3 OFFSET 0;

-- -------------------- COUNT --------------------

SELECT COUNT(*) FROM votos;
SELECT COUNT(DISTRITO_FEDERAL) FROM votos;
SELECT COUNT(*) AS Boletas_Totales FROM votos;

SELECT COUNT(Votos) AS Boletas_Totales_Aguascalientes
FROM votos 
WHERE ENTIDAD = 'AGUASCALIENTES';

SELECT COUNT(Votos) AS Boletas_Totales_Distritos_Sin_Nombre
FROM votos 
WHERE DISTRITO_FEDERAL IS NULL;

SELECT COUNT(Votos) AS Boletas_Totales_Distritos_Sin_Nombre
FROM votos 
WHERE DISTRITO_FEDERAL IS NULL
  AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE');

-- -------------------- SUM --------------------

SELECT SUM(Votos) AS Suma_total_votos FROM votos;

SELECT SUM(Votos) AS Suma_total_votos_Aguascalientes
FROM votos 
WHERE ENTIDAD = 'AGUASCALIENTES';

SELECT SUM(Votos) AS Suma_total_votos_Distritos_Sin_Nombre
FROM votos 
WHERE DISTRITO_FEDERAL IS NULL;

-- -------------------- AVG --------------------

SELECT AVG(Votos) AS Promedio_total_votos FROM votos;

SELECT AVG(Votos) AS Promedio_total_votos_Contenga_PAZ
FROM votos 
WHERE DISTRITO_FEDERAL LIKE '%PAZ%';

SELECT AVG(Votos) AS Promedio_total_votos_Distritos_Sin_Nombre
FROM votos 
WHERE DISTRITO_FEDERAL IS NULL
  AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE');

-- -------------------- MIN / MAX --------------------

SELECT MIN(DISTRITO_FEDERAL), MAX(DISTRITO_FEDERAL) FROM votos;
SELECT MIN(Votos), MAX(Votos) FROM votos;

SELECT MIN(Votos) AS Minimo_Votos, MAX(Votos) AS Maximo_votos FROM votos;

SELECT MIN(Votos) AS Minimo_Votos_después_5_junio, MAX(Votos) AS Maximo_votos_después_5_junio
FROM votos 
WHERE Fecha_Publicacion >= '2024-06-06';

SELECT ENTIDAD, MIN(Votos) AS Minimo_Votos, AVG(Votos) AS Promedio_Votos
FROM votos 
GROUP BY ENTIDAD;

-- -------------------- GROUP BY --------------------

SELECT ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG(Votos) AS Promedio_Votos,
       MIN(Votos) AS minimo_votos, MAX(Votos) AS maximo_votos
FROM votos 
GROUP BY ENTIDAD;

SELECT Fecha_Publicacion, ENTIDAD, 
       SUM(Votos) AS Suma_VOTOS, AVG(Votos) AS Promedio_Votos,
       MIN(Votos) AS minimo_votos, MAX(Votos) AS maximo_votos
FROM votos 
GROUP BY Fecha_Publicacion, ENTIDAD;

-- -------------------- HAVING --------------------

SELECT ENTIDAD, SUM(Votos) AS Suma_VOTOS, AVG(Votos) AS Promedio_Votos,
       MIN(Votos) AS minimo_votos, MAX(Votos) AS maximo_votos
FROM votos 
GROUP BY ENTIDAD
HAVING SUM(Votos) > 1500000;

-- -------------------- FUNCIONES DE FECHA --------------------

SELECT CURDATE() AS fecha_actual;
SELECT CURRENT_DATE() AS DIA;
SELECT CURRENT_TIME() AS HORA;

-- Consulta dinámica (ventas de hoy)
SELECT SUM(VENTAS) AS VENTA_TOTAL_DE_HOY
FROM ventas 
WHERE FECHA_VENTA = CURDATE();

-- ---------------- AGRUPACIÓN POR TIEMPO ------------------

SELECT DATE_FORMAT(FECHA_VENTA, '%Y-%m-01') AS MES, 
       AVG(VENTAS) AS PROM_VENTAS,
       ROUND(AVG(VENTAS), 2) AS PROM_VENTAS_ROUND,
       FLOOR(AVG(VENTAS)) AS PROM_VENTAS_FLOOR,
       CEIL(AVG(VENTAS)) AS PROM_VENTAS_CEILING
FROM ventas
GROUP BY MES
ORDER BY MES;

-- ---------------- FUNCIONES DE TEXTO ------------------

SELECT CONCAT(ENTIDAD, ' ', Votos) AS ENTIDAD_COLONIA FROM votos;

SELECT SUBSTRING(ENTIDAD, 6, 10) AS PALABRA FROM votos;

SELECT CHAR_LENGTH(ENTIDAD) AS LARGO, ENTIDAD FROM votos;

-- ---------------- JOIN (con tabla ficticia metropolis) ------------------

-- Asegúrate de que exista la tabla `metropolis` con la columna `NOM_MET`

SELECT T1.DISTRITO_FEDERAL AS COLONIA, T1.DISTRITO_FEDERAL AS DISTRITO, T1.VOTOS
FROM votos AS T1
INNER JOIN metropolis AS T2 ON T1.DISTRITO_FEDERAL = T2.NOM_MET;

-- ---------------- LIMIT ----------------

SELECT *
FROM votos
ORDER BY ENTIDAD, DISTRITO_FEDERAL
LIMIT 10 OFFSET 2;
