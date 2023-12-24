<%@ Page Title="Авторизація" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <main aria-labelledby="title">
        <h2 style="text-align:center" id="title"><%: Title %>.</h2>
        <div style="display: flex; justify-content:center;">
            <section id="loginForm">
                <div>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="Email">Пошта</asp:Label>
                        <div>
                            <asp:TextBox runat="server" ID="Email" CssClass="textBox" TextMode="Email" /><br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="Пошта є обов'язковим полем." />
                        </div>
                    </div>
                    <div>
                        <asp:Label runat="server" AssociatedControlID="Password">Пароль</asp:Label>
                        <div>
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="textBox" /><br />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="Пароль є обов'язковим полем." />
                        </div>
                    </div>
                    <div>
                        <div>
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Запам'ятати мене?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div>
                            <asp:Button runat="server" OnClick="LogIn" Text="Авторизуватися" CssClass="button add-button" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Зареєструватися новим користувачем</asp:HyperLink>
                </p>
            </section>
        </div>

        <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders Visible="false" runat="server" ID="OpenAuthLogin" />
            </section>
        </div>
    </main>
</asp:Content>
