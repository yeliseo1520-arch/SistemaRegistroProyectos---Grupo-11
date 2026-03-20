using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.UI.WebControls.WebParts;

namespace SistemaRegistroProyectos
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Agrego esto para que el panelBuscador esté oculto al cargar la página por primera vez, y solo se muestre cuando se haga clic en el botón de buscar proyecto. AR-ALXRM
             
            if (!IsPostBack)
            {
                CargarEstadisticas();
            }
        }

        void CargarEstadisticas()
        {
            string connString = ConfigurationManager.ConnectionStrings["PrometeoConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string query = @"
        SELECT
        COUNT(*) AS Creados,
        COUNT(*) AS Total,
        SUM(CASE WHEN E.Nombre = 'Pendiente' THEN 1 ELSE 0 END) AS Pendientes,
        SUM(CASE WHEN E.Nombre = 'Aprobado' THEN 1 ELSE 0 END) AS Aprobados,
        SUM(CASE WHEN E.Nombre = 'Rechazado' THEN 1 ELSE 0 END) AS Rechazados,
        SUM(CASE WHEN E.Nombre = 'En revisión' THEN 1 ELSE 0 END) AS Activos
        FROM Proyectos P
        INNER JOIN EstadosProyecto E
        ON P.EstadoID = E.EstadoID";

                SqlCommand cmd = new SqlCommand(query, conn);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    lblCreados.Text = reader["Creados"].ToString();
                    lblTotal.Text = reader["Total"].ToString();
                    lblPendientes.Text = reader["Pendientes"].ToString();
                    lblAprobados.Text = reader["Aprobados"].ToString();
                    lblRechazados.Text = reader["Rechazados"].ToString();
                    lblActivos.Text = reader["Activos"].ToString();
                }
            }
        }

        //aca agrego esto para que cuando haga clic a la tarjeta de buscar proyecto muestre el panelBuscador AR-ALXRM
        protected void btnMostrarBuscador_Click(object sender, EventArgs e)
        {
            panelBuscador.Visible = true;
        }

        // aca agrego esto para que cuando haga clic al boton buscar del panelBuscador muestre el resultado de la busqueda AR-ALXRM
        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            string conexion = System.Configuration.ConfigurationManager
        .ConnectionStrings["PrometeoConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(conexion))
            {
                string query = @"SELECT 
                    P.ProyectoID,
                    P.NombreProyecto,
                    P.TituloProyecto,
                    (U.Nombres + ' ' + U.Apellidos) AS Estudiante, -- Cambio aquí
                    E.Nombre AS Estado,
                    CASE 
                        WHEN P.Tipo = 'I' THEN 'Individual'
                        WHEN P.Tipo = 'G' THEN 'Grupal'
                    END AS TipoProyecto,
                    D.NombreArchivo
                    FROM Proyectos P
                    INNER JOIN EstadosProyecto E ON P.EstadoID = E.EstadoID
                    INNER JOIN Usuarios U ON P.UsuarioID = U.UsuarioID -- Cambio de JOIN aquí
                    LEFT JOIN DocumentosProyecto D ON P.ProyectoID = D.ProyectoID
                    WHERE (P.NombreProyecto LIKE @nombre OR @nombre = '')
                    AND (E.Nombre = @estado OR @estado = '')";


                SqlCommand cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@nombre", "%" + txtBuscarProyecto.Text + "%");
                cmd.Parameters.AddWithValue("@estado", ddlEstadoFiltro.SelectedValue);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                da.Fill(dt);

                gvBusquedaProyectos.DataSource = dt;
                gvBusquedaProyectos.DataBind();
                //Para que la pagina baje de un solo cuando busque un proyecto AR-ALXRM
                ScriptManager.RegisterStartupScript(this, this.GetType(), "scroll", "location.hash='#buscador';", true);
            }
        }
    }
}