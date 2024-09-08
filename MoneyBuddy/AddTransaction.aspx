<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddTransaction.aspx.cs" Inherits="MoneyBuddy.AddTransaction" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add Transaction</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
            overflow-x: hidden; /* Prevent horizontal scrolling */
        }

        /* Main Container */
        .container {
            margin: 80px auto 20px; /* Add top margin for fixed navbar */
            padding: 20px;
            width: 90%;
            max-width: 600px; /* Limit max width for form container */
            background: #fff; /* Add background to differentiate from body */
            border-radius: 8px; /* Rounded corners for container */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }

        /* Heading */
        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Form Group */
        .form-group {
            margin-bottom: 15px;
        }

        /* Labels */
        .form-group label {
            display: block;
            font-size: 16px;
            color: #333;
            margin-bottom: 5px;
        }

        /* Input Fields */
        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        /* Validators */
        .text-danger {
            color: #d9534f;
            font-size: 14px;
            margin-top: 5px;
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
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }
    </style>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Add New Transaction</h2>
            <div class="form-group">
                <label for="description">Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                    ControlToValidate="txtDescription" ErrorMessage="Description is required." 
                    CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label for="amount">Amount</label>
                <asp:TextBox ID="txtAmount" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvAmount" runat="server" 
                    ControlToValidate="txtAmount" ErrorMessage="Amount is required." 
                    CssClass="text-danger" Display="Dynamic" />
                <asp:RangeValidator ID="rvAmount" runat="server" 
                    ControlToValidate="txtAmount" MinimumValue="0.01" MaximumValue="1000000"
                    Type="Double" ErrorMessage="Amount must be between 0.01 and 1,000,000." 
                    CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <label for="transactionDate">Transaction Date</label>
                <asp:TextBox ID="txtTransactionDate" runat="server" CssClass="form-control" TextMode="Date" />
                <asp:RequiredFieldValidator ID="rfvTransactionDate" runat="server" 
                    ControlToValidate="txtTransactionDate" ErrorMessage="Transaction date is required." 
                    CssClass="text-danger" Display="Dynamic" />
                <asp:CompareValidator ID="cvTransactionDate" runat="server" 
                    ControlToValidate="txtTransactionDate" Operator="DataTypeCheck" Type="Date"
                    ErrorMessage="Please enter a valid date." CssClass="text-danger" Display="Dynamic" />
            </div>
            <div class="form-group">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-primary" OnClick="btnSubmit_Click" />
            </div>
        </div>
    </form>
</body>
</html>
