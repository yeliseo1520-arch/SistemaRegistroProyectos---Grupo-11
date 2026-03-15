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
            if (!IsPostBack)
            {
                // Si el usuario está logueado y es Administrador, mostramos la pestaña
                if (Session["Rol"] != null && Session["Rol"].ToString() == "Administrador")
                {
                    lnkAdmin.Visible = true;
                }
            }
        }
    }
}