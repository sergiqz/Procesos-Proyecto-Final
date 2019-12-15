<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs" Inherits="tienda_online_si.WebForm3" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
               <asp:Label ID="Label1" runat="server" Text=" "></asp:Label> 
               INSERTAR PROVEEDOR</div>
        <p>
            ID:<asp:TextBox ID="TextBox1" runat="server" style="margin-left: 158px" MaxLength="10"></asp:TextBox>
        </p>
        <p>
            Nombre Proveedor:<asp:TextBox ID="TextBox2" runat="server" style="margin-left: 25px"></asp:TextBox>
        </p>
        <p>
            Nombre Contacto:<asp:TextBox ID="TextBox3" runat="server" style="margin-left: 39px"></asp:TextBox>
        </p>
        <p>
            Pais:<asp:TextBox ID="TextBox5" runat="server" style="margin-left: 145px"></asp:TextBox>
        </p>
        <p>
            Telefono:<asp:TextBox ID="TextBox4" runat="server" style="margin-left: 105px"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="ACEPTAR" style="margin-left: 208px" Width="142px" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
