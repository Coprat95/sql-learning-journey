USE clasesql
GO

--------------- COINCIDENCIAS CERCANAS -------------

--------------- LIKE --------------------
/*
Al principio :		    SAN%      -> SAN LUIS DE LA PAZ
Al final :				%PAZ      -> SAN LUIS DE LA PAZ
En cualquier parte :    %DE LA%   -> SAN LUIS DE LA PAZ
*/


--------------- EN CUALQUIER PARTE --------------

SELECT * 
FROM dbo.votos
WHERE DISTRITO_FEDERAL LIKE '%SANTIAGO%'

--------------- AL INICIO -----------------
SELECT *
FROM dbo.votos
WHERE DISTRITO_FEDERAL LIKE 'SAN%'

--------------- AL FINAL ----------------------
SELECT * 
FROM dbo.votos 
WHERE DISTRITO_FEDERAL LIKE '%PAZ' 

