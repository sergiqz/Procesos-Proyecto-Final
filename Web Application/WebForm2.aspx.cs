using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using tienda_online_si.ServiceReference1;

namespace tienda_online_si
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            WebService1SoapClient webService = new WebService1SoapClient();

            int P1 = System.Convert.ToInt32(TextBox1.Text);
            string P2 = (TextBox2.Text);
            string P3 = (TextBox3.Text);
            string P4 = (TextBox4.Text);
            string P5 = (TextBox5.Text);
            string P6 = (TextBox6.Text);

            webService.Clientes_insertar(P1, P2, P3, P4, P5, P6);
            //Label1.Text = "Listado de clientes: " + webService.Clientes_insertar(P1,P2,P3,P4,P5,P6).ToString();
        }

    }
}