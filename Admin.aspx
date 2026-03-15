<%@ Page Title="" Language="C#" MasterPageFile="~/Page.Master" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="SistemaRegistroProyectos.Admin" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container mt-4">
        <h2 class="text-center">Panel de Administración - PROMETEO</h2>
        <hr />

        <!-- 1. FORMULARIO DE REGISTRO (Con Paneles Dinámicos) -->
        <div class="card shadow-sm p-4 mb-5 bg-white rounded">
            <h4><i class="fas fa-user-plus"></i> Registrar Nuevo Usuario</h4>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label>Rol del Usuario:</label>
                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select" AutoPostBack="True" OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                        <asp:ListItem Text="-- Seleccione un Rol --" Value="" />
                        <asp:ListItem Text="Estudiante" Value="Estudiante" />
                        <asp:ListItem Text="Docente" Value="Docente" />
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvRol" runat="server" ControlToValidate="ddlRol" InitialValue="" ErrorMessage="* El rol es obligatorio" ForeColor="Red" ValidationGroup="vgRegistrar" Display="Dynamic" />
                </div>
            </div>

            <!-- Campos Comunes -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <asp:TextBox ID="txtNombres" runat="server" CssClass="form-control" placeholder="Nombres"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNombres" ErrorMessage="* Nombre requerido" ForeColor="Red" ValidationGroup="vgRegistrar" Display="Dynamic" />
                </div>
                <div class="col-md-6 mb-3">
                    <asp:TextBox ID="txtApellidos" runat="server" CssClass="form-control" placeholder="Apellidos"></asp:TextBox>
                </div>
                <div class="col-md-12 mb-3">
                    <asp:TextBox ID="txtCorreo" runat="server" CssClass="form-control" placeholder="Correo institucional (@mail.utec.edu.sv)"></asp:TextBox>
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtCorreo" ValidationExpression="^[\w-\.]+@mail\.utec\.edu\.sv$" ErrorMessage="* Formato de correo UTEC inválido" ForeColor="Red" ValidationGroup="vgRegistrar" Display="Dynamic" />
                </div>
            </div>

            <!-- PANEL DINÁMICO PARA ESTUDIANTES -->
            <asp:Panel ID="pnlEstudiante" runat="server" Visible="false" CssClass="border p-3 mb-3 bg-light">
                <h5>Datos de Estudiante</h5>
                <div class="row">
                    <div class="col-md-6">
                        <asp:TextBox ID="txtCarnet" runat="server" CssClass="form-control" placeholder="Carnet (Ej: 29-0000-202X)"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtCarrera" runat="server" CssClass="form-control" placeholder="Carrera"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>

            <!-- PANEL DINÁMICO PARA DOCENTES -->
            <asp:Panel ID="pnlDocente" runat="server" Visible="false" CssClass="border p-3 mb-3 bg-light">
                <h5>Datos de Docente</h5>
                <div class="row">
                    <div class="col-md-6">
                        <asp:TextBox ID="txtCodigoEmpleado" runat="server" CssClass="form-control" placeholder="Código de Empleado"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <asp:TextBox ID="txtFacultad" runat="server" CssClass="form-control" placeholder="Facultad / Especialidad"></asp:TextBox>
                    </div>
                </div>
            </asp:Panel>

            <div class="text-end">
                <asp:Button ID="btnRegistrar" runat="server" Text="Guardar Usuario" CssClass="btn btn-success" ValidationGroup="vgRegistrar" OnClick="btnRegistrar_Click" />
                <asp:Label ID="lblStatus" runat="server" CssClass="d-block mt-2"></asp:Label>
            </div>
        </div>

        <!-- 2. FILTRO DE BÚSQUEDA (Requisito 6) -->
        <div class="row mb-3">
            <div class="col-md-9">
                <asp:TextBox ID="txtBuscar" runat="server" CssClass="form-control shadow-sm" placeholder="Buscar por nombre o correo..."></asp:TextBox>
            </div>
            <div class="col-md-3">
                <asp:Button ID="btnFiltrar" runat="server" Text="🔍 Filtrar" CssClass="btn btn-primary w-100" OnClick="btnFiltrar_Click" />
            </div>
        </div>

        <!-- 3. GRIDVIEW DE GESTIÓN (CRUD) -->
        <div class="table-responsive">
            <asp:GridView ID="gvUsuarios" runat="server" CssClass="table table-striped table-hover shadow-sm" AutoGenerateColumns="False" DataKeyNames="UsuarioID" DataSourceID="dsUsuarios">
                <Columns>
                    <asp:BoundField DataField="UsuarioID" HeaderText="ID" ReadOnly="True" InsertVisible="False" />
                    <asp:BoundField DataField="Nombres" HeaderText="Nombre" />
                    <asp:BoundField DataField="Correo" HeaderText="Correo" />
                    <asp:BoundField DataField="Rol" HeaderText="Rol" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ButtonType="Button" ControlStyle-CssClass="btn btn-sm btn-outline-secondary" />
                </Columns>
            </asp:GridView>
        </div>

        <!-- SQL DATA SOURCE (El puente ADO.NET) -->
        <asp:SqlDataSource ID="dsUsuarios" runat="server" 
            ConnectionString="<%$ ConnectionStrings:PrometeoConnectionString %>" 
            SelectCommand="SELECT [UsuarioID], [Nombres], [Correo], [Rol] FROM [Usuarios]"
            FilterExpression="Nombres LIKE '%{0}%' OR Correo LIKE '%{0}%'"
            InsertCommand="INSERT INTO [Usuarios] (Nombres, Apellidos, Correo, Contraseña, Rol, Carnet, Carrera, CodigoEmpleado, Facultad) VALUES (@Nombres, @Apellidos, @Correo, 'Utec123', @Rol, @Carnet, @Carrera, @CodigoEmpleado, @Facultad)"
            DeleteCommand="DELETE FROM [Usuarios] WHERE [UsuarioID] = @UsuarioID"
            UpdateCommand="UPDATE [Usuarios] SET [Nombres] = @Nombres, [Correo] = @Correo WHERE [UsuarioID] = @UsuarioID" ProviderName="<%$ ConnectionStrings:PrometeoConnectionString.ProviderName %>">
            <DeleteParameters>
                <asp:Parameter Name="UsuarioID" />
            </DeleteParameters>
            <FilterParameters>
                <asp:ControlParameter ControlID="txtBuscar" Name="Nombres" PropertyName="Text" />
            </FilterParameters>
            <InsertParameters>
                <asp:ControlParameter ControlID="txtNombres" Name="Nombres" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtApellidos" Name="Apellidos" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtCorreo" Name="Correo" PropertyName="Text" />
                <asp:ControlParameter ControlID="ddlRol" Name="Rol" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="txtCarnet" Name="Carnet" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtCarrera" Name="Carrera" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtCodigoEmpleado" Name="CodigoEmpleado" PropertyName="Text" />
                <asp:ControlParameter ControlID="txtFacultad" Name="Facultad" PropertyName="Text" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="Nombres" />
                <asp:Parameter Name="Correo" />
                <asp:Parameter Name="UsuarioID" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
</asp:Content>
