using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tienda_online_si.ServiceReference1;


namespace tienda_online_si
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            WebService1SoapClient webService = new WebService1SoapClient();
            Label1.Text = "Lista de Productos: " + webService.Listado_de_productos().ToString();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            WebService1SoapClient webService = new WebService1SoapClient();
            Label1.Text = "Listado de clientes: " + webService.Listado_de_clientes().ToString();
        }


        protected void Button3_Click1(object sender, EventArgs e)
        {

        }
    }
}