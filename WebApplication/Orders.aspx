<%@ Page Title="Мої замовлення" Language="C#" AutoEventWireup="true" CodeBehind="Orders.aspx.cs" Inherits="WebApplication.Orders" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="product-grid">
            <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="false" ShowFooter="true" DataKeyNames="ID"
                ShowHeaderWhenEmpty="true" OnRowDataBound="GridViewOrders_RowDataBound"
                
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">

                <Columns>
                    <asp:TemplateField HeaderText="Товар">
                        <ItemTemplate>
                            <asp:DropDownList Enabled="false" CssClass="dropDownList" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList Enabled="false" CssClass="dropDownList" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Кількість">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Count") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtName" Text='<%# Eval("Count") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Сума">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Sum") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtDescription" Text='<%# Eval("Sum") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Адреса доставки">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Address") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtPrice" Text='<%# Eval("Address") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>

    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" SelectCommand="SELECT * FROM [Products]">
    </asp:SqlDataSource>
</asp:Content>