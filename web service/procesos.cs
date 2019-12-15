using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Client;
using Newtonsoft.Json;
using System.Data;

namespace tienda_ultima
{
    public class Procedimientos
    {

        public Procedimientos()
        {

        }
        public string insert_cliente(OracleConnection conn, int dni, string nombre, string apellido, string telefono, string correo, string contrasena)
        {

            OracleParameter dni_ora = new OracleParameter();
            dni_ora.OracleDbType = OracleDbType.Int16;
            dni_ora.Value = dni;

            OracleParameter nombre_ora = new OracleParameter();
            nombre_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_ora.Value = nombre;

            OracleParameter direccion_ora = new OracleParameter();
            direccion_ora.OracleDbType = OracleDbType.Varchar2;
            direccion_ora.Value = apellido;

            OracleParameter telefono_ora = new OracleParameter();
            telefono_ora.OracleDbType = OracleDbType.Varchar2;
            telefono_ora.Value = telefono;

            OracleParameter correo_ora = new OracleParameter();
            correo_ora.OracleDbType = OracleDbType.Varchar2;
            correo_ora.Value = correo;

            OracleParameter contrasena_ora = new OracleParameter();
            contrasena_ora.OracleDbType = OracleDbType.Varchar2;
            contrasena_ora.Value = contrasena;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_cliente";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int64).Value = 145678;//dni_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Varchar2).Value = nombre_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = direccion_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Varchar2).Value = telefono_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Varchar2).Value = correo_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Varchar2).Value = contrasena_ora.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Cliente insertado";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }


        public string lista_producto(OracleConnection conn)
        {

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "select nombre,PRECIO_UNIDAD,dimensiones,DESCRIPCION from productos;";

            cmd.CommandType = System.Data.CommandType.Text;
     

            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);
            conn.Dispose();

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }

        public string lista_clientes(OracleConnection conn)
        {

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "select * from cliente;";

            cmd.CommandType = System.Data.CommandType.Text;


            DataSet ds = new DataSet();
            OracleDataAdapter da = new OracleDataAdapter(cmd);
            da.Fill(ds);
            conn.Dispose();

            return JsonConvert.SerializeObject(ds, Newtonsoft.Json.Formatting.Indented);
        }


        public string insert_categoria(OracleConnection conn, int ID, string NOMBRE_CATEGORIA, string DESCRI_CONTAC)
        {


            OracleParameter id_ora = new OracleParameter();
            id_ora.OracleDbType = OracleDbType.Int16;
            id_ora.Value = ID;

            OracleParameter nombre_ora = new OracleParameter();
            nombre_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_ora.Value = NOMBRE_CATEGORIA;

            OracleParameter descripcion_ora = new OracleParameter();
            descripcion_ora.OracleDbType = OracleDbType.Varchar2;
            descripcion_ora.Value = DESCRI_CONTAC;

            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_categoria";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int64).Value = id_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Varchar2).Value = nombre_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = descripcion_ora.Value;

            cmd.ExecuteNonQuery();

            string respuesta = "Categoria insertada";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        public string insert_dire_compra(OracleConnection conn, int ID, int Id_cliente, string TIPO, string DIRECCION, int NRO_LOTE,string DEPARTAMENTO,string URBANIZACION,string REFERENCIA, string Departamento1,string PROVINCIA,string DISTRITO,string pais,string postal)
        {

            OracleParameter id_ora = new OracleParameter();
            id_ora.OracleDbType = OracleDbType.Int32;
            id_ora.Value = ID;

            OracleParameter id_cliente_ora = new OracleParameter();
            id_cliente_ora.OracleDbType = OracleDbType.Int32;
            id_cliente_ora.Value = Id_cliente;

            OracleParameter tipo_ora = new OracleParameter();
            tipo_ora.OracleDbType = OracleDbType.Varchar2;
            tipo_ora.Value = TIPO;

            OracleParameter dire_ora = new OracleParameter();
            dire_ora.OracleDbType = OracleDbType.Varchar2;
            dire_ora.Value = DIRECCION;

            OracleParameter num_lote_ora = new OracleParameter();
            num_lote_ora.OracleDbType = OracleDbType.Int32;
            num_lote_ora.Value = NRO_LOTE;

            OracleParameter departa_ora = new OracleParameter();
            departa_ora.OracleDbType = OracleDbType.Varchar2;
            departa_ora.Value = DEPARTAMENTO;

            OracleParameter urba_ora = new OracleParameter();
            urba_ora.OracleDbType = OracleDbType.Varchar2;
            urba_ora.Value = URBANIZACION;

            OracleParameter referencia_ora = new OracleParameter();
            referencia_ora.OracleDbType = OracleDbType.Varchar2;
            referencia_ora.Value = REFERENCIA;

            OracleParameter departamento_ora = new OracleParameter();
            departamento_ora.OracleDbType = OracleDbType.Varchar2;
            departamento_ora.Value = Departamento1;

            OracleParameter refe_ora = new OracleParameter();
            refe_ora.OracleDbType = OracleDbType.Varchar2;
            refe_ora.Value = REFERENCIA;

            OracleParameter provincia_ora = new OracleParameter();
            provincia_ora.OracleDbType = OracleDbType.Varchar2;
            provincia_ora.Value = PROVINCIA;

            OracleParameter distri_ora = new OracleParameter();
            distri_ora.OracleDbType = OracleDbType.Varchar2;
            distri_ora.Value = DISTRITO;

            OracleParameter pais_ora = new OracleParameter();
            pais_ora.OracleDbType = OracleDbType.Varchar2;
            pais_ora.Value = pais;

            OracleParameter postal_ora = new OracleParameter();
            postal_ora.OracleDbType = OracleDbType.Varchar2;
            postal_ora.Value = postal;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_dire_compra";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int64).Value = id_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Int32).Value = id_cliente_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = tipo_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Varchar2).Value = dire_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Int32).Value = num_lote_ora.Value;
            cmd.Parameters.Add("PV6", OracleDbType.Varchar2).Value = departa_ora.Value;
            cmd.Parameters.Add("PV7", OracleDbType.Varchar2).Value = urba_ora.Value;
            cmd.Parameters.Add("PV8", OracleDbType.Varchar2).Value = referencia_ora.Value;
            cmd.Parameters.Add("PV9", OracleDbType.Varchar2).Value = departamento_ora.Value;
            cmd.Parameters.Add("PV7", OracleDbType.Varchar2).Value = refe_ora.Value;
            cmd.Parameters.Add("PV8", OracleDbType.Varchar2).Value = provincia_ora.Value;
            cmd.Parameters.Add("PV9", OracleDbType.Varchar2).Value = distri_ora.Value;
            cmd.Parameters.Add("PV10", OracleDbType.Varchar2).Value = pais_ora.Value;
            cmd.Parameters.Add("PV11", OracleDbType.Varchar2).Value = postal_ora.Value;

            cmd.ExecuteNonQuery();

            string respuesta = "Direccion insertada";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }



        public void insert_proveedor(OracleConnection conn, string ID, string NOMBRE_PROVE, string NOMBRE_CONTAC,string PAIS,string TELEFONO)
        {

            OracleParameter id_ora = new OracleParameter();
            id_ora.OracleDbType = OracleDbType.Varchar2;
            id_ora.Value = ID;

            OracleParameter nombre_ora = new OracleParameter();
            nombre_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_ora.Value = NOMBRE_PROVE;

            OracleParameter nombre_conta_ora = new OracleParameter();
            nombre_conta_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_conta_ora.Value = NOMBRE_CONTAC;

            OracleParameter pais_ora = new OracleParameter();
            pais_ora.OracleDbType = OracleDbType.Varchar2;
            pais_ora.Value = PAIS;

            OracleParameter telefono_ora = new OracleParameter();
            telefono_ora.OracleDbType = OracleDbType.Varchar2;
            telefono_ora.Value = TELEFONO;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_proveedor";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Varchar2).Value = id_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Varchar2).Value = nombre_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = nombre_conta_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Varchar2).Value = pais_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Varchar2).Value = telefono_ora.Value;

            cmd.ExecuteNonQuery();

            string respuesta = "Proveedor insertada";
            conn.Dispose();

            return; //JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        public string insert_productos(OracleConnection conn, int id_categoria, int ID_PROVEEDOR, string NOMBRE, int precio_unidad, string Peso,string Dimensiones ,string Descripcion ,int Descuento )
        {

            OracleParameter idcate_ora = new OracleParameter();
            idcate_ora.OracleDbType = OracleDbType.Int32;
            idcate_ora.Value = id_categoria;

            OracleParameter id_prove_ora = new OracleParameter();
            id_prove_ora.OracleDbType = OracleDbType.Int32;
            id_prove_ora.Value = ID_PROVEEDOR;

            OracleParameter nombre_ora = new OracleParameter();
            nombre_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_ora.Value = NOMBRE;

            OracleParameter precio_ora = new OracleParameter();
            precio_ora.OracleDbType = OracleDbType.Int32;
            precio_ora.Value = precio_unidad;

            OracleParameter peso_ora = new OracleParameter();
            peso_ora.OracleDbType = OracleDbType.Varchar2;
            peso_ora.Value = Peso;

            OracleParameter dimensi_ora = new OracleParameter();
            dimensi_ora.OracleDbType = OracleDbType.Varchar2;
            dimensi_ora.Value = Dimensiones;

            OracleParameter descri_ora = new OracleParameter();
            descri_ora.OracleDbType = OracleDbType.Varchar2;
            descri_ora.Value = Descripcion;

            OracleParameter descuento_ora = new OracleParameter();
            descuento_ora.OracleDbType = OracleDbType.Int32;
            descuento_ora.Value = Descuento;


            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_productos";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int64).Value = idcate_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Int16).Value = id_prove_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = nombre_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Int32).Value = precio_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Varchar2).Value = peso_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = dimensi_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Varchar2).Value = descri_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Int32).Value = descuento_ora.Value;

            cmd.ExecuteNonQuery();

            string respuesta = "Producto insertado";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        public string insert_DIRECCIONES_FACTURACION(OracleConnection conn, int ID, int Id_cliente, string razon_Social, int ruc, string direccion)
        {
            OracleParameter id_ora = new OracleParameter();
            id_ora.OracleDbType = OracleDbType.Int32;
            id_ora.Value = ID;

            OracleParameter id_cli_ora = new OracleParameter();
            id_cli_ora.OracleDbType = OracleDbType.Int32;
            id_cli_ora.Value = Id_cliente;

            OracleParameter razonso_ora = new OracleParameter();
            razonso_ora.OracleDbType = OracleDbType.Varchar2;
            razonso_ora.Value = razon_Social;

            OracleParameter ruc_ora = new OracleParameter();
            ruc_ora.OracleDbType = OracleDbType.Int32;
            ruc_ora.Value = ruc;

            OracleParameter dire_ora = new OracleParameter();
            dire_ora.OracleDbType = OracleDbType.Varchar2;
            dire_ora.Value = direccion;



            OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_DIRECCIONES_FACTURACION";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int32).Value = id_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Int32).Value = id_cli_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = razonso_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Int32).Value = ruc_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Varchar2).Value = dire_ora.Value;

            cmd.ExecuteNonQuery();

            string respuesta = "Direccion de Factura insertado";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }

        public string insert_tarjetas(OracleConnection conn, int ID, int Id_cliente, string NOMBRE_titular, string apellido_titular, string numero_tarjeta, int mes_expi,int anho_expi)
        {
            OracleParameter id_ora = new OracleParameter();
            id_ora.OracleDbType = OracleDbType.Int32;
            id_ora.Value = ID;

            OracleParameter id_cli_ora = new OracleParameter();
            id_cli_ora.OracleDbType = OracleDbType.Int32;
            id_cli_ora.Value = Id_cliente;

            OracleParameter nombre_titu_ora = new OracleParameter();
            nombre_titu_ora.OracleDbType = OracleDbType.Varchar2;
            nombre_titu_ora.Value = NOMBRE_titular;

            OracleParameter apelli_ora = new OracleParameter();
            apelli_ora.OracleDbType = OracleDbType.Varchar2;
            apelli_ora.Value = apellido_titular;

            OracleParameter numero_tar_ora = new OracleParameter();
            numero_tar_ora.OracleDbType = OracleDbType.Varchar2;
            numero_tar_ora.Value = numero_tarjeta;

            OracleParameter mes_expi_ora = new OracleParameter();
            mes_expi_ora.OracleDbType = OracleDbType.Int32;
            mes_expi_ora.Value = mes_expi;

            OracleParameter anho_expi_ora = new OracleParameter();
            anho_expi_ora.OracleDbType = OracleDbType.Int32;
            anho_expi_ora.Value = anho_expi;


             OracleCommand cmd = new OracleCommand();
            cmd.Connection = conn;
            cmd.CommandText = "insert_tarjetas";
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add("PV1", OracleDbType.Int32).Value = id_ora.Value;
            cmd.Parameters.Add("PV2", OracleDbType.Int32).Value = id_cli_ora.Value;
            cmd.Parameters.Add("PV3", OracleDbType.Varchar2).Value = nombre_titu_ora.Value;
            cmd.Parameters.Add("PV4", OracleDbType.Varchar2).Value = apelli_ora.Value;
            cmd.Parameters.Add("PV5", OracleDbType.Int32).Value = numero_tar_ora.Value;
            cmd.Parameters.Add("PV6", OracleDbType.Int32).Value = mes_expi_ora.Value;
            cmd.Parameters.Add("PV7", OracleDbType.Int32).Value = anho_expi_ora.Value;
            cmd.ExecuteNonQuery();

            string respuesta = "Tarjeta insertado";
            conn.Dispose();

            return JsonConvert.SerializeObject(respuesta, Newtonsoft.Json.Formatting.Indented);
        }


    }
}