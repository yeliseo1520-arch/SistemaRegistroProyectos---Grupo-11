using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient; // Necesario para ADO.NET
using System.Configuration; // Necesario para leer Web.config

namespace SistemaRegistroProyectos
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                Session.Clear(); // Limpiamos cualquier rastro al entrar al Login
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Limpiar mensaje de error previo
            lblError.Text = "";

            // Aquí vamos a obtener la conexión del Web.config
            string connString = ConfigurationManager.ConnectionStrings["PrometeoConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connString))
            {
                // Hacemos la consulta SQL con parámetros
                // Buscamos que coincida Correo, Contraseña y el Rol seleccionado
                string query = "SELECT UsuarioID, Nombres, Rol FROM Usuarios WHERE Correo = @Correo AND Contraseña = @Pass AND Rol = @Rol";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Correo", txtUsuario.Text.Trim());
                cmd.Parameters.AddWithValue("@Pass", txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@Rol", ddlPerfil.SelectedValue);

                try
                {
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read()) // Si el usuario existe y los datos coinciden
                    {
                        // Guardamos en Sesión
                        Session["Usuario"] = dr["Nombres"].ToString();
                        Session["UsuarioID"] = dr["UsuarioID"].ToString();
                        Session["Rol"] = dr["Rol"].ToString();

                        // Redireccionamos según el rol
                        string rol = Session["Rol"].ToString();

                        if (rol == "Administrador")
                        {
                            Response.Redirect("~/Admin.aspx");
                        }
                        else if (rol == "Docente")
                        {
                            Response.Redirect("~/Docente.aspx");
                        }
                        else if (rol == "Estudiante")
                        {
                            Response.Redirect("~/Estudiante.aspx");
                        }
                    }
                    else
                    {
                        // Si no hay coincidencias
                        lblError.Text = "❌ Usuario, contraseña o rol incorrectos.";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error de conexión: " + ex.Message;
                }
            }
        }
    }
}