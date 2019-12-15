<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="tienda_online_si.WebForm2" %>

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
               INSERTAR CLIENTE</div>
        <p>
            DNI:<asp:TextBox ID="TextBox1" runat="server" style="margin-left: 54px"></asp:TextBox>
        </p>
        <p>
            Nombre:<asp:TextBox ID="TextBox2" runat="server" style="margin-left: 25px"></asp:TextBox>
        </p>
        <p>
            Apellido:<asp:TextBox ID="TextBox3" runat="server" style="margin-left: 20px"></asp:TextBox>
        </p>
        <p>
            Telefono:<asp:TextBox ID="TextBox5" runat="server" style="margin-left: 18px"></asp:TextBox>
        </p>
        <p>
            Correo:<asp:TextBox ID="TextBox4" runat="server" style="margin-left: 33px"></asp:TextBox>
        </p>
        <p>
            Contraseña:<asp:TextBox ID="TextBox6" runat="server"></asp:TextBox>
        </p>
        <p>
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="ACEPTAR" style="margin-left: 208px" Width="142px" />
        </p>
        <p>
            &nbsp;</p>
    </form>
</body>
</html>
