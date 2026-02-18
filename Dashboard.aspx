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
                    <h5>Crear Nuevo Proyecto</h5>
                    <asp:LinkButton ID="btnNuevo" runat="server" CssClass="stretched-link" PostBackUrl="~/RegistroPropuesta.aspx"></asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu action-card">
                <div class="card-body">
                    <i class="bi bi-search fs-1"></i>
                    <h5>Buscar Proyecto</h5>
                    <a href="#" class="stretched-link"></a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card card-menu action-card">
                <div class="card-body">
                    <i class="bi bi-trash fs-1"></i>
                    <h5>Proyectos Eliminados</h5>
                    <a href="#" class="stretched-link"></a>
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


</asp:Content>
