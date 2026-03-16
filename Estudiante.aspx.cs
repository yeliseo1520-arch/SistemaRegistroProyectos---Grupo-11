using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace SistemaRegistroProyectos
{
    public partial class Formulario_web1 : Page
    {
        string conexion = ConfigurationManager .ConnectionStrings["PrometeoConnectionString"] .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        /////////////////////// CODIGO PARA BOTON DE REGISTRAR PROYECTO ////////////////////////

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            int estudianteID = Convert.ToInt32(Session["EstudianteID"]);

            int proyectoID = 0;

            using (SqlConnection con = new SqlConnection(conexion))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Proyectos
                (EstudianteID, NombreProyecto, TituloProyecto,
                 DescripcionGeneral, ObjetivoGeneral,
                 AreaID, TipoProyecto, EstadoID)
                OUTPUT INSERTED.ProyectoID
                VALUES
                (@EstudianteID, @Nombre, @Titulo,
                 @Descripcion, @Objetivo,
                 @Area, @Tipo, 1)", con);

                cmd.Parameters.AddWithValue("@EstudianteID", estudianteID);
                cmd.Parameters.AddWithValue("@Nombre", txtNombreProyecto.Text);
                cmd.Parameters.AddWithValue("@Titulo", txtTituloProyecto.Text);
                cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                cmd.Parameters.AddWithValue("@Objetivo", txtObjetivo.Text);
                cmd.Parameters.AddWithValue("@Area", ddlArea.SelectedValue);
                cmd.Parameters.AddWithValue("@Tipo", ddlTipo.SelectedValue);

                proyectoID = Convert.ToInt32(cmd.ExecuteScalar());
            }

            /////////////////////// CODIGO PARA SUBIR DOCUMENTO ////////////////////////

            if (fileInicial.HasFile)
            {
                string carpeta = Server.MapPath("~/Documentos/");

                if (!Directory.Exists(carpeta))
                    Directory.CreateDirectory(carpeta);

                string nombre = Guid.NewGuid().ToString() +
                                Path.GetExtension(fileInicial.FileName);

                string rutaFisica = carpeta + nombre;

                fileInicial.SaveAs(rutaFisica);

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO DocumentosProyecto
                    (ProyectoID, NombreArchivo, RutaArchivo)
                    VALUES
                    (@ProyectoID, @Nombre, @Ruta)", con);

                    cmd.Parameters.AddWithValue("@ProyectoID", proyectoID);
                    cmd.Parameters.AddWithValue("@Nombre", fileInicial.FileName);
                    cmd.Parameters.AddWithValue("@Ruta", "~/Documentos/" + nombre);

                    cmd.ExecuteNonQuery();
                }
            }

            Response.Write("<script>alert('Proyecto registrado correctamente');</script>");
        }
    }
}