-- Selecciona y formatea la jerarquía de géneros usando CASE
SELECT 
   CASE
       WHEN g1.nivel = 1 THEN CONCAT('📁 ', g1.nombre) -- Nivel 1: Género raíz (Música), se muestra con un emoji de carpeta
       WHEN g1.nivel = 2 THEN CONCAT('    ├── 📂 ', g1.nombre) -- Nivel 2: Géneros principales, se muestran con indentación y emoji de carpeta
       ELSE CONCAT('            ├── 🎵 ', g1.nombre)         -- Nivel 3: Subgéneros, se muestran con mayor indentación y emoji de nota musical
   END AS 'Jerarquía de Género',
   g1.nivel as 'Nivel'    -- Muestra el nivel numérico de cada género
-- Tabla principal de géneros
FROM Generos g1 -- Join con la misma tabla para establecer relaciones padre-hijo
LEFT JOIN Generos g2 ON g1.genero_padre_id = g2.genero_id -- Filtros para mostrar solo:
WHERE g1.nombre = 'Electrónica Latina'   -- El género específico que queremos ver
  OR g1.genero_padre_id IN (SELECT genero_id FROM Generos WHERE nombre = 'Electrónica Latina')  -- Sus subgéneros
  OR g1.nombre = 'Música'     -- El género raíz
ORDER BY g1.nivel, g1.nombre; -- Ordenamiento por nivel y nombre para mantener la jerarquía


SELECT * FROM GENEROS