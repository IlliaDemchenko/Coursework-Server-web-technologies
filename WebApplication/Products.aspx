<%@ Page Title="Товари" Language="C#" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="WebApplication.Products" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="product-grid">
            <h4>Новий товар</h4>
            <hr />

            <asp:TextBox placeholder="Назва" CssClass="textBox" ID="txtNameFooter" runat="server" />
            <asp:DropDownList CssClass="dropDownList" ID="DropDownList3" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
            <asp:TextBox placeholder="Опис" CssClass="textBox" ID="txtDescriptionFooter" runat="server" />
            <asp:TextBox placeholder="Ціна" CssClass="textBox" ID="txtPriceFooter" runat="server" />
            <asp:Button CssClass="button add-button" Text="Додати" runat="server" OnClick="Unnamed_Click" />

            <h4>Список товарів</h4>
            <hr />
            <asp:GridView ID="GridViewProducts" runat="server" AutoGenerateColumns="false" ShowFooter="true" DataKeyNames="ID"
                ShowHeaderWhenEmpty="true" OnRowEditing="GridViewProducts_RowEditing"
                OnRowCancelingEdit="GridViewProducts_RowCancelingEdit" OnRowDataBound="GridViewProducts_RowDataBound"
                OnRowUpdating="GridViewProducts_RowUpdating" OnRowDeleting="GridViewProducts_RowDeleting"
                BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">

                <Columns>
                    <asp:TemplateField HeaderText="Назва">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtName" Text='<%# Eval("Name") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Категорія">
                        <ItemTemplate>
                            <asp:DropDownList CssClass="dropDownList" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList CssClass="dropDownList" ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID"></asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Опис">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Description") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtDescription" Text='<%# Eval("Description") %>' runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Ціна">
                        <ItemTemplate>
                            <asp:Label Text='<%# Eval("Price") %>' runat="server" CssClass="grid-label" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox CssClass="textBox" ID="txtPrice" Text='<%# Eval("Price") %>' runat="server" />
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
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DefaultConnection %>" DeleteCommand="DELETE FROM [Categories] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Categories] ([Name]) VALUES (@Name)" SelectCommand="SELECT * FROM [Categories]" UpdateCommand="UPDATE [Categories] SET [Name] = @Name WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>