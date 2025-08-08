-- TRANSACCIONES
SELECT * FROM clientes;
-- BEGIN/COMMIT (Confirmar cambios)
BEGIN Transaction;
INSERT INTO clientes (nombre,apellido,direccion,telefono) VALUES
('Oliver','Trave','calle Jaume Casanovas','689655555');

-- COMMIT;  Si le dieramos aqui se guardarían los cambios
-- ROLLBACK; Si le damos aquí volvemos a antes de insertar cliente nuevo

-- savepoint cl_1; punto de guardado

 INSERT INTO clientes ( nombre, apellido, direccion, telefono) VALUES
 ( 'Alicia','Baldan','calle Jaume Casanovas', '657071111');

-- ROLLBACK to savepoint cl_1;  Volver al punto de guardado cl_1 
-- Donde estaba creado Oliver pero no Alicia
--  release savepoint cl_1;   borramos punto de control cl_1
 -- si usamos ROLLBACK to savepoint cl_1 da ERROR ' no existe el savepoint'
 ROLLBACK; -- Finalmente no queremos guardar los clientes. 
 