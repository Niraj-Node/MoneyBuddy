<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="MoneyBuddy.Login" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="Content/style.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="login-box">
                <h2>Login</h2>
                <div class="form-group">
                    <label for="txtUsername">Username:</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="input-field" />
                    <asp:RequiredFieldValidator 
                        ID="rfvUsername" 
                        runat="server" 
                        ControlToValidate="txtUsername"
                        ErrorMessage="Username is required" 
                        CssClass="error-message" 
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <label for="txtPassword">Password:</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input-field" />
                    <asp:RequiredFieldValidator 
                        ID="rfvPassword" 
                        runat="server" 
                        ControlToValidate="txtPassword"
                        ErrorMessage="Password is required" 
                        CssClass="error-message" 
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" />
                </div>
                <div class="message">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
                </div>
                <p class="register-link">Don't have an account? <a href="Register.aspx">Register here</a>.</p>
            </div>
        </div>
    </form>
</body>
</html>
