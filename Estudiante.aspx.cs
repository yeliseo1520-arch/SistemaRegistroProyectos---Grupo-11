using System;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaRegistroProyectos
{
    public partial class Formulario_web1 : Page
    {
        string conexion = ConfigurationManager .ConnectionStrings["PrometeoConnectionString"] .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UsuarioID"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                CargarProyectos();
            }
        }

        /////////////////////// CODIGO PARA BOTON DE REGISTRAR PROYECTO ////////////////////////

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            int userID = Convert.ToInt32(Session["UsuarioID"]);

            int proyectoID = 0;

            ////////////////////////////// Para editar los proyectos del estudiante logeado/////////
            if (Session["ProyectoEditar"] != null)
            {
                int id = Convert.ToInt32(Session["ProyectoEditar"]);

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(@"
            UPDATE Proyectos SET
                NombreProyecto = @Nombre,
                TituloProyecto = @Titulo,
                Descripcion = @Descripcion,
                Objetivo = @Objetivo,
                AreaID = @Area,
                Tipo = @Tipo
            WHERE ProyectoID = @id", con);

                    cmd.Parameters.AddWithValue("@Nombre", txtNombreProyecto.Text);
                    cmd.Parameters.AddWithValue("@Titulo", txtTituloProyecto.Text);
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                    cmd.Parameters.AddWithValue("@Objetivo", txtObjetivo.Text);
                    cmd.Parameters.AddWithValue("@Area", ddlArea.SelectedValue);
                    cmd.Parameters.AddWithValue("@Tipo", ddlTipo.SelectedValue);
                    cmd.Parameters.AddWithValue("@id", id);

                    cmd.ExecuteNonQuery();
                }

                Session.Remove("ProyectoEditar");

                btnEnviar.Text = "Registrar Proyecto";

                Response.Write("<script>alert('Proyecto actualizado correctamente');</script>");
            }
            else
            {
                ///////////////Si no actualiza, lo inserta a la base/////////////

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    con.Open();

                    SqlCommand cmd = new SqlCommand(@"
            INSERT INTO Proyectos
            (UsuarioID, NombreProyecto, TituloProyecto,
             Descripcion, Objetivo,
             AreaID, Tipo, EstadoID)
            OUTPUT INSERTED.ProyectoID
            VALUES
            (@UsuarioID, @Nombre, @Titulo,
             @Descripcion, @Objetivo,
             @Area, @Tipo, 1)", con);

                    cmd.Parameters.AddWithValue("@UsuarioID", userID);
                    cmd.Parameters.AddWithValue("@Nombre", txtNombreProyecto.Text);
                    cmd.Parameters.AddWithValue("@Titulo", txtTituloProyecto.Text);
                    cmd.Parameters.AddWithValue("@Descripcion", txtDescripcion.Text);
                    cmd.Parameters.AddWithValue("@Objetivo", txtObjetivo.Text);
                    cmd.Parameters.AddWithValue("@Area", ddlArea.SelectedValue);
                    cmd.Parameters.AddWithValue("@Tipo", ddlTipo.SelectedValue);

                    proyectoID = Convert.ToInt32(cmd.ExecuteScalar());
                }

                ///////////Para subir el documento adjunto al proyecto////

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

            //////////////////Para dejar campos en limpio//////////

            txtNombreProyecto.Text = "";
            txtTituloProyecto.Text = "";
            txtDescripcion.Text = "";
            txtObjetivo.Text = "";
            ddlArea.SelectedIndex = 0;
            ddlTipo.SelectedIndex = 0;

            CargarProyectos();
        }

        void CargarProyectos()
        {
            int userID = Convert.ToInt32(Session["UsuarioID"]);

            using (SqlConnection con = new SqlConnection(conexion))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                SELECT 
                    p.ProyectoID,
                    p.NombreProyecto,
                    e.Nombre AS NombreEstado,
                    p.FechaEnvio,
                    ISNULL(o.Comentario,'Sin observaciones') AS Observacion,
                    d.RutaArchivo
                FROM Proyectos p
                INNER JOIN EstadosProyecto e ON p.EstadoID = e.EstadoID
                LEFT JOIN Observaciones o ON p.ProyectoID = o.ProyectoID
                LEFT JOIN DocumentosProyecto d ON p.ProyectoID = d.ProyectoID
                    WHERE p.UsuarioID = @id
                ORDER BY p.FechaEnvio desc", con);

                cmd.Parameters.AddWithValue("@id", userID);

                SqlDataReader dr = cmd.ExecuteReader();

                gvProyectos.DataSource = dr;
                gvProyectos.DataBind();
            }
        }
        protected void gvProyectos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ver")
            {
                string ruta = e.CommandArgument.ToString();
                Response.Redirect(ruta);
            }

            if (e.CommandName == "eliminar")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                using (SqlConnection con = new SqlConnection(conexion))
                {
                    con.Open();

                    SqlCommand cmd0 = new SqlCommand(
                        "DELETE FROM Observaciones WHERE ProyectoID=@id", con);
                    cmd0.Parameters.AddWithValue("@id", id);
                    cmd0.ExecuteNonQuery();

                    SqlCommand cmd1 = new SqlCommand(
                        "DELETE FROM DocumentosProyecto WHERE ProyectoID=@id", con);
                    cmd1.Parameters.AddWithValue("@id", id);
                    cmd1.ExecuteNonQuery();

                    SqlCommand cmd2 = new SqlCommand(
                        "DELETE FROM Proyectos WHERE ProyectoID=@id", con);
                    cmd2.Parameters.AddWithValue("@id", id);
                    cmd2.ExecuteNonQuery();
                }

                CargarProyectos();
            }

            if (e.CommandName == "editar")
            {
                int id = Convert.ToInt32(e.CommandArgument);

                Session["ProyectoEditar"] = id;

                EditarProyecto(id);
            }
            if (e.CommandName == "comentario")
            {
                lblComentario.Text = e.CommandArgument.ToString();
                pnlComentario.Visible = true;
            }
        }
        void EditarProyecto(int id)
        {
            using (SqlConnection con = new SqlConnection(conexion))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(@"
                SELECT NombreProyecto,TituloProyecto,
                       Descripcion,Objetivo,
                       AreaID,Tipo
                FROM Proyectos
                WHERE ProyectoID=@id", con);

                cmd.Parameters.AddWithValue("@id", id);

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    txtNombreProyecto.Text = dr["NombreProyecto"].ToString();
                    txtTituloProyecto.Text = dr["TituloProyecto"].ToString();
                    txtDescripcion.Text = dr["Descripcion"].ToString();
                    txtObjetivo.Text = dr["Objetivo"].ToString();
                    ddlArea.SelectedValue = dr["AreaID"].ToString();
                    ddlTipo.SelectedValue = dr["Tipo"].ToString();
                }
            }

            btnEnviar.Text = "Actualizar Proyecto";
        }
        protected void gvProyectos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string estado = DataBinder.Eval(e.Row.DataItem, "NombreEstado").ToString();

                if (estado == "Pendiente")
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff9c4"); // amarillo pastel
                }
                else if (estado == "Aprobado")
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#c8e6c9"); // verde pastel
                }
                else if (estado == "Rechazado")
                {
                    e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#ffcdd2"); // rojo pastel
                }
            }
        }
        protected void btnCerrarPopup_Click(object sender, EventArgs e)
        {
            pnlComentario.Visible = false;
        }
    }
}