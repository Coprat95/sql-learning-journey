
-- DATEDIFF diferencia( en días por defecto) entre dos fechas .    DATEDIFF( 4 de agosto y 7 de agosto ) = 3.
-- Antigüedad de canciones

SELECT
titulo AS cancion,
ROUND(DATEDIFF(CURRENT_DATE(), fecha_lanzamiento) / 365, 1)  AS Antigüedad_cancion_años  -- CURRENT_DATE , FECHA ACTUAL
FROM canciones
ORDER BY Antigüedad_cancion_años
;

-- Antigüedad de usuarios:

SELECT
	nombre,
    fecha_registro,
    DATEDIFF(CURRENT_DATE(), fecha_registro )  AS Dias_registrados,
    ROUND(DATEDIFF(CURRENT_DATE(), fecha_registro) / 30 ,1) AS Meses_registrados,
    ROUND(DATEDIFF(CURRENT_DATE(), fecha_registro) / 360 , 1) AS Años_registrados
    FROM usuarios
    ORDER BY fecha_registro ASC;
    
-- DATEADD() Añadir fecha a una fecha ya existente

-- Calculame el aniversario de semana mes y año de una fecha de registro

SELECT 
	usuario_id,
    nombre,
    fecha_registro,
    DATE_ADD(fecha_registro, INTERVAL 1 WEEK) AS Aniversario_semana,
    DATE_ADD(fecha_registro, INTERVAL 1 MONTH) AS Aniversario_mes,
	DATE_ADD(fecha_registro, INTERVAL 1 YEAR) AS Aniversario_año
    FROM usuarios
    ORDER BY fecha_registro;

-- __________________________________________________________________
-- 🎯 Análisis de retención de usuarios usando DATE_ADD y DATEDIFF

SELECT
  u.nombre,  -- 🧍 Nombre del usuario
  u.fecha_registro,  -- 📅 Fecha en que el usuario se registró

  DATE_ADD(u.fecha_registro, INTERVAL 1 YEAR) AS fecha_aniversario,  
  -- 🎉 Calcula la fecha en que el usuario cumple 1 año en la plataforma

  DATEDIFF(CURRENT_DATE, u.fecha_registro) AS dias_como_usuario,  
  -- ⏳ Días que han pasado desde que el usuario se registró (antigüedad)

  -- 🪪 Clasificación del usuario según su antigüedad
  CASE
    WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 100 THEN 'Usuario nuevo'
    WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 900 THEN 'Usuario regular'
    WHEN DATEDIFF(CURRENT_DATE, u.fecha_registro) < 1600 THEN 'Usuario establecido'
    ELSE 'Usuario veterano'
  END AS categoria_usuario,

  DATEDIFF(CURRENT_DATE, r.ultima_reproduccion) AS dias_desde_ultima_reproduccion,
  -- 🎧 Días que han pasado desde la última vez que el usuario escuchó música

  -- 🚦 Clasificación del usuario según actividad reciente
  CASE
    WHEN DATEDIFF(CURRENT_DATE, r.ultima_reproduccion) <= 70 THEN 'Usuario activo'
    WHEN DATEDIFF(CURRENT_DATE, r.ultima_reproduccion) <= 400 THEN 'Usuario semi-activo'
    ELSE 'Usuario inactivo'
  END AS estado_actividad

FROM usuarios u
-- 🔗 Vinculamos cada usuario con la fecha de su última reproducción
LEFT JOIN (
  SELECT 
    usuario_id, 
    MAX(fecha_reproduccion) AS ultima_reproduccion  -- ⏰ Última reproducción de cada usuario
  FROM reproducciones
  GROUP BY usuario_id
) r ON u.usuario_id = r.usuario_id;
