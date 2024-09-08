<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="MoneyBuddy.Transactions" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Transactions</title>
    <style>
         /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            overflow-x: hidden; /* Prevent horizontal scroll */
        }

        /* Navigation Bar */
        .navbar {
            display: flex;
            justify-content: center;
            background-color: #0056b3;
            padding: 10px 0;
            border-bottom: 2px solid #004494;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-size: 16px;
        }

        .navbar a:hover {
            text-decoration: underline;
        }

        /* Main Content */
        .container {
            margin: 80px auto 20px; /* Add top margin to account for fixed navbar */
            padding: 20px;
            width: 90%;
            max-width: 1200px;
        }

        /* Heading */
        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
        }

        /* GridView */
        .transactions-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto; /* Enable horizontal scrolling if needed */
        }

        .transactions-grid th, .transactions-grid td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .transactions-grid th {
            background-color: #f4f4f4;
        }

        /* Form Controls */
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Button */
        .btn-primary {
            background-color: #007bff;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
            display: block;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        /* Error Messages */
        .text-danger {
            color: #d9534f;
            font-size: 14px;
        }

     </style>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="navbar">
            <a href="Home.aspx">Home</a>
            <a href="Transactions.aspx">Transactions</a>
            <a href="Logout.aspx">Logout</a>
        </div>
        <div class="container">
            <h2>Your Transactions</h2>
            <asp:GridView ID="TransactionsGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="TransactionId"
                OnRowEditing="TransactionsGridView_RowEditing" OnRowCancelingEdit="TransactionsGridView_RowCancelingEdit"
                OnRowUpdating="TransactionsGridView_RowUpdating" OnRowDeleting="TransactionsGridView_RowDeleting" CssClass="transactions-grid">
                <Columns>
                    <asp:BoundField DataField="TransactionId" HeaderText="Transaction ID" ReadOnly="True" />
                    <asp:TemplateField HeaderText="Description">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="txtDescription" ErrorMessage="Description is required." CssClass="text-danger" Display="Dynamic" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Description") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Amount">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAmount" runat="server" ControlToValidate="txtAmount" ErrorMessage="Amount is required." CssClass="text-danger" Display="Dynamic" />
                            <asp:RangeValidator ID="rvAmount" runat="server" ControlToValidate="txtAmount" MinimumValue="0.01" MaximumValue="1000000" Type="Double" ErrorMessage="Amount must be between 0.01 and 1,000,000." CssClass="text-danger" Display="Dynamic" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("Amount") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Transaction Date">
                        <EditItemTemplate>
                            <asp:TextBox ID="txtTransactionDate" runat="server" Text='<%# Bind("TransactionDate", "{0:yyyy-MM-dd}") %>' CssClass="form-control" TextMode="Date"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTransactionDate" runat="server" ControlToValidate="txtTransactionDate" ErrorMessage="Transaction date is required." CssClass="text-danger" Display="Dynamic" />
                            <asp:CompareValidator ID="cvTransactionDate" runat="server" ControlToValidate="txtTransactionDate" Operator="DataTypeCheck" Type="Date" ErrorMessage="Please enter a valid date." CssClass="text-danger" Display="Dynamic" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <%# Eval("TransactionDate", "{0:yyyy-MM-dd}") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>

            <asp:Button ID="btnAddTransaction" runat="server" Text="Add New Transaction" CssClass="btn-primary" OnClick="btnAddTransaction_Click" />
        </div>
    </form>
</body>
</html>
