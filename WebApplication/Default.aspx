<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication._Default" EnableEventValidation="false" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <h4>Фільтр за категоріями</h4>
        <asp:RadioButtonList ID="RadioButtonList1" runat="server" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" AutoPostBack="true">
            <asp:ListItem>Всі</asp:ListItem>
        </asp:RadioButtonList>

    <div class="maindiv">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>

                <div class="product-container">
                    <div class="product-name">
                        <span><strong><%# Eval("Name") %></strong></span>
                    </div>
                    <div class="product-description">
                        <span><%# Eval("Description") %></span>
                    </div>
                    <div class="product-price">
                        <span>Вартість: <%# Eval("Price") %> грн</span></div>
                    <div class="order-button">
                        <asp:Button Visible="<%# Context.User.Identity.GetUserId() != null %>" CommandArgument=<%# Eval("ID") %> CssClass="buttonOrder" ID="btnOrder" runat="server" Text="Замовити" OnClick="btnOrder_Click" />
                        <asp:Label Visible="<%# Context.User.Identity.GetUserId() == null %>" runat="server" Text="Для замовлення необхідна авторизація"></asp:Label>
                    </div>
                </div>

            </ItemTemplate>
        </asp:Repeater>


    </div>

</asp:Content>
