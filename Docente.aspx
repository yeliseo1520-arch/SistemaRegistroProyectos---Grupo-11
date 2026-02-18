<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Docente.aspx.cs" Inherits="SistemaRegistroProyectos.Formulario_web11" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   
        <link rel="stylesheet" href="Estilos/estilosdocente.css" />

<div class="container body-content">
    <div class="row">
        <div class="col-12">
            <h2 class="text-prometeo">Panel de Revisión Docente</h2>
            <p class="text-muted">Gestión y seguimiento de propuestas de proyectos académicos.</p>
            <hr />
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-12">
            <div class="table-responsive shadow-sm rounded">
                <table class="table table-hover align-middle">
                    <thead class="table-turquesa text-white">
                        <tr>
                            <th>Código</th>
                            <th>Título del Proyecto</th>
                            <th>Autor</th>
                            <th>Estado Actual</th>
                            <th>Documentos</th>
                            <th class="text-center">Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td><strong>PRJ-001</strong></td>
                            <td>Sistema PROMETEO</td>
                            <td>Jorge Sals</td>
                            <td><span class="badge bg-warning text-dark">Pendiente</span></td>
                            <td>
                                <a href="#" class="text-decoration-none">📄 Propuesta_Inicial.pdf</a>
                            </td>
                            <td class="text-center">
                                <button type="button" class="btn btn-prometeo btn-sm" data-bs-toggle="modal" data-bs-target="#modalDetalle">
                                    👁️ Ver Detalle
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalDetalle" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" style="max-width: 800px;">
            <div class="modal-content" style="height: 800px;">
                <div class="modal-header shadow-sm" style="border-bottom: 2px solid #5bc0be;">
                    <h5 class="modal-title text-prometeo" id="exampleModalLabel">Detalles del Proyecto Seleccionado</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex justify-content-center align-items-center h-100">
                        <p class="text-muted italic">Información detallada del proyecto (Cargando...)</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-prometeo">Guardar Cambios</button>
                </div>
            </div>
        </div>
    </div>
</div>

</asp:Content>

