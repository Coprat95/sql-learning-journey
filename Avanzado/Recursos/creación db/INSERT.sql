-- Inserts para Géneros (creando una jerarquía)
INSERT INTO Generos (nombre, genero_padre_id, nivel) VALUES
('Música', NULL, 1),
('Tropical', 1, 2),
('Urbano', 1, 2),
('Electrónica Latina', 1, 2),
('Jazz Latino', 1, 2),
('Rap Latino', 1, 2),
('Salsa', 2, 3),
('Merengue', 2, 3),
('Bachata', 2, 3),
('Reggaeton', 3, 3),
('Dancehall Latino', 3, 3),
('Pop Latino', 3, 3),
('Latino House', 4, 3),
('Moombahton', 4, 3),
('Electro Latino', 4, 3),
('Latin Jazz', 5, 3),
('Bossa Nova', 5, 3),
('Afro-Cuban Jazz', 5, 3),
('Hip Hop Latino', 6, 3),
('Latino Trap', 6, 3);

-- Inserts para Artistas
INSERT INTO Artistas (nombre, pais, genero_id, mentor_id, fecha_inicio) VALUES
('Marc Anthony', 'Estados Unidos', 7, NULL, '2010-01-15'),
('Shakira', 'Colombia', 10, 1, '2012-03-20'),
('Luis Fonsi', 'Puerto Rico', 12, NULL, '2008-07-10'),
('Karol G', 'Colombia', 11, 2, '2015-09-01'),
('Romeo Santos', 'Estados Unidos', 8, NULL, '2005-11-30'),
('Gente de Zona', 'Cuba', 13, 5, '2013-04-25'),
('Arturo Sandoval', 'Cuba', 16, NULL, '2007-08-12'),
('Nicky Jam', 'Estados Unidos', 14, 6, '2014-02-18'),
('Residente', 'Puerto Rico', 19, NULL, '2011-06-05'),
('J Balvin', 'Colombia', 15, 8, '2016-10-22'),
('Maluma', 'Colombia', 12, 3, '2009-12-08'),
('Tito Puente Jr.', 'Estados Unidos', 17, 7, '2017-05-15'),
('Prince Royce', 'Estados Unidos', 9, 1, '2006-03-28'),
('Bad Bunny', 'Puerto Rico', 20, 9, '2018-07-11'),
('Celia Cruz', 'Cuba', 18, 7, '2010-09-30');

-- Más artistas para expandir la red de mentorías
INSERT INTO Artistas (nombre, pais, genero_id, mentor_id, fecha_inicio) VALUES
('Daddy Yankee', 'Puerto Rico', 3, 5, '2010-08-15'),
('Ozuna', 'Puerto Rico', 7, 1, '2015-03-20'),
('Becky G', 'Estados Unidos', 10, 2, '2016-07-10'),
('Wisin', 'Puerto Rico', 11, 4, '2017-09-01'),
('Anuel AA', 'Puerto Rico', 8, 13, '2018-11-30'),
('Rauw Alejandro', 'Puerto Rico', 13, 6, '2019-04-25'),
('Willie Colón', 'Estados Unidos', 16, 7, '2020-08-12'),
('Don Omar', 'Puerto Rico', 14, 8, '2021-02-18'),
('Tego Calderón', 'Puerto Rico', 19, 9, '2022-06-05'),
('Sech', 'Panamá', 15, 10, '2023-10-22');

-- Inserts para Canciones
INSERT INTO Canciones (titulo, artista_id, duracion, precio, fecha_lanzamiento, popularidad) VALUES
('Vivir Mi Vida', 1, 245, 0.99, '2020-01-15', 85),
('La Tortura', 2, 198, 1.29, '2020-02-20', 92),
('Despacito', 3, 312, 0.89, '2020-03-10', 78),
('Tusa', 4, 267, 1.49, '2020-04-05', 95),
('Propuesta Indecente', 5, 289, 0.99, '2020-05-12', 88),
('Bailando', 6, 234, 1.19, '2020-06-18', 91),
('Guantanamera', 7, 276, 0.99, '2020-07-22', 83),
('El Perdón', 8, 323, 1.39, '2020-08-30', 89),
('Atrévete-te-te', 9, 245, 0.99, '2020-09-14', 87),
('Mi Gente', 10, 198, 1.29, '2020-10-25', 94),
('Felices los 4', 11, 287, 1.49, '2021-01-05', 96),
('Oye Como Va', 12, 256, 0.99, '2021-02-12', 82),
('Darte un Beso', 13, 312, 1.19, '2021-03-20', 88),
('Yo Perreo Sola', 14, 234, 0.89, '2021-04-15', 91),
('La Vida Es Un Carnaval', 15, 298, 1.39, '2021-05-28', 85),
('Gasolina', 16, 267, 0.99, '2021-06-10', 89),
('El Farsante', 17, 245, 1.29, '2021-07-17', 93),
('Mayores', 18, 289, 1.49, '2021-08-22', 87),
('Escapate Conmigo', 19, 312, 0.99, '2021-09-30', 90),
('Todo de Ti', 20, 276, 1.19, '2021-10-15', 95),
('La Negra Tiene Tumbao', 11, 289, 0.99, '2022-01-10', 88),
('Pa Ti', 12, 234, 1.29, '2022-02-15', 92),
('Corazón Sin Cara', 13, 267, 1.49, '2022-03-20', 86),
('Dakiti', 14, 198, 0.99, '2022-04-25', 94),
('Quimbara', 15, 312, 1.19, '2022-05-30', 89);

-- Más canciones para los artistas existentes y nuevos
INSERT INTO Canciones (titulo, artista_id, duracion, precio, fecha_lanzamiento, popularidad) VALUES
('Barrio Fino', 16, 245, 0.99, '2023-01-15', 87),
('Odisea', 17, 198, 1.29, '2023-02-20', 91),
('Sin Pijama', 18, 312, 0.89, '2023-03-10', 76),
('Adrenalina', 19, 267, 1.49, '2023-04-05', 93),
('Real Hasta la Muerte', 20, 289, 0.99, '2023-05-12', 85),
('Vice Versa', 21, 234, 1.19, '2023-06-18', 88),
('El Gran Varón', 22, 276, 0.99, '2023-07-22', 82),
('Danza Kuduro', 23, 323, 1.39, '2023-08-30', 90),
('Pa Que Retozen', 24, 245, 0.99, '2023-09-14', 86),
('Relación', 25, 198, 1.29, '2023-10-25', 92),
('Bandido', 16, 287, 1.49, '2023-11-05', 95),
('Criminal', 17, 256, 0.99, '2023-12-12', 83),
('La Santa', 18, 312, 1.19, '2024-01-20', 89),
('2/Catorce', 19, 234, 0.89, '2024-01-15', 94),
('Bellacoso', 20, 298, 1.39, '2024-01-28', 87);

-- Inserts para Usuarios
INSERT INTO Usuarios (nombre, email, fecha_registro, ultima_conexion, pais) VALUES
('Ana Silva', 'ana.silva@email.com', '2020-01-01', '2024-01-15 08:30:00', 'España'),
('Pedro Martínez', 'pedro.martinez@email.com', '2020-02-15', '2024-01-15 09:45:00', 'México'),
('Laura González', 'laura.gonzalez@email.com', '2020-03-20', '2024-01-15 10:15:00', 'Argentina'),
('Carlos Ruiz', 'carlos.ruiz@email.com', '2020-04-10', '2024-01-15 11:30:00', 'España'),
('María López', 'maria.lopez@email.com', '2020-05-05', '2024-01-15 12:45:00', 'Colombia'),
('Juan Pérez', 'juan.perez@email.com', '2020-06-18', '2024-01-15 13:20:00', 'México'),
('Sofia Torres', 'sofia.torres@email.com', '2020-07-22', '2024-01-15 14:10:00', 'Chile'),
('Diego Sánchez', 'diego.sanchez@email.com', '2020-08-30', '2024-01-15 15:25:00', 'España'),
('Carmen Rodríguez', 'carmen.rodriguez@email.com', '2020-09-14', '2024-01-15 16:40:00', 'Argentina'),
('Roberto Fernández', 'roberto.fernandez@email.com', '2020-10-25', '2024-01-15 17:55:00', 'Perú'),
('Isabel García', 'isabel.garcia@email.com', '2021-01-05', '2024-01-15 18:30:00', 'España'),
('Miguel Ángel', 'miguel.angel@email.com', '2021-02-12', '2024-01-15 19:45:00', 'México'),
('Lucía Morales', 'lucia.morales@email.com', '2021-03-20', '2024-01-15 20:15:00', 'Colombia'),
('Fernando Castro', 'fernando.castro@email.com', '2021-04-15', '2024-01-15 21:30:00', 'Chile'),
('Patricia Vargas', 'patricia.vargas@email.com', '2021-05-28', '2024-01-15 22:45:00', 'Argentina');

-- Inserts para Amigos (creando una red social)
INSERT INTO Amigos (usuario_id, amigo_id, fecha_amistad, tipo_relacion) VALUES
(1, 2, '2020-02-15', 'mejor amigo'),
(1, 3, '2020-03-20', 'conocido'),
(1, 4, '2020-04-10', 'amigo'),
(2, 3, '2020-05-05', 'mejor amigo'),
(2, 5, '2020-06-18', 'amigo'),
(3, 4, '2020-07-22', 'conocido'),
(3, 6, '2020-08-30', 'amigo'),
(4, 5, '2020-09-14', 'mejor amigo'),
(4, 7, '2020-10-25', 'conocido'),
(5, 6, '2021-01-05', 'amigo'),
(5, 8, '2021-02-12', 'mejor amigo'),
(6, 7, '2021-03-20', 'conocido'),
(6, 9, '2021-04-15', 'amigo'),
(7, 8, '2021-05-28', 'mejor amigo'),
(7, 10, '2021-06-10', 'conocido'),
(8, 9, '2021-07-17', 'amigo'),
(8, 11, '2021-08-22', 'mejor amigo'),
(9, 10, '2021-09-30', 'conocido'),
(9, 12, '2021-10-15', 'amigo'),
(10, 11, '2022-01-10', 'mejor amigo');

-- Inserts para Reproducciones
INSERT INTO Reproducciones (usuario_id, cancion_id, fecha_reproduccion, tiempo_escuchado, calificacion, indice_satisfaccion) VALUES
(1, 1, '2024-01-01 08:30:00', 240, 5, 0.95),
(1, 2, '2024-01-01 09:00:00', 195, 4, 0.85),
(1, 3, '2024-01-01 10:15:00', 300, NULL, NULL),
(2, 4, '2024-01-01 11:30:00', 265, 5, 0.92),
(2, 5, '2024-01-01 12:45:00', 285, 3, 0.78),
(2, 6, '2024-01-01 14:00:00', 230, 4, 0.88),
(3, 7, '2024-01-01 15:15:00', 270, 5, 0.94),
(3, 8, '2024-01-01 16:30:00', 320, NULL, NULL),
(3, 9, '2024-01-01 17:45:00', 240, 4, 0.86),
(4, 10, '2024-01-01 19:00:00', 195, 5, 0.96),
(4, 11, '2024-01-02 08:30:00', 285, 3, 0.75),
(4, 12, '2024-01-02 09:45:00', 250, 4, 0.89),
(5, 13, '2024-01-02 11:00:00', 310, 5, 0.93),
(5, 14, '2024-01-02 12:15:00', 230, NULL, NULL),
(5, 15, '2024-01-02 13:30:00', 295, 4, 0.87),
(6, 16, '2024-01-02 14:45:00', 265, 5, 0.91),
(6, 17, '2024-01-02 16:00:00', 240, 3, 0.76),
(6, 18, '2024-01-02 17:15:00', 285, 4, 0.88),
(7, 19, '2024-01-02 18:30:00', 310, 5, 0.95),
(7, 20, '2024-01-02 19:45:00', 275, NULL, NULL),
(8, 21, '2024-01-03 08:30:00', 285, 4, 0.84),
(8, 22, '2024-01-03 09:45:00', 230, 5, 0.92),
(9, 23, '2024-01-03 11:00:00', 265, 3, 0.77),
(9, 24, '2024-01-03 12:15:00', 195, 4, 0.86),
(10, 25, '2024-01-03 13:30:00', 310, 5, 0.94),
(1, 5, '2024-01-03 14:45:00', 285, 4, 0.88),
(2, 8, '2024-01-03 16:00:00', 320, 5, 0.93),
(3, 11, '2024-01-03 17:15:00', 285, 3, 0.79),
(4, 14, '2024-01-03 18:30:00', 230, 4, 0.85),
(5, 17, '2024-01-03 19:45:00', 240, 5, 0.90),
(6, 20, '2024-01-04 08:30:00', 275, NULL, NULL),
(7, 23, '2024-01-04 09:45:00', 265, 4, 0.87),
(8, 1, '2024-01-04 11:00:00', 240, 5, 0.91),
(9, 4, '2024-01-04 12:15:00', 265, 3, 0.78),
(10, 7, '2024-01-04 13:30:00', 270, 4, 0.89),
(1, 10, '2024-01-04 14:45:00', 195, 5, 0.95),
(2, 13, '2024-01-04 16:00:00', 310, NULL, NULL),
(3, 16, '2024-01-04 17:15:00', 265, 4, 0.86),
(4, 19, '2024-01-04 18:30:00', 310, 5, 0.92),
(5, 22, '2024-01-04 19:45:00', 230, 3, 0.77);





-- Más usuarios para expandir la red social
INSERT INTO Usuarios (nombre, email, fecha_registro, ultima_conexion, pais) VALUES
('Martín Díaz', 'martin.diaz@email.com', '2022-01-01', '2024-01-15 08:30:00', 'Argentina'),
('Julia Sanz', 'julia.sanz@email.com', '2022-02-15', '2024-01-15 09:45:00', 'España'),
('Roberto Paz', 'roberto.paz@email.com', '2022-03-20', '2024-01-15 10:15:00', 'México'),
('Carmen Vega', 'carmen.vega@email.com', '2022-04-10', '2024-01-15 11:30:00', 'Chile'),
('Antonio Ruiz', 'antonio.ruiz@email.com', '2022-05-05', '2024-01-15 12:45:00', 'España');

-- Más relaciones de amistad
INSERT INTO Amigos (usuario_id, amigo_id, fecha_amistad, tipo_relacion) VALUES
(1, 16, '2023-01-15', 'amigo'),
(2, 17, '2023-02-20', 'mejor amigo'),
(3, 18, '2023-03-10', 'conocido'),
(4, 19, '2023-04-05', 'amigo'),
(5, 20, '2023-05-12', 'mejor amigo'),
(6, 16, '2023-06-18', 'conocido'),
(7, 17, '2023-07-22', 'amigo'),
(8, 18, '2023-08-30', 'mejor amigo'),
(9, 19, '2023-09-14', 'conocido'),
(10, 20, '2023-10-25', 'amigo'),
(11, 16, '2023-11-05', 'mejor amigo'),
(12, 17, '2023-12-12', 'conocido'),
(13, 18, '2024-01-20', 'amigo'),
(14, 19, '2024-01-15', 'mejor amigo'),
(15, 20, '2024-01-28', 'conocido');

-- Muchas más reproducciones con diferentes patrones de escucha
INSERT INTO Reproducciones (usuario_id, cancion_id, fecha_reproduccion, tiempo_escuchado, calificacion, indice_satisfaccion) VALUES
-- Escuchas completas
(1, 26, '2024-01-05 08:30:00', 240, 5, 0.95),
(2, 27, '2024-01-05 09:00:00', 195, 4, 0.85),
(3, 28, '2024-01-05 10:15:00', 310, 5, 0.92),
-- Escuchas parciales
(4, 29, '2024-01-05 11:30:00', 130, 3, 0.65),
(5, 30, '2024-01-05 12:45:00', 142, 2, 0.45),
(6, 31, '2024-01-05 14:00:00', 115, 3, 0.58),
-- Escuchas a la mitad
(7, 32, '2024-01-05 15:15:00', 138, 4, 0.75),
(8, 33, '2024-01-05 16:30:00', 161, 3, 0.68),
(9, 34, '2024-01-05 17:45:00', 122, 4, 0.72),
-- Más patrones variados
(10, 35, '2024-01-06 08:30:00', 285, 5, 0.94),
(11, 36, '2024-01-06 09:45:00', 128, 2, 0.48),
(12, 37, '2024-01-06 11:00:00', 156, 3, 0.62),
(13, 38, '2024-01-06 12:15:00', 230, 5, 0.91),
(14, 39, '2024-01-06 13:30:00', 145, 3, 0.57),
(15, 40, '2024-01-06 14:45:00', 265, 4, 0.83),
-- Reproducciones repetidas para mostrar patrones
(1, 30, '2024-01-06 16:00:00', 285, 5, 0.96),
(2, 31, '2024-01-06 17:15:00', 140, 2, 0.51),
(3, 32, '2024-01-06 18:30:00', 155, 3, 0.64),
(4, 33, '2024-01-06 19:45:00', 275, 4, 0.88),
(5, 34, '2024-01-07 08:30:00', 132, 2, 0.47),
-- Más reproducciones cruzadas para amigos
(6, 26, '2024-01-07 09:45:00', 238, 5, 0.93),
(7, 27, '2024-01-07 11:00:00', 192, 4, 0.82),
(8, 28, '2024-01-07 12:15:00', 305, 5, 0.91),
(9, 29, '2024-01-07 13:30:00', 128, 3, 0.59),
(10, 30, '2024-01-07 14:45:00', 135, 2, 0.46),
-- Reproducciones adicionales para análisis temporal
(11, 31, '2024-01-07 16:00:00', 228, 4, 0.87),
(12, 32, '2024-01-07 17:15:00', 185, 3, 0.76),
(13, 33, '2024-01-07 18:30:00', 295, 5, 0.94),
(14, 34, '2024-01-07 19:45:00', 125, 2, 0.52),
(15, 35, '2024-01-08 08:30:00', 278, 4, 0.85);