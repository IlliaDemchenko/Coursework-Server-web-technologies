<%@ Page Title="Категорії" Language="C#" AutoEventWireup="true" CodeBehind="Categories.aspx.cs" Inherits="WebApplication.Categories" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="category-grid">
            <h4>Нова категорія</h4>
            <hr />

            <asp:TextBox CssClass="textBox" ID="txtNameFooter" runat="server" />
            <asp:Button CssClass="button add-button" Text="Додати" runat="server" OnClick="Unnamed_Click" />
            <h4>Список категорій</h4>
            <hr />

            <asp:GridView ID="GridViewCategories" runat="server" AutoGenerateColumns="false" ShowFooter="true" DataKeyNames="ID"
                ShowHeaderWhenEmpty="true" OnRowEditing="GridViewCategories_RowEditing" OnRowCancelingEdit="GridViewCategories_RowCancelingEdit"
                OnRowUpdating="GridViewCategories_RowUpdating" OnRowDeleting="GridViewCategories_RowDeleting"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">

                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtName" Text='<%# Eval("Name") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button CssClass="button edit-button" Text="Редагувати" runat="server" CommandName="Edit" ToolTip="Edit" />
                            <asp:Button CssClass="button delete-button" Text="Видалити" runat="server" CommandName="Delete" ToolTip="Delete" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:Button CssClass="button update-button" Text="Оновити" runat="server" CommandName="Update" ToolTip="Update" />
                            <asp:Button CssClass="button cancel-button" Text="Відмінити" runat="server" CommandName="Cancel" ToolTip="Cancel" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
