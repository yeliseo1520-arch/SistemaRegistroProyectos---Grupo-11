using System;
using System.Web.UI;

namespace SistemaRegistroProyectos 
{
    public partial class Admin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Seguridad: Aquí podrías validar si la sesión es de Admin
        }

        // Lógica de Paneles Dinámicos (Requisito: El formulario debe adaptarse)
        protected void ddlRol_SelectedIndexChanged(object sender, EventArgs e)
        {
            string rol = ddlRol.SelectedValue;
            pnlEstudiante.Visible = (rol == "Estudiante");
            pnlDocente.Visible = (rol == "Docente");
        }

        // Acción de Guardar (ADO.NET Insert)
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