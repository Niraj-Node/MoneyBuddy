using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace MoneyBuddy
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUserData();
                LoadStatistics();
            }
        }

        private void LoadUserData()
        {
            // Assuming UserId is stored in Session
            if (Session["UserId"] != null)
            {
                int userId = (int)Session["UserId"];
                string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT Username FROM Users WHERE UserId = @UserId", connection);
                    command.Parameters.AddWithValue("@UserId", userId);

                    connection.Open();
                    object result = command.ExecuteScalar();
                    if (result != null)
                    {
                        lblUsername.Text = result.ToString();
                    }
                }
            }
        }

        private void LoadStatistics()
        {
            // Assuming UserId is stored in Session
            if (Session["UserId"] != null)
            {
                int userId = (int)Session["UserId"];
                string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    // Total Transactions
                    SqlCommand totalCommand = new SqlCommand("SELECT COUNT(*) FROM Transactions WHERE UserId = @UserId", connection);
                    totalCommand.Parameters.AddWithValue("@UserId", userId);
                    lblTotalTransactions.Text = totalCommand.ExecuteScalar().ToString();

                    // Average Transaction Amount
                    SqlCommand avgCommand = new SqlCommand("SELECT ISNULL(AVG(Amount), 0) FROM Transactions WHERE UserId = @UserId", connection);
                    avgCommand.Parameters.AddWithValue("@UserId", userId);
                    lblAverageAmount.Text = avgCommand.ExecuteScalar().ToString();

                    // Monthly Breakdown
                    SqlCommand monthlyCommand = new SqlCommand("SELECT FORMAT(TransactionDate, 'MMMM yyyy') AS Month, COUNT(*) AS Transactions FROM Transactions WHERE UserId = @UserId GROUP BY FORMAT(TransactionDate, 'MMMM yyyy')", connection);
                    monthlyCommand.Parameters.AddWithValue("@UserId", userId);
                    SqlDataReader monthlyReader = monthlyCommand.ExecuteReader();
                    DataTable monthlyTable = new DataTable();
                    monthlyTable.Load(monthlyReader);
                    lblMonthlyBreakdown.Text = DataTableToHtml(monthlyTable);

                    // Weekly Statistics
                    SqlCommand weeklyCommand = new SqlCommand("SELECT DATEPART(week, TransactionDate) AS Week, COUNT(*) AS Transactions FROM Transactions WHERE UserId = @UserId GROUP BY DATEPART(week, TransactionDate)", connection);
                    weeklyCommand.Parameters.AddWithValue("@UserId", userId);
                    SqlDataReader weeklyReader = weeklyCommand.ExecuteReader();
                    DataTable weeklyTable = new DataTable();
                    weeklyTable.Load(weeklyReader);
                    lblWeeklyStats.Text = DataTableToHtml(weeklyTable);
                }
            }
        }

        private string DataTableToHtml(DataTable table)
        {
            string html = "<table>";
            html += "<tr>";
            foreach (DataColumn column in table.Columns)
            {
                html += $"<th>{column.ColumnName}</th>";
            }
            html += "</tr>";

            foreach (DataRow row in table.Rows)
            {
                html += "<tr>";
                foreach (var item in row.ItemArray)
                {
                    html += $"<td>{item}</td>";
                }
                html += "</tr>";
            }
            html += "</table>";

            return html;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }

        protected void btnTransactions_Click(object sender, EventArgs e)
        {
            Response.Redirect("Transactions.aspx");
        }
    }
}
