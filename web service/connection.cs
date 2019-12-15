using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Oracle.DataAccess.Client;
using System.Web.Services;
using Oracle.DataAccess.Types;
using System.Data;
using Newtonsoft.Json;

namespace tienda_ultima
{
    public class Oracle_conection
    {
        OracleConnection oc;
        string oradb = "DATA SOURCE=localhost:1521/xe;PERSIST SECURITY INFO=True;USER ID=TIENDA_FINAL; PASSWORD=admin";
        public Oracle_conection()
        {
        }

        public void EstablecerConnection()
        {
            oc = new OracleConnection(oradb);
            oc.Open();

        }

        public OracleConnection GetConexion()
        {
            return oc;
        }
    }
}