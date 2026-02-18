<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SistemaRegistroProyectos.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Acceso al Sistema - Gestión de Proyectos</title>
    <link rel="stylesheet" href="Estilos/estiloslogin.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="background-overlay"></div>
    
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>Bienvenido al Sistema de Proyectos PROMETEO</h2>
            <p>Ingresa tus credenciales para continuar</p>

            <div class="input-group">
                <label>Usuario</label>
                <asp:TextBox ID="txtUsuario" runat="server" placeholder="Ej: mat-2024"></asp:TextBox>
            </div>

            <div class="input-group">
                <label>Contraseña</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••••"></asp:TextBox>
            </div>

            <div class="input-group">
                <label>Tipo de Perfil</label>
                <asp:DropDownList ID="ddlPerfil" runat="server">
                    <asp:ListItem Value="0">Seleccione su perfil...</asp:ListItem>
                    <asp:ListItem Value="1">Estudiante</asp:ListItem>
                    <asp:ListItem Value="2">Docente</asp:ListItem>
                    <asp:ListItem Value="2">Admin</asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn-login" />

            <div class="login-footer">
                <a href="Docente.aspx">¿Olvidaste tu contraseña?</a>
            </div>
        </div>
    </form>
</body>
</html>
