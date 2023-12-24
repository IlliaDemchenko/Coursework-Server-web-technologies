<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="WebApplication.CreateOrder" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="order-form">
        <asp:Label ID="Label1" runat="server" Text="" CssClass="form-label"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" placeholder="Кількість" OnTextChanged="TextBox1_TextChanged" AutoPostBack="true" CssClass="form-input"></asp:TextBox><br />
        <asp:TextBox ID="TextBox2" runat="server" placeholder="Адреса доставки" CssClass="form-input"></asp:TextBox><br />
        <asp:Label ID="Label2" runat="server" Text="" CssClass="form-label"></asp:Label>
        <asp:Button ID="Button1" runat="server" Text="Замовити" OnClick="Button1_Click" CssClass="submit-button" />
    </div>
</asp:Content>