<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master"
    AutoEventWireup="true"
    CodeBehind="Estudiante.aspx.cs"
    Inherits="SistemaRegistroProyectos.Formulario_web1" %>
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
                <asp:TextBox ID="txtNombreProyecto" runat="server"
                    CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Titulo del Proyecto</label>
                <asp:TextBox ID="txtTituloProyecto" runat="server"
                    CssClass="form-control"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label font-weight-bold">Area o linea de Investigacion</label>
                <asp:DropDownList ID="ddlArea" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Seleccione la categoria" Value="0" />
                    <asp:ListItem Text="Inteligencia Artificial" Value="1" />
                    <asp:ListItem Text="Desarrollo Web" Value="2" />
                    <asp:ListItem Text="Ciberseguridad" Value="3" />
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
                <asp:FileUpload ID="fileInicial" runat="server"
                    CssClass="form-control" />
            </div>
        </div>
    </div>
    <div class="row mb-4">
        <div class="col-md-6">
            <label class="form-label font-weight-bold">Descripcion General</label>
            <asp:TextBox ID="txtDescripcion" runat="server"
                CssClass="form-control"
                TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>
        <div class="col-md-6">
            <label class="form-label font-weight-bold">Objetivo General</label>
            <asp:TextBox ID="txtObjetivo" runat="server"
                CssClass="form-control"
                TextMode="MultiLine" Rows="4"></asp:TextBox>
        </div>
    </div>
    <div class="row">
        <div class="col-12 text-end">
            <asp:Button ID="btnEnviar"
                runat="server"
                Text="Registrar Proyecto"
                CssClass="btn-prometeo btn-lg"
                OnClick="btnEnviar_Click" />
        </div>
    </div>
    <hr />
    <div class="row mt-5">
        <div class="col-12">
            <h4 class="text-prometeo mb-3">Mis Proyectos Registrados</h4>
            <asp:GridView ID="gvProyectos"
    runat="server"
    CssClass="table table-hover shadow-sm"
    AutoGenerateColumns="false"
    OnRowCommand="gvProyectos_RowCommand">

    <Columns>

        <asp:BoundField HeaderText="Proyecto" DataField="NombreProyecto" />
        <asp:BoundField HeaderText="Estado" DataField="NombreEstado" />
        <asp:BoundField HeaderText="Fecha" DataField="FechaEnvio"
            DataFormatString="{0:dd/MM/yyyy}" />
        <asp:BoundField HeaderText="Observación" DataField="Observacion" />

        <asp:TemplateField HeaderText="Archivo">
            <ItemTemplate>
                <asp:Button runat="server"
                    Text="Ver"
                    CommandName="ver"
                    CommandArgument='<%# Eval("RutaArchivo") %>'
                    CssClass="btn btn-info btn-sm" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Editar">
            <ItemTemplate>
                <asp:Button runat="server"
                    Text="Editar"
                    CommandName="editar"
                    CommandArgument='<%# Eval("ProyectoID") %>'
                    Visible='<%# Eval("NombreEstado").ToString()=="Pendiente" %>'
                    CssClass="btn btn-warning btn-sm" />
            </ItemTemplate>
        </asp:TemplateField>

        <asp:TemplateField HeaderText="Eliminar">
            <ItemTemplate>
                <asp:Button runat="server"
                    Text="Eliminar"
                    CommandName="eliminar"
                    CommandArgument='<%# Eval("ProyectoID") %>'
                    Visible='<%# Eval("NombreEstado").ToString()=="Pendiente" %>'
                    CssClass="btn btn-danger btn-sm" />
            </ItemTemplate>
        </asp:TemplateField>

    </Columns>

</asp:GridView>
        </div>
    </div>
</div>
</asp:Content>