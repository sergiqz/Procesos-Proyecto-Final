using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Oracle.DataAccess.Types;
using Oracle.DataAccess.Client;

namespace tienda_ultima
{
    /// <summary>
    /// Descripción breve de WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la línea siguiente. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hola a todos ";
        }


        [WebMethod]
        public string Clientes_insertar(int dni, string nombre, string apellido, string telefono, string correo,string contrasena)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_cliente(conn.GetConexion(), dni, nombre, apellido, telefono, correo, contrasena);

        }

        [WebMethod]
        public string Listado_de_productos()
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.lista_producto(conn.GetConexion());

        }

        [WebMethod]
        public string Listado_de_clientes()
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.lista_clientes(conn.GetConexion());

        }

        [WebMethod]
        public string Categoria_insertar(int ID, string NOMBRE_CATEGORIA, string DESCRI_CONTAC)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_categoria(conn.GetConexion(), ID,NOMBRE_CATEGORIA, DESCRI_CONTAC);

        }

        [WebMethod]
        public string direccion_compra_insertar(int ID, int Id_cliente, string TIPO, string DIRECCION, int NRO_LOTE, string DEPARTAMENTO, string URBANIZACION, string REFERENCIA, string Departamento1, string PROVINCIA, string DISTRITO, string pais, string postal)
        {
            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_dire_compra(conn.GetConexion(), ID, Id_cliente, TIPO, DIRECCION, NRO_LOTE, DEPARTAMENTO, URBANIZACION, REFERENCIA, Departamento1, PROVINCIA, DISTRITO, pais, postal);

        }

        [WebMethod]
        public string proveedor_insertar(string ID, string NOMBRE_PROVE, string NOMBRE_CONTAC, string PAIS, string TELEFONO)
        {

            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            pc.insert_proveedor(conn.GetConexion(),ID,NOMBRE_PROVE,NOMBRE_CONTAC,PAIS,TELEFONO);
            return "s";
        }

        [WebMethod]
        public string producto_insertar(int id_categoria, int ID_PROVEEDOR, string NOMBRE, int precio_unidad, string Peso, string Dimensiones, string Descripcion, int Descuento)
        {

            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_productos(conn.GetConexion(), id_categoria, ID_PROVEEDOR, NOMBRE, precio_unidad, Peso, Dimensiones, Descripcion, Descuento);

        }

        [WebMethod]
        public string direccion_factura_insertar(int ID, int Id_cliente, string razon_Social, int ruc, string direccion)
        {

            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_DIRECCIONES_FACTURACION(conn.GetConexion(), ID, Id_cliente, razon_Social, ruc, direccion);

        }

        [WebMethod]
        public string tarjeta_insertar(int ID, int Id_cliente, string NOMBRE_titular, string apellido_titular, string numero_tarjeta, int mes_expi, int anho_expi)
        {

            Oracle_conection conn = new Oracle_conection();
            conn.EstablecerConnection();

            Procedimientos pc = new Procedimientos();

            return pc.insert_tarjetas(conn.GetConexion(), ID, Id_cliente, NOMBRE_titular, apellido_titular, numero_tarjeta, mes_expi, anho_expi);

        }



    }
}
