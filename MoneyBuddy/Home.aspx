<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="MoneyBuddy.Home" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Home</title>
    <style>
        /* General Styles */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
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

        /* Main Container */
        .container {
            margin: 80px auto 20px; /* Add top margin to account for fixed navbar */
            padding: 20px;
            width: 90%;
            max-width: 1200px; /* Limit max width for container */
        }

        /* Home Box */
        .home-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        /* Heading */
        h2 {
            font-size: 24px;
            color: #333;
            margin-bottom: 20px;
            text-align: center;
        }

        /* Statistics Section */
        .statistics {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .stat-box {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin: 10px;
            flex: 1 1 calc(50% - 20px); /* Adjust to fit two boxes per row */
            box-sizing: border-box;
        }

        .stat-box h3 {
            margin: 0 0 10px;
            font-size: 20px;
            color: #333;
        }

        .stat-value {
            font-size: 18px;
            color: #555;
        }
    </style>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>
<body>
    <div class="navbar">
        <a href="Home.aspx">Home</a>
        <a href="Transactions.aspx">Transactions</a>
        <a href="Logout.aspx">Logout</a>
    </div>
    <div class="container">
        <div class="home-box">
            <h2>Welcome, <asp:Label ID="lblUsername" runat="server" /></h2>
            <div class="statistics">
                <div class="stat-box">
                    <h3>Total Transactions</h3>
                    <asp:Label ID="lblTotalTransactions" runat="server" CssClass="stat-value" />
                </div>
                <div class="stat-box">
                    <h3>Average Transaction Amount</h3>
                    <asp:Label ID="lblAverageAmount" runat="server" CssClass="stat-value" />
                </div>
                <div class="stat-box">
                    <h3>Monthly Breakdown</h3>
                    <asp:Label ID="lblMonthlyBreakdown" runat="server" CssClass="stat-value" />
                </div>
                <div class="stat-box">
                    <h3>Weekly Statistics</h3>
                    <asp:Label ID="lblWeeklyStats" runat="server" CssClass="stat-value" />
                </div>
            </div>
        </div>
    </div>
</body>
</html>
