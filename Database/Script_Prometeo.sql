--  Creación Base de Datos (Grupo 11)
CREATE DATABASE SistemaPrometeo;
GO

USE SistemaPrometeo;
GO


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

CREATE TABLE AreasInvestigacion (
    AreaID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100)
);

CREATE TABLE EstadosProyecto (
    EstadoID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(50)
);


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
    CarreraID INT NULL,         
    CicloID INT NULL,          
    
    -- Campos para Docentes (pueden ser NULL si el usuario es estudiante/admin)
    CodigoEmpleado NVARCHAR(20) NULL,
    Facultad NVARCHAR(100) NULL,

    
    FOREIGN KEY (CarreraID) REFERENCES Carreras(CarreraID),
    FOREIGN KEY (CicloID) REFERENCES Ciclos(CicloID)
);


CREATE TABLE Proyectos (
    ProyectoID INT IDENTITY PRIMARY KEY,
    UsuarioID INT,
    NombreProyecto VARCHAR(200),
    TituloProyecto VARCHAR(300),
    Descripcion TEXT,
    Objetivo TEXT,
    AreaID INT,
    Tipo CHAR(1),
    EstadoID INT,
    FechaEnvio DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
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


-- DATOS DE PRUEBA PARA CICLOS (Necesario antes de crear usuarios con CicloID)
INSERT INTO Ciclos (NombreCiclo, FechaInicio, FechaCierre)
VALUES ('Ciclo 01-2026', '2026-01-15', '2026-06-15');

INSERT INTO Carreras VALUES ('Ingenieria en Sistemas')
INSERT INTO Carreras VALUES ('Ingenieria en Sistemas Virtual')

-- AGREGAMOS UN ADMIN DE PRUEBA (Para podernos loguear)
INSERT INTO Usuarios (Nombres, Apellidos, Correo, Contraseña, Rol, EstudianteID, CarreraID, CicloID)
VALUES ('Admin', 'General', 'admin@mail.utec.edu.sv', '123456', 'Administrador', 1, 1, 1);

INSERT INTO EstadosProyecto VALUES ('Pendiente')
INSERT INTO EstadosProyecto VALUES ('En revisión')
INSERT INTO EstadosProyecto VALUES ('Aprobado')
INSERT INTO EstadosProyecto VALUES ('Rechazado')

INSERT INTO AreasInvestigacion VALUES ('Inteligencia Artificial')
INSERT INTO AreasInvestigacion VALUES ('Desarrollo Web')
INSERT INTO AreasInvestigacion VALUES ('Ciberseguridad')
GO
