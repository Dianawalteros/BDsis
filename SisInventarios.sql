--DDL
CREATE DATABASE SisInventario;
GO

USE SisInventario;
GO

--DDL
CREATE TABLE proveedores (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    direccion VARCHAR(255),
    telefono INT,
    email VARCHAR(100)
);
GO

--DDL
CREATE TABLE equipos_biomedicos (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    proveedor_id INT,
    fecha_adquisicion DATE,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);
GO

--DDL
CREATE TABLE infraestructura (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255),
    capacidad INT
);
GO

--DDL
CREATE TABLE recepciones (
    id INT PRIMARY KEY IDENTITY(1,1),
    equipo_id INT,
    fecha DATE,
    estado VARCHAR(50),
    FOREIGN KEY (equipo_id) REFERENCES equipos_biomedicos(id)
);
GO

--DDL
CREATE TABLE usuarios (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    rol VARCHAR(50)
);
GO

--DML
SELECT * FROM proveedores;

SELECT eb.nombre AS equipo, p.nombre AS proveedor
FROM equipos_biomedicos eb
JOIN proveedores p ON eb.proveedor_id = p.id;

SELECT r.fecha, eb.nombre AS equipo, r.estado
FROM recepciones r
JOIN equipos_biomedicos eb ON r.equipo_id = eb.id;

SELECT * FROM usuarios;

SELECT * FROM infraestructura;

--DML
INSERT INTO proveedores (nombre, direccion, telefono, email) VALUES
('Proveedor A', 'Calle 123', '123456789', 'contacto@proveedora.com'),
('Proveedor B', 'Avenida 456', '987654321', 'info@proveedorb.com');

INSERT INTO equipos_biomedicos (nombre, tipo, proveedor_id, fecha_adquisicion) VALUES
('Equipo A', 'Tipo 1', 1, '2023-01-15'),
('Equipo B', 'Tipo 2', 2, '2023-02-20');

INSERT INTO infraestructura (nombre, ubicacion, capacidad) VALUES
('Sala de Equipos', 'Planta 1', 10),
('Laboratorio', 'Planta 2', 5);

INSERT INTO recepciones (equipo_id, fecha, estado) VALUES
(1, '2023-01-16', 'Recibido'),
(2, '2023-02-21', 'En Proceso');

INSERT INTO usuarios (nombre, email, rol) VALUES
('DIANA', 'usuario1@ejemplo.com', 'Técnico'),
('MARIA', 'usuario2@ejemplo.com', 'Administrador');

--DML
SELECT * FROM proveedores;
GO

SELECT * FROM usuarios;
GO

SELECT * FROM infraestructura;
GO

SELECT * FROM recepciones;
GO

SELECT * FROM equipos_biomedicos;
GO

CREATE PROCEDURE ObtenerInscripciones

AS

BEGIN

SELECT 

--Un procedimiento almacenado es un conjunto de instrucciones SQL precompiladas que se almacenan 
--en la base de datos y se pueden ejecutar cuando se necesiten.

--Automatiza tareas repetitivas

--SP Sencillo
CREATE PROCEDURE ObtenerInscripciones
AS
BEGIN
    SELECT 
        I.InscripcionID,
        E.Nombre + ' ' + E.Apellido AS Estudiante,
        C.NombreCurso AS Curso,
        I.FechaInscripcion
    FROM Inscripciones I
    INNER JOIN Estudiantes E ON I.EstudianteID = E.EstudianteID
    INNER JOIN Cursos C ON I.CursoID = C.CursoID
    ORDER BY Estudiante ASC;
END;
GO

EXEC ObtenerInscripciones;
