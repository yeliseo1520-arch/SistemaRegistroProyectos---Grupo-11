using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaRegistroProyectos
{
    public partial class Formulario_web11 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
                CargarProyectos();
        }

        private void CargarProyectos()
        {
            string connStr = ConfigurationManager.ConnectionStrings["PrometeoConnectionString"].ConnectionString;

            string query = @"
                SELECT 
        p.ProyectoID,
        p.TituloProyecto,
        p.Descripcion,
        p.EstadoID,
        e.Nombres + ' ' + e.Apellidos  AS Autor,
        ep.Nombre                       AS Estado,
        d.NombreArchivo
    FROM Proyectos p
    INNER JOIN Estudiantes    est ON p.EstudianteID = est.EstudianteID
    INNER JOIN Usuarios        e  ON est.UsuarioID  = e.UsuarioID
    INNER JOIN EstadosProyecto ep ON p.EstadoID     = ep.EstadoID
    LEFT  JOIN DocumentosProyecto d ON p.ProyectoID = d.ProyectoID";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProyectos.DataSource = dt;
                gvProyectos.DataBind();
            }
        }

        // Colorea el badge según el estado
        protected void gvProyectos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.DataRow) return;

            Label lblEstado = (Label)e.Row.FindControl("lblEstado");
            if (lblEstado == null) return;

            switch (lblEstado.Text.Trim())
            {
                case "Pendiente":
                    lblEstado.CssClass = "badge bg-warning text-dark";
                    break;
                case "Aprobado":
                    lblEstado.CssClass = "badge bg-success";
                    break;
                case "Rechazado":
                    lblEstado.CssClass = "badge bg-danger";
                    break;
                default:
                    lblEstado.CssClass = "badge bg-secondary";
                    break;
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string comentario = txtObservacion.Text.Trim();
            int proyectoID = 0;
            int estadoID = 0;

            int.TryParse(hfProyectoID.Value, out proyectoID);
            int.TryParse(ddlEstado.SelectedValue, out estadoID);

            if (proyectoID == 0)
            {
                lblMensaje.Text = "⚠️ No se pudo identificar el proyecto.";
                lblMensaje.ForeColor = System.Drawing.Color.OrangeRed;
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PrometeoConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // 1. Actualiza el estado del proyecto
                string updateEstado = "UPDATE Proyectos SET EstadoID = @estadoID WHERE ProyectoID = @pid";
                using (SqlCommand cmd = new SqlCommand(updateEstado, conn))
                {
                    cmd.Parameters.AddWithValue("@estadoID", estadoID);
                    cmd.Parameters.AddWithValue("@pid", proyectoID);
                    cmd.ExecuteNonQuery();
                }

                // 2. Guarda la observación solo si escribió algo
                if (!string.IsNullOrEmpty(comentario))
                {
                    string insertObs = "INSERT INTO Observaciones (ProyectoID, Comentario, Fecha) VALUES (@pid, @com, GETDATE())";
                    using (SqlCommand cmd = new SqlCommand(insertObs, conn))
                    {
                        cmd.Parameters.AddWithValue("@pid", proyectoID);
                        cmd.Parameters.AddWithValue("@com", comentario);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            // Recarga la tabla para reflejar el nuevo estado
            CargarProyectos();

            txtObservacion.Text = "";
            lblMensaje.Text = "✅ Estado y observación guardados correctamente.";
            lblMensaje.ForeColor = System.Drawing.Color.SeaGreen;
        }
    }
}