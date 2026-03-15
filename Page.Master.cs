using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaRegistroProyectos
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // esto es para mantenerr el menú consistente con el rol del usuario.

            if (Session["Rol"] != null && Session["Rol"].ToString() == "Administrador")
            {
                lnkAdmin.Visible = true;
            }
            else
            {
                lnkAdmin.Visible = false;
            }
        }
    }
}