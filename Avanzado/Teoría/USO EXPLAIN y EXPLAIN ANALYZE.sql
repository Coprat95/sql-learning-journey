
-- 1 EXPLAIN Y ANALYZE BÁSICO . 
-- Explain: Estimacion que no realiza realmente la consulta, es + rápido  y menos preciso.
-- Explain analyze: Ejecuta realmente la consulta, muestra tiempos reales de ejecución pero tarda mas

-- SIN índice: EXPLAIN 

EXPLAIN SELECT *
		FROM canciones
        WHERE titulo ='Despacito';
        
/* 
id =1: Consulta simple sin subconsultas
selec_type = SIMPLE: Consulta sin uniones complejas
table =canciones 
partitions NULL
type = ref   : Hay una referencia gracias a un índice anterior
possible_keys y key  = idx_canciones_titulo   te dice el indice usado
key_len = longitud de clave qu emostrar
ref = const  . El motor sabe que es un valor constante en la consulta y sabe donde hallarlo 
rows=1   Solo ha necesitado examinar una fila para encontrar la consulta
filtered 100  , 100% de las filas examinadas son relevantes
extra = NULL, no necesita procesamiento adicional
*/

-- Tras ejecutar varios analyze, sacamos en conclusion que usando INDICES se optimiza mucho el rendimiento. 