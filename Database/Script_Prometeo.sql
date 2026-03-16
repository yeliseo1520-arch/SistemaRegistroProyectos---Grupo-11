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
	EstudianteID INT,
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

CREATE TABLE Carreras (
    CarreraID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(150)
);

CREATE TABLE Estudiantes (
    EstudianteID INT IDENTITY PRIMARY KEY,
    UsuarioID INT UNIQUE,
    Nombres VARCHAR(100),
    Apellidos VARCHAR(100),
    Carnet VARCHAR(20),
    CarreraID INT,
    CicloID INT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

CREATE TABLE AreasInvestigacion (
    AreaID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE EstadosProyecto (
    EstadoID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(50)
);

CREATE TABLE Proyectos (
    ProyectoID INT IDENTITY PRIMARY KEY,
    EstudianteID INT,
    NombreProyecto VARCHAR(200),
    TituloProyecto VARCHAR(300),
    Descripcion TEXT,
    Objetivo TEXT,
    AreaID INT,
    Tipo CHAR(1),
    EstadoID INT,
    FechaEnvio DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EstudianteID) REFERENCES Estudiantes(EstudianteID),
    FOREIGN KEY (AreaID) REFERENCES AreasInvestigacion(AreaID),
    FOREIGN KEY (EstadoID) REFERENCES EstadosProyecto(EstadoID)
);

CREATE TABLE DocumentosProyecto (
    DocumentoID INT IDENTITY PRIMARY KEY,
    ProyectoID INT,
    NombreArchivo VARCHAR(200),
    RutaArchivo VARCHAR(300),
    FechaSubida DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProyectoID) REFERENCES Proyectos(ProyectoID)
);

CREATE TABLE Observaciones (
    ObservacionID INT IDENTITY PRIMARY KEY,
    ProyectoID INT,
    Comentario TEXT,
    Fecha DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ProyectoID) REFERENCES Proyectos(ProyectoID)
);

-- AGREGAMOS UN ADMIN DE PRUEBA (Para podernos loguear)
INSERT INTO Estudiantes (UsuarioID,Nombres,Apellidos,Carnet,CarreraID,CicloID)
VALUES (1,'Paco','Flores','1212341234',1,1)

INSERT INTO Usuarios (Nombres, Apellidos, Correo, Contraseña, Rol, EstudianteID)
VALUES ('Admin', 'General', 'admin@mail.utec.edu.sv', '123456', 'Administrador',1);

-- DATOS DE PRUEBA PARA CICLOS
INSERT INTO Ciclos (NombreCiclo, FechaInicio, FechaCierre)
VALUES ('Ciclo 01-2026', '2026-01-15', '2026-06-15');
GO

INSERT INTO EstadosProyecto VALUES ('Pendiente')
INSERT INTO EstadosProyecto VALUES ('En revisión')
INSERT INTO EstadosProyecto VALUES ('Aprobado')
INSERT INTO EstadosProyecto VALUES ('Rechazado')

INSERT INTO AreasInvestigacion VALUES ('Inteligencia Artificial')
INSERT INTO AreasInvestigacion VALUES ('Desarrollo Web')
INSERT INTO AreasInvestigacion VALUES ('Ciberseguridad')

INSERT INTO Carreras VALUES ('Ingenieria en Sistemas')
INSERT INTO Carreras VALUES ('Ingenieria en Sistemas Virtual')
