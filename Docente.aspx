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
                    <asp:GridView ID="gvProyectos" runat="server"
                        AutoGenerateColumns="false"
                        CssClass="table table-hover align-middle"
                        GridLines="None"
                        OnRowDataBound="gvProyectos_RowDataBound">
                        <HeaderStyle CssClass="table-turquesa text-white" />
                        <Columns>
                            <asp:BoundField DataField="ProyectoID"      HeaderText="Código"             ItemStyle-CssClass="fw-bold" />
                            <asp:BoundField DataField="TituloProyecto"  HeaderText="Título del Proyecto" />
                            <asp:BoundField DataField="Autor"           HeaderText="Autor" />
                            <asp:TemplateField HeaderText="Estado Actual">
                                <ItemTemplate>
                                    <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Documentos">
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlDocumento" runat="server"
                                        NavigateUrl='<%# "~/Documentos/" + Eval("NombreArchivo") %>'
                                        Text='<%# "📄 " + Eval("NombreArchivo") %>'
                                        CssClass="text-decoration-none"
                                        Target="_blank">
                                    </asp:HyperLink>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Acción" ItemStyle-CssClass="text-center">
                                <ItemTemplate>
                                    <button type="button"
                                        class="btn btn-prometeo btn-sm"
                                        data-bs-toggle="modal"
                                        data-bs-target="#modalDetalle"
                                        data-id='<%# Eval("ProyectoID") %>'
                                        data-titulo='<%# Eval("TituloProyecto") %>'
                                        data-autor='<%# Eval("Autor") %>'
                                        data-estado='<%# Eval("Estado") %>'
                                        data-estadoid='<%# Eval("EstadoID") %>'
                                        data-descripcion='<%# Eval("Descripcion") %>'
                                        onclick="cargarModal(this)">
                                        👁️ Ver Detalle
                                    </button>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataTemplate>
                            <p class="text-muted text-center py-3">No hay proyectos registrados.</p>
                        </EmptyDataTemplate>
                    </asp:GridView>
                </div>
            </div>
        </div>


        <%-- MODAL --%>
<div class="modal fade" id="modalDetalle" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" style="max-width: 750px;">
        <div class="modal-content border-0 shadow-lg">
            
            <%-- HEADER --%>
            <div class="modal-header" style="background: linear-gradient(135deg, #3d9a8b, #5bc0be); color: white;">
                <div class="d-flex align-items-center gap-2">
                    <span style="font-size:1.4rem;">📋</span>
                    <h5 class="modal-title mb-0 fw-bold" id="modalLabel">Detalles del Proyecto</h5>
                </div>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <%-- BODY --%>
            <div class="modal-body p-4">

                <%-- Info del proyecto en cards --%>
                <div class="row g-3 mb-4">
                    <div class="col-md-3">
                        <div class="info-card">
                            <span class="info-label">🔖 Código</span>
                            <span id="modalId" class="info-value fw-bold"></span>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="info-card">
                            <span class="info-label">📁 Título</span>
                            <span id="modalTitulo" class="info-value"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-card">
                            <span class="info-label">👤 Autor</span>
                            <span id="modalAutor" class="info-value"></span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="info-card">
                            <span class="info-label">📌 Estado</span>
                            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-select form-select-sm mt-1"
                                Style="border-color: #5bc0be; color: #2d2d2d;">
                                <asp:ListItem Value="1">Pendiente</asp:ListItem>
                                <asp:ListItem Value="2">En revisión</asp:ListItem>
                                <asp:ListItem Value="3">Aprobado</asp:ListItem>
                                <asp:ListItem Value="4">Rechazado</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="info-card">
                            <span class="info-label">📝 Descripción</span>
                            <span id="modalDescripcion" class="info-value text-muted"></span>
                        </div>
                    </div>
                </div>

                <%-- Separador --%>
                <hr style="border-color: #5bc0be;" />

                <%-- Sección Observaciones --%>
                <div class="mb-2">
                    <label class="fw-bold mb-2" style="color:#3d9a8b;">
                        💬 Agregar Observación
                    </label>
                    <asp:TextBox ID="txtObservacion" runat="server"
                        TextMode="MultiLine"
                        Rows="4"
                        CssClass="form-control"
                        placeholder="Escribe aquí tu observación o comentario sobre el proyecto..."
                        style="resize:vertical; border-color:#5bc0be;">
                    </asp:TextBox>
                    <asp:HiddenField ID="hfProyectoID" runat="server" Value="0" />
                    <asp:Label ID="lblMensaje" runat="server" CssClass="mt-2 d-block" style="font-size:0.9rem;"></asp:Label>
                </div>

            </div>

            <%-- FOOTER --%>
            <div class="modal-footer" style="border-top: 2px solid #e9ecef;">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    ✖ Cerrar
                </button>
                <asp:Button ID="btnGuardar" runat="server"
                    Text="💾 Guardar Observación"
                    CssClass="btn btn-prometeo"
                    OnClick="btnGuardar_Click"
                    OnClientClick="prepararGuardado()" />
            </div>

        </div>
    </div>
</div>




    </div>


    <script>
        // Llena el modal y sincroniza el HiddenField antes del postback

        function cargarModal(btn) {
            document.getElementById('modalId').textContent = btn.getAttribute('data-id');
            document.getElementById('modalTitulo').textContent = btn.getAttribute('data-titulo');
            document.getElementById('modalAutor').textContent = btn.getAttribute('data-autor');
            document.getElementById('modalDescripcion').textContent = btn.getAttribute('data-descripcion');

            // Selecciona el estado actual en el DropDownList
            const estadoId = btn.getAttribute('data-estadoid');
            const ddl = document.getElementById('<%= ddlEstado.ClientID %>');
            ddl.value = estadoId;

            // Guarda el ID del proyecto en el HiddenField
            document.getElementById('<%= hfProyectoID.ClientID %>').value = btn.getAttribute('data-id');

    // Limpia textarea y mensaje
    document.getElementById('<%= txtObservacion.ClientID %>').value = '';
            document.getElementById('<%= lblMensaje.ClientID %>').textContent = '';
        }

    // Mantiene el modal abierto tras el postback si hay mensaje
    window.onload = function () {
        const msg = document.getElementById('<%= lblMensaje.ClientID %>').textContent.trim();
            if (msg !== '') {
                var modal = new bootstrap.Modal(document.getElementById('modalDetalle'));
                modal.show();
            }
        };
    </script>


</asp:Content>