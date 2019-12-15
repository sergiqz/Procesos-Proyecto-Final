<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="tienda_online_si.WebForm1" %>

<!DOCTYPE html>  
  
<html xmlns="http://www.w3.org/1999/xhtml">  
<head runat="server">  
    <title></title>  
</head>  
<body style="height: 301px">  
    <form id="form1" runat="server">  
        <div>  
            <asp:Button ID="Button1" runat="server" Text="Lista de Productos" OnClick="Button1_Click" style="height: 26px" /><asp:Label ID="Label1" runat="server" Text=" "></asp:Label>  
        </div>  
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Lista de Clientes" />
        </p>
        <p>
            &nbsp;</p>
        <p>
            <asp:Button ID="Button3" runat="server"  Text="INSERTAR CLIENTE" PostBackUrl="WebForm2.aspx" OnClick="Button3_Click1" />
        </p>
    </form>  
</body>  
</html>  
