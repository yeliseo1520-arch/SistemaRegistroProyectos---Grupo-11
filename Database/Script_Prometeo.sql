--  Creación Base de Datos (Grupo 11)
CREATE DATABASE SistemaPrometeo;
GO

USE SistemaPrometeo;
GO

--  TABLA USUARIOS (Gestión de Admin, Docentes y Estudiantes)
CREATE TABLE Usuarios (
    UsuarioID INT IDENTITY(1,1) PRIMARY KEY,
    Nombres NVARCHAR(100) NOT NULL,
    Apellidos NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(150) NOT NULL UNIQUE,
    Contraseña NVARCHAR(50) NOT NULL,
    Rol NVARCHAR(20) NOT NULL, -- 'Administrador', 'Docente', 'Estudiante'
    
    -- Campos para Estudiantes (pueden ser NULL si el usuario es docente/admin)
    Carnet NVARCHAR(20) NULL,
    Carrera NVARCHAR(100) NULL,
    
    -- Campos para Docentes (pueden ser NULL si el usuario es estudiante/admin)
    CodigoEmpleado NVARCHAR(20) NULL,
    Facultad NVARCHAR(100) NULL
);

--  TABLA CICLOS ACADEMICOS (Para el CRUD del Admin)
CREATE TABLE Ciclos (
    CicloID INT IDENTITY(1,1) PRIMARY KEY,
    NombreCiclo NVARCHAR(20) NOT NULL, -- Ej: 01-2026
    FechaInicio DATE NOT NULL,
    FechaCierre DATE NOT NULL
);

-- AGREGAMOS UN ADMIN DE PRUEBA (Para podernos loguear)
INSERT INTO Usuarios (Nombres, Apellidos, Correo, Contraseña, Rol)
VALUES ('Admin', 'General', 'admin@mail.utec.edu.sv', '123456', 'Administrador');

-- DATOS DE PRUEBA PARA CICLOS
INSERT INTO Ciclos (NombreCiclo, FechaInicio, FechaCierre)
VALUES ('Ciclo 01-2026', '2026-01-15', '2026-06-15');
GO