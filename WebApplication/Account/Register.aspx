<%@ Page Title="Реєстрація" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 style="text-align: center" id="title"><%: Title %>.</h2>
        <div style="display: flex; justify-content:center;">
        <div>

        <p class="text-danger">
            <asp:Literal runat="server" ID="ErrorMessage" />
        </p>
        <h4>Створення нового акаунта</h4>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div>
            <asp:Label runat="server" AssociatedControlID="Email" >Електронна пошта</asp:Label>
            <div>
                <asp:TextBox runat="server" ID="Email" CssClass="textBox" TextMode="Email" /><br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                    CssClass="text-danger" ErrorMessage="Пошта є обов'язковою." />
            </div>
        </div>
        <div>
            <asp:Label runat="server" AssociatedControlID="Password" >Пароль</asp:Label>
            <div>
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="textBox" /><br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="Пароль є обов'язковим." />
            </div>
        </div>
        <div>
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" >Підтвердження пароля</asp:Label>
            <div>
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="textBox" /><br />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Необхідно обов'язково підтвердити пароль." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Паролі не співпадають." />
            </div>
        </div>
        <div>
            <div>
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Зареєструватися" CssClass="button cancel-button" />
            </div>
        </div>
            </div>
            </div>
    </main>
</asp:Content>
