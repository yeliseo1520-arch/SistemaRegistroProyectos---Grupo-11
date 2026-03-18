<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SistemaRegistroProyectos.Formulario_web12" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


        <link rel="stylesheet" href="Estilos/estilosdashboard.css" />

<div class="container body-content">
    <div class="row mb-4">
        <div class="col-12">
            <h2 class="text-prometeo">Panel Principal - PROMETEO</h2>
            <hr />
        </div>
    </div>

    <div class="row g-4 text-center">
        <div class="col-md-4">
            <div class="card card-menu action-card">
                <div class="card-body">
                    <i class="bi bi-plus-circle fs-1"></i>
                    <h5>Lista de Proyectos</h5>
                    <%--Modifico acá para que mande a pantalla docente y no a crear  un nuevo proyecto AR-ALXRM--%>
                    <asp:LinkButton 
                        ID="btnListaProyectos" 
                        runat="server" 
                        CssClass="stretched-link" 
                          PostBackUrl="~/Docente.aspx">
                    </asp:LinkButton>
                </div>
            </div>
        </div>
        
        <%--Acá modificare para abrir un evento en buscar proyecto AR-ALXRM --%>
        <div class="col-md-4">
    <div class="card card-menu action-card">
        <div class="card-body">
            <i class="bi bi-search fs-1"></i>
            <h5>Buscar Proyecto</h5>

            <a href="#buscador" class="stretched-link"></a>

            </div>
        </div>
    </div>
        <div class="col-md-4">
            <div class="card card-menu info-card">
                <div class="card-body">
                    <h6 class="text-muted">Proyectos Creados</h6>
                    <h2 class="display-6">15</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu info-card border-turquesa">
                <div class="card-body">
                    <h6 class="text-muted">Proyectos Activos</h6>
                    <h2 class="display-6 text-prometeo">8</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu info-card border-warning">
                <div class="card-body">
                    <h6 class="text-muted">Proyectos Pendientes</h6>
                    <h2 class="display-6 text-warning">4</h2>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card card-menu info-card border-success">
                <div class="card-body">
                    <h6 class="text-muted">Proyectos Aprobados</h6>
                    <h2 class="display-6 text-success">10</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu info-card border-danger">
                <div class="card-body">
                    <h6 class="text-muted">Proyectos Rechazados</h6>
                    <h2 class="display-6 text-danger">3</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu total-card">
                <div class="card-body text-white">
                    <h6>Total de Proyectos</h6>
                    <h2 class="display-5">40</h2>
                </div>
            </div>
        </div>
    </div>
</div>

<hr />

<div id="buscador"></div>
<%--    aca creo el panel completo que usare para filtrar los proyectos AR-ALXRM--%>
<asp:Panel ID="panelBuscador" runat="server" ClientIDMode="Static">

    <h4>Buscar Proyecto</h4>

    <asp:TextBox 
        ID="txtBuscarProyecto" 
        runat="server" 
        CssClass="form-control"
        placeholder="Escribe el nombre del proyecto">
    </asp:TextBox>

    <br />
    <%-- aca modifico para poder filtrar por nombre, estado o combianrlos AR-ALXRM --%>
<label>Filtrar por Estado</label>

<asp:DropDownList 
    ID="ddlEstadoFiltro" 
    runat="server" 
    CssClass="form-control">

    <asp:ListItem Text="Todos" Value=""></asp:ListItem>
    <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
    <asp:ListItem Text="En revisión" Value="En revisión"></asp:ListItem>
    <asp:ListItem Text="Aprobado" Value="Aprobado"></asp:ListItem>
    <asp:ListItem Text="Rechazado" Value="Rechazado"></asp:ListItem>

</asp:DropDownList>

    <br />

    <asp:Button 
        ID="btnBuscar" 
        runat="server" 
        Text="Buscar"
        CssClass="btn btn-primary"
        OnClick="btnBuscar_Click" />

    <br /><br />

    <asp:GridView 
        ID="gvBusquedaProyectos" 
        runat="server"
        AutoGenerateColumns="true"
        CssClass="table table-striped">
    </asp:GridView>

</asp:Panel>

</asp:Content>
