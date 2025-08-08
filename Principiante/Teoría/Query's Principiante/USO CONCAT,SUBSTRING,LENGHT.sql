USE clasesql
GO


------------ FUNCIONES DE TEXTO---------
SELECT * 
FROM Votos

------------ USO DE CONCAT ------------
SELECT CONCAT(ENTIDAD,' ',DISTRITO_FEDERAL) AS ENTIDAD_COLONIA 
FROM Votos -- Junta las columnas ENTIDAD y DISTRITO_FEDERAL con un espacio entre medias y las renombra

------------ USO DE SUBSTRING ----------
SELECT SUBSTRING(ENTIDAD,6,10) AS PALABRA -- selecciona caracteres de aacuerdo a la posición que le indiquemos
FROM Votos		--ponemos SUBSTRING(nombre_columna + , + posición_inicial + , + nºde_caracteres_que_quieres)
				-- empieza por 1, no por 0 como en programación. 
				
------------ USO DE LENGHT ---------
SELECT LEN(ENTIDAD) AS LARGO, ENTIDAD --Largo de caracteres columna_entidad  + entidad
FROM Votos							  --LEN(nombre_columna) 