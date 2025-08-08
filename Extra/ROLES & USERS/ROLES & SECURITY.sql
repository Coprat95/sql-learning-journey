/* ---------ROLES Y SEGURIDAD ---------------
Roles y seguridad en bases de datos sirven para:
- Decidir quién puede ver o cambiar datos.
- Proteger información importante.
- Evitar errores o daños accidentales.
- Facilitar dar permisos a grupos de usuarios.
- Cumplir con reglas y controles de seguridad.
*/

--1. Crear Roles contedores:
	CREATE ROLE vendedor NOLOGIN;
	CREATE ROLE admin NOLOGIN;
--2. Crear cuentas de acceso:
	CREATE USER juan PASSWORD 'juan1234';
	CREATE USER maria PASSWORD 'maria1234';
--3. Asignar roles a usuarios;
	GRANT vendedor TO juan;
	GRANT admin to maria;
--4. Revocar permisos de PUBLIC(recomendado/optativo)
	REVOKE ALL ON SCHEMA public FROM PUBLIC;
	REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
--5. Conceder USAGE Sobre el Schema (permiso para usar schema , referenciarlo etc)
	GRANT USAGE ON SCHEMA public TO vendedor, admin;
--6. Conceder permisos al rol vendedor:
	GRANT SELECT
	ON productos
	TO vendedor;			-- permiso para consultar sobre la tabla productos

	GRANT SELECT,INSERT,UPDATE,DELETE
	ON ventas
	TO vendedor;			-- permiso para consultar, insertar, actualizar 
							-- o borrar sobre la tabla ventas
	GRANT CONNECT ON DATABASE tienda_prueba TO juan; -- permiso para conectar a la db
	
--7. Conceder permisos al rol admin:
	GRANT ALL PRIVILEGES 
	ON ALL TABLES IN SCHEMA public
	TO admin;		-- todos los privilegios en todas las tablas del esquema public
	GRANT CREATE ON SCHEMA public 
	TO admin;       -- para crear y modificar en el schema ( crear tablas p.ej)
	GRANT EXECUTE  
	ON ALL FUNCTIONS IN SCHEMA public
	TO admin;		-- Permiso para ejecutar todas las funciones y procedimientos 
					-- que estén en el schema public. 
--8. Conceder Permisos Sobre Secuencias
GRANT USAGE, SELECT, 
  ON ALL SEQUENCES IN SCHEMA public
  TO vendedor, admin;

/* Como loggearte y cerrar sesión :
	1. Para iniciar sesión con usuario: Abre la terminal o cmd 
	psql -h localhost -d tienda_prueba -U juan 
	-h = servidor (serverlocal en este caso)  -d = database  -U = usuario
	introduces la contraseña.
	
	2. Para cerrar sesión:
	\q + enter 
	
*/


	