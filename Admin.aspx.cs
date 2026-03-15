using System;
using System.Web.UI;

namespace SistemaRegistroProyectos 
{
    public partial class Admin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //  aqui hacemos esto por seguridad (Siempre se verifica)
            if (Session["Rol"] == null || Session["Rol"].ToString() != "Administrador")
            {
                Response.Redirect("~/Login.aspx");
                return;
            }

            //  cargamos los datos (Solo la primera vez)
            if (!IsPostBack)
            {
                // Aqui vamos a mostrar quien inicio sesion.
                lblStatus.Text = "Bienvenido al Centro de Control, " + Session["Usuario"].ToString();
                lblStatus.ForeColor = System.Drawing.Color.Gray;

                // Y ocultamos los paneles de estudiante y docente hasta que se seleccione un rol.
                pnlEstudiante.Visible = false;
                pnlDocente.Visible = false;
            }
        }

        // aplicaciones de paneles dinamicos para que el formulario se adapte
        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            string rol = ddlRol.SelectedValue;
            pnlEstudiante.Visible = (rol == "Estudiante");
            pnlDocente.Visible = (rol == "Docente");
        }

        // Aqui aplicamos el guardado osea (ADO.NET Insert)
        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            try
            {
                dsUsuarios.Insert(); // Llama al comando del SqlDataSource
                lblStatus.Text = "✅ Usuario guardado exitosamente.";
                lblStatus.ForeColor = System.Drawing.Color.Green;
                LimpiarCampos();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error: " + ex.Message;
                lblStatus.ForeColor = System.Drawing.Color.Red;
            }
        }

        // Acción de Filtrar
        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            gvUsuarios.DataBind(); // Actualiza el GridView usando el FilterExpression del SqlDataSource
        }

        private void LimpiarCampos()
        {
            txtNombres.Text = "";
            txtApellidos.Text = "";
            txtCorreo.Text = "";
            txtCarnet.Text = "";
            txtCarrera.Text = "";
            txtCodigoEmpleado.Text = "";
            txtFacultad.Text = "";
            ddlRol.SelectedIndex = 0;
            pnlEstudiante.Visible = false;
            pnlDocente.Visible = false;
        }
    }
}