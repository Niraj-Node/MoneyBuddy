<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="MoneyBuddy.Register" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="Content/style.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="register-box">
                <h2>Register</h2>
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
                    <asp:RegularExpressionValidator 
                        ID="revPassword" 
                        runat="server" 
                        ControlToValidate="txtPassword"
                        ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$"
                        ErrorMessage="Password must be at least 8 characters long and contain a number, a lowercase letter, and an uppercase letter" 
                        CssClass="error-message" 
                        Display="Dynamic" />
                </div>
                <div class="form-group">
                    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-primary" OnClick="btnRegister_Click" />
                </div>
                <div class="message">
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
                </div>
                <p class="login-link">Already have an account? <a href="Login.aspx">Login here</a>.</p>
            </div>
        </div>
    </form>
</body>
</html>
