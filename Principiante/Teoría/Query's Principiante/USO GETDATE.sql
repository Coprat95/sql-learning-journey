
-------------- FUNCIONES DE FECHAS -----------
SELECT GETDATE()  -- muestra fecha y hora (minuto,segundo)   2025-07-22  11:45:11.003

SELECT GETDATE() as fecha_actual -- renombramos como fecha actual

------------- GETDATE CONVERTIDO A FECHA SIN HORA ---------
SELECT CAST(GETDATE() AS DATE)	AS DIA				 --cast seguido de tipo de dato o columna que queremos cambiar a otro 
													 -- cambia la fecha con hora/min/seg  a formato fecha  aaaa/mm/dd

SELECT CAST(GETDATE() AS TIME)	AS HORA				 -- cambia a formato hora  hora/min/seg	

------------- EJEMPLO FICTICIO DE QUERY DINAMICO ----------

SELECT SUM(VENTAS) AS VENTA_TOTAL_DE_HOY			-- haría una suma de todas las ventas en el día de hoy
FROM VENTAS
WHERE FECHA_VENTA = CAST(GETDATE() AS DATE)

