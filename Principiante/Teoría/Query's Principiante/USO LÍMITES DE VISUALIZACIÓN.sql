USE clasesql
GO

----------  USO DE L�MITES DE VISUALIZACI�N ----------  SSMS Y ORACLE
----- solo queremos que nos muestre las primeras 10 filas. 
----- OFFSET ( desde que fila) 0    ROWS FETCH NEXT (cantidad de filas que queremos ver )  10  ROWS ONLY; ( para visualizar dichas filas)
SELECT * 
FROM votos
ORDER BY ENTIDAD, DISTRITO_FEDERAL
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;


---------- USO  DE L�MITES DE VISUALIZACI�N ------------ mySql y PostreSQL

SELECT * 
FROM votos
ORDER BY ENTIDAD, DISTRITO_FEDERAL
LIMIT 10 OFFSET 0;