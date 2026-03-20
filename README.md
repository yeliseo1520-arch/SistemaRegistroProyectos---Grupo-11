# Sistema de Registro de Proyectos - PROMETEO (Grupo 11)

Esta solución integral para el **Sistema de Registro de Proyectos de Grado** ha sido desarrollada como parte de la **Unidad 2** de la materia Programación II. El sistema permite la gestión dinámica de propuestas académicas, integrando una arquitectura robusta de persistencia de datos y seguridad por roles.

---

##  Tecnologías y Requisitos
*   **Lenguaje:** C# (.NET Framework 4.8.1)
*   **Base de Datos:** SQL Server (LocalDB / Express)
*   **Tecnología de Datos:** ADO.NET (Modelo Conectado y Desconectado)
*   **Diseño:** Bootstrap 5, CSS3, Google Fonts e Iconos de Bootstrap
*   **IDE:** Visual Studio 2022
*   **Gestor de BD:** SQL Server Management Studio (SSMS)

---

##  Instrucciones de Ejecución para Evaluación

Para garantizar que el proyecto funcione correctamente en su entorno local, siga estos pasos:

1.  **Clonación:** Clone este repositorio en su máquina local.
2.  **Restaurar Dependencias:** Al abrir la solución en Visual Studio, vaya a la pestaña **Compilar > Recompilar solución**. Esto forzará la restauración de los paquetes de NuGet.
3.  **Nota Técnica (Error de Compilador):** Si el servidor IIS Express arroja un error relacionado con `roslyn\csc.exe`, abra la **Consola del Administrador de paquetes NuGet** e ingrese el siguiente comando:
    `Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -Reinstall`
4.  **Página de Inicio:** En el Explorador de Soluciones, haga clic derecho sobre `Login.aspx` y seleccione **"Establecer como página de inicio"**.
5.  **Ejecutar:** Presione **F5** para iniciar la aplicación en su navegador.

---

##  Configuración de la Base de Datos

El sistema utiliza un modelo relacional normalizado para garantizar la integridad de la información.

1.  **Preparación de los Datos:** Localice el archivo en la ruta `/Database/Script_Prometeo.sql`.
2.  **Ejecución:** Abra el archivo en **SSMS** y ejecute el script completo. 
    *   *Este comando creará la base de datos `SistemaPrometeo`, las tablas necesarias e insertará los catálogos maestros (Carreras, Ciclos, Estados) y usuarios de prueba.*
3.  **Cadena de Conexión (Web.config):** El proyecto está configurado para buscar el servidor local mediante el punto (`.`). 
    ```xml
    <add name="PrometeoConnectionString" connectionString="Data Source=.;Initial Catalog=SistemaPrometeo;Integrated Security=True;..." />
    ```
    *Si su instancia local tiene un nombre específico (ej: `.\SQLEXPRESS`), favor ajustarlo en la sección `<connectionStrings>` del archivo `Web.config`.*

---

##  Credenciales de Prueba para Evaluación

Utilice las siguientes cuentas para validar el control de acceso y las funcionalidades por perfil:

| Perfil | Correo Electrónico | Contraseña |
| :--- | :--- | :--- |
| **Administrador** | `admin@mail.utec.edu.sv` | `123456` |
| **Estudiante** | *(Registrar nuevo en módulo Admin)* | `Utec123` |
| **Docente** | *(Registrar nuevo en módulo Admin)* | `Utec123` |

---

## Funcionalidades Implementadas (Unidad 2)

*   **Persistencia Real con ADO.NET:** Implementación de operaciones CRUD (Crear, Leer, Actualizar, Eliminar) utilizando `SqlDataSource` y comandos manuales con `SqlDataAdapter` y `DataTable`.
*   **Gestión de Sesiones (State Management):** Uso de variables de `Session` para persistir la identidad del usuario y su ID de perfil a través de las diferentes páginas del sitio.
*   **Seguridad por Roles (RBAC):** Protección de rutas en el servidor y personalización dinámica del menú en la **Master Page** según el rol del usuario autenticado.
*   **Paneles Dinámicos y Validaciones:** Formularios inteligentes que se adaptan al rol seleccionado y validan la integridad de los datos mediante `RequiredFieldValidator` y `RegularExpressionValidator`.
*   **Motor de Búsqueda:** Dashboard con filtros dinámicos que combinan parámetros de texto y estado del proyecto.
*   **Integridad Referencial:** Lógica de negocio avanzada que maneja el borrado en cascada de dependencias (Observaciones y Documentos) antes de eliminar registros principales.

---

##  Autores - Grupo 11

*   **RODRÍGUEZ RAMÍREZ, YONATAN ELISEO** - 29-4119-2024
*   **ROMERO ROMERO, JOSÉ ALEXANDER** - 29-4322-2024
*   **RUANO RICO, DAVID EDUARDO** - 29-5117-2016
*   **SALAS ROGEL, JORGE ALBERTO** - 29-0377-2023
*   **SANCHEZ HERNANDEZ, ROBERTO ALFREDO** - 29-5057-2019

---
*Este proyecto pertenece a la cátedra de **Programación II**, Facultad de Informática y Ciencias Aplicadas - UTEC.*
