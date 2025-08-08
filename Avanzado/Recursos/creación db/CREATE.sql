-- Crear la base de datos


CREATE DATABASE IF NOT EXISTS SpotifySimulator;
USE SpotifySimulator;

-- Tabla de Géneros
CREATE TABLE Generos (
    genero_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    genero_padre_id INT,
    nivel INT,
    FOREIGN KEY (genero_padre_id) REFERENCES Generos(genero_id)
);

-- Tabla de Artistas
CREATE TABLE Artistas (
    artista_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    pais VARCHAR(255),
    genero_id INT,
    mentor_id INT,
    fecha_inicio DATE,
    FOREIGN KEY (genero_id) REFERENCES Generos(genero_id),
    FOREIGN KEY (mentor_id) REFERENCES Artistas(artista_id)
);

-- Tabla de Canciones
CREATE TABLE Canciones (
    cancion_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    artista_id INT,
    duracion INT,
    precio DECIMAL(10,2),
    fecha_lanzamiento DATE,
    popularidad INT,
    FOREIGN KEY (artista_id) REFERENCES Artistas(artista_id)
);

-- Tabla de Usuarios
CREATE TABLE Usuarios (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    fecha_registro DATE,
    ultima_conexion TIMESTAMP,
    pais VARCHAR(255)
);

-- Tabla de Amigos
CREATE TABLE Amigos (
    usuario_id INT,
    amigo_id INT,
    fecha_amistad DATE,
    tipo_relacion VARCHAR(255),
    PRIMARY KEY (usuario_id, amigo_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (amigo_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla de Reproducciones
CREATE TABLE Reproducciones (
    reproduccion_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    cancion_id INT,
    fecha_reproduccion TIMESTAMP,
    tiempo_escuchado INT,
    calificacion INT,
    indice_satisfaccion DECIMAL(3,2),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (cancion_id) REFERENCES Canciones(cancion_id)
);