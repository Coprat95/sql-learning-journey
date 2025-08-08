

------------ USO DE MIN MAX EN TEXTO ------------ (mínimo y máximmo)
SELECT MIN (DISTRITO_FEDERAL) AS distrito_orden_asc , MAX (DISTRITO_FEDERAL) AS distrito_orden_desc
FROM dbo.votos     -- primero corre los números y luego las letras.  
				   -- correrá primero el 1000 que el 123 ya que el segundo digito 0, va antes que el 2. 

------------ MIN MAX TOTAL ----------
SELECT MIN (Votos) AS min_votos , MAX (Votos) AS max_votos
FROM dbo.votos

------------ USANDO FILTROS --------
SELECT MIN (Votos) AS min_votos_dsps_5_junio, MAX (Votos) AS max_votos_dsps_5_junio
FROM dbo.votos
WHERE Fecha_Publicacion >= '2024-06-05'

------------ FILTROS CON NULOS --------
SELECT MIN (Votos) AS min_votos , MAX (Votos) AS max_votos
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL


SELECT MIN (Votos) AS min_votos , MAX (Votos) AS max_votos
FROM dbo.votos
WHERE DISTRITO_FEDERAL IS NULL
AND ENTIDAD IN ('AGUASCALIENTES', 'BAJA CALIFORNIA', 'CAMPECHE')