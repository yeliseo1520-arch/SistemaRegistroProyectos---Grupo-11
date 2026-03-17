using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SistemaRegistroProyectos
{
    public partial class Formulario_web12 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        
        //aca agrego esto para que cuando haga clic a la tarjeta de buscar proyecto muestre el panelBuscador AR-ALXRM
        protected void btnMostrarBuscador_Click(object sender, EventArgs e)
        {
            panelBuscador.Visible = true;
        }

        // aca agrego esto para que cuando haga clic al boton buscar del panelBuscador muestre el resultado de la busqueda AR-ALXRM
        protected void btnBuscar_Click(object sender, EventArgs e)
        {

        }
    }
}