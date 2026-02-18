<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Estudiante.aspx.cs" Inherits="SistemaRegistroProyectos.Formulario_web1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <link rel="stylesheet" href="Estilos/estilosestudiante.css" />





<div class="container body-content">
    <div class="row">
        <div class="col-12">
            <h2 class="text-prometeo">Nueva Propuesta de Proyecto</h2>
            <p class="text-muted">Completa los campos para iniciar el proceso de evaluación.</p>
            <hr />
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label font-weight-bold">Nombre del Proyecto</label>
                <asp:TextBox ID="txtNombreProyecto" runat="server" CssClass="form-control" placeholder="Ej: Sistema de Gestión Académica"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Título del Proyecto</label>
                <asp:TextBox ID="txtTituloProyecto" runat="server" CssClass="form-control" placeholder="Título formal de la investigación"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Área o Línea de Investigación</label>
                <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Seleccione una opción..." Value="0" />
                    <asp:ListItem Text="Inteligencia Artificial" Value="1" />
                    <asp:ListItem Text="Desarrollo Web" Value="2" />
                    <asp:ListItem Text="Ciberseguridad" Value="3" />
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Estado del Proyecto</label>
                <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Pendiente" Value="1" />
                </asp:DropDownList>
            </div>
        </div>

        <div class="col-md-6">
            <div class="mb-3">
                <label class="form-label font-weight-bold">Tipo de Proyecto</label>
                <asp:DropDownList ID="ddlTipo" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Individual" Value="I" />
                    <asp:ListItem Text="Grupal" Value="G" />
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Adjuntar Documento Inicial</label>
                <asp:FileUpload ID="fileInicial" runat="server" CssClass="form-control" />
            </div>
       
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-6">
            <label class="form-label font-weight-bold">Descripción General</label>
            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>
        <div class="col-md-6">
            <label class="form-label font-weight-bold">Objetivo General</label>
            <asp:TextBox ID="txtObjetivo" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>
    </div>

    <div class="row">
        <div class="col-12 text-end">
            <asp:Button ID="btnEnviar" runat="server" Text="Registrar Proyecto" CssClass="btn-prometeo btn-lg" />
        </div>
    </div>

    <hr />

    <div class="row mt-5">
        <div class="col-12">
            <h4 class="text-prometeo mb-3">Mis Proyectos Registrados</h4>
            <div class="table-responsive">
                <table class="table table-hover shadow-sm">
                    <thead class="table-turquesa text-white">
                        <tr>
                            <th>Proyecto</th>
                            <th>Autor</th>
                            <th>Estado Actual</th>
                            <th>Fecha de Envío</th>
                            <th>Observaciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Sistema PROMETEO</td>
                            <td>Jorge Sals</td>
                            <td><span class="badge bg-warning text-dark">Pendiente</span></td>
                            <td>17/02/2026</td>
                            <td><em>Sin observaciones aún</em></td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


    </asp:Content>