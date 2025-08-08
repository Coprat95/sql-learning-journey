-- USO DATE_FORMAT(das el formato que quieras a la fecha)   y EXTRACT(extraes el año , mes o dia de la fecha y te devuelve un número)

-- DATE_FORMAT 

-- Formatear fechas de diferentes maneras:
SELECT	
	fecha_lanzamiento,
    DATE_FORMAT(fecha_lanzamiento, '%d/%m/%y') AS fecha_española,  -- se ha de poner %d para que sepa que es dia
    DATE_FORMAT(fecha_lanzamiento, '%y%m%d') AS fecha_inglesa,	 -- a la inversa
    DATE_FORMAT(fecha_lanzamiento, '%d de %M de %Y') AS fecha_larga,	-- si pones mayuscula te pone el mes escrito  y año completo
    DATE_FORMAT(fecha_lanzamiento, '%d-%m-%y') AS fecha_corta -- cambiamos / por - 
    FROM Canciones;
    
-- Mostrar fechas y horas completas:
SELECT 	
	fecha_reproduccion,
    DATE_FORMAT(fecha_reproduccion, '%d/%m/%y %H/%i:%s' ) AS fecha_hora_completa,  -- se deja espacio entre fecha y horas 
																				  -- i(min) : segundos ( visual)
	DATE_FORMAT(fecha_reproduccion, '%H%p:%i') AS solo_hora  , -- solo hora.   el %H%p te pone la hora (AM o  PM) 
    DATE_FORMAT(fecha_reproduccion, '%W, %d %M %Y') AS fecha_con_dia   -- el %W , delante  te pone primero que dia de la semana es . 
    
FROM reproducciones