# Sistema de Registro de Proyectos - Grupo 11

Este repositorio contiene el código fuente del Sistema de Registro de Proyectos, desarrollado en C# utilizando ASP.NET Web Forms y la implementación de la interfaz administrativa, la lógica de seguridad por roles y la gestión de usuarios del Sistema de Registro de Proyectos de Grado. 

## Requisitos previos del entorno
Para asegurar la correcta ejecución de la plataforma, el entorno debe contar con:
* **IDE:** Visual Studio 2022.
* **Framework:** .NET Framework 4.8.1 (incluyendo el SDK).
* **SQL Server** (LocalDB o Express).
* **SQL Server Management Studio (SSMS)**.

## Instrucciones de Ejecución para Evaluación
Dado que el archivo `.gitignore` omite los binarios y paquetes locales para optimizar el repositorio, por favor siga estos pasos para ejecutar el proyecto de forma local:

1. **Clonar o descargar:** Clone este repositorio o descargue el archivo ZIP y ábralo en Visual Studio 2022 utilizando el archivo `.sln`.
2. **Restaurar dependencias:** Al abrir el proyecto, vaya a la pestaña *Compilar* > *Recompilar solución*. Esto forzará la restauración de los paquetes de NuGet.
   * *Nota técnica:* Si el servidor IIS Express arroja un error relacionado con `roslyn\csc.exe`, abra la Consola del Administrador de paquetes NuGet e ingrese el siguiente comando para regenerar el compilador: 
     `Update-Package Microsoft.CodeDom.Providers.DotNetCompilerPlatform -Reinstall`
3. **Página de inicio:** En el *Explorador de soluciones*, haga clic derecho sobre el archivo principal (por ejemplo, `Login.aspx`) y seleccione **"Establecer como página de inicio"**.
4. **Ejecutar:** Presione `F5` o el botón de Iniciar (IIS Express) para compilar y lanzar la aplicación en su navegador web.

## Instrucciones de Configuración y Despliegue

### 1. Preparación de la Base de Datos
Para que el sistema funcione, es necesario crear la estructura de datos:
1.  Localice el archivo en la carpeta: `/Database/Script_Prometeo.sql`.
2.  Abra el archivo en **SSMS**.
3.  Ejecute el script completo. Esto creará la base de datos `SistemaPrometeo`, las tablas `Usuarios` y `Ciclos`, e insertará un usuario administrador de prueba.

### 2. Configuración de la Conexión (Web.config)
El proyecto está configurado para buscar el servidor local mediante el punto (`.`). 
Si su instancia de SQL Server tiene un nombre específico (ej: `.\SQLEXPRESS`), siga estos pasos:
1.  Abra el archivo `Web.config`.
2.  Busque la sección `<connectionStrings>`.
3.  Ajuste el atributo `Data Source` según su configuración:
    *   `Data Source=.;` (Estándar local)
    *   `Data Source=.\SQLEXPRESS;` (Instancia Express)

### 3. Credenciales de Acceso (Prueba)
Para probar el módulo administrativo, ingrese en `Login.aspx` con las siguientes credenciales:
*   **Correo:** `admin@mail.utec.edu.sv`
*   **Contraseña:** `123456`
*   **Perfil:** Seleccione "Admin" en el menú desplegable.

## Autores
* **RODRÍGUEZ RAMÍREZ, YONATAN ELISEO** - 29-4119-2024
* **ROMERO ROMERO, JOSÉ ALEXANDER** - 29-4322-2024
* **RUANO RICO, DAVID EDUARDO** - 29-5117-2016
* **SALAS ROGEL, JORGE ALBERTO** - 29-0377-2023
* **SANCHEZ HERNANDEZ, ROBERTO ALFREDO** - 29-5057-2019
  
