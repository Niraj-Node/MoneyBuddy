using System;
using System.Configuration;
using System.Data.SqlClient;

namespace MoneyBuddy
{
    public partial class AddTransaction : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
{
    if (Page.IsValid)
    {
        string description = txtDescription.Text;
        decimal amount = Convert.ToDecimal(txtAmount.Text);
        DateTime transactionDate = Convert.ToDateTime(txtTransactionDate.Text);

        // Retrieve the UserId from the session
        int userId = Convert.ToInt32(Session["UserId"]);

        string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "INSERT INTO Transactions (UserId, Description, Amount, TransactionDate) VALUES (@UserId, @Description, @Amount, @TransactionDate)";
            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Description", description);
            cmd.Parameters.AddWithValue("@Amount", amount);
            cmd.Parameters.AddWithValue("@TransactionDate", transactionDate);

            connection.Open();
            cmd.ExecuteNonQuery();
        }

        // Redirect to the transactions page after the successful insert
        Response.Redirect("Transactions.aspx");
    }
}

    }
}
