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
                    CONCAT(ES.Nombres,' ',ES.Apellidos) AS Estudiante,
                    E.Nombre AS Estado,
                    CASE 
                        WHEN P.Tipo = 'I' THEN 'Individual'
                        WHEN P.Tipo = 'G' THEN 'Grupal'
                    END AS TipoProyecto,
                    D.NombreArchivo
                    FROM Proyectos P
                    INNER JOIN EstadosProyecto E 
                        ON P.EstadoID = E.EstadoID
                    INNER JOIN Estudiantes ES
                        ON P.EstudianteID = ES.EstudianteID
                    LEFT JOIN DocumentosProyecto D
                        ON P.ProyectoID = D.ProyectoID
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
                //Para que la pagina baje de un solo cuando busque AR-ALXRM
                ScriptManager.RegisterStartupScript(this, this.GetType(), "scroll", "location.hash='#buscador';", true);
            }
        }
    }
}