using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tienda_online_si.ServiceReference1;


namespace tienda_online_si
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            WebService1SoapClient webService = new WebService1SoapClient();

            string P1 = (TextBox1.Text.Trim());
            string P2 = (TextBox2.Text.Trim());
            string P3 = (TextBox3.Text.Trim());
            string P4 = (TextBox4.Text.Trim());
            string P5 = (TextBox5.Text.Trim());
            webService.proveedor_insertar(P1, P2, P3, P4, P5);
            //Label1.Text = "Insertado proveedor : " + webService.proveedor_insertar(P1, P2, P3, P4, P5).ToString();
        }
    }
}