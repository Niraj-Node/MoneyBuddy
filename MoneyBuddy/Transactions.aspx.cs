using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace MoneyBuddy
{
    public partial class Transactions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTransactions();
            }
        }

        private void LoadTransactions()
        {
            if (Session["UserId"] != null)
            {
                int userId = (int)Session["UserId"];
                string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    SqlCommand command = new SqlCommand("SELECT * FROM Transactions WHERE UserId = @UserId", connection);
                    command.Parameters.AddWithValue("@UserId", userId);

                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();
                    DataTable transactionsTable = new DataTable();
                    transactionsTable.Load(reader);

                    TransactionsGridView.DataSource = transactionsTable;
                    TransactionsGridView.DataBind();
                }
            }
        }

        protected void TransactionsGridView_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            TransactionsGridView.EditIndex = e.NewEditIndex;
            LoadTransactions();
        }

        protected void TransactionsGridView_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            TransactionsGridView.EditIndex = -1;
            LoadTransactions();
        }

        protected void TransactionsGridView_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            GridViewRow row = TransactionsGridView.Rows[e.RowIndex];
            int transactionId = Convert.ToInt32(TransactionsGridView.DataKeys[e.RowIndex].Values[0]);
            string description = (row.FindControl("txtDescription") as TextBox).Text;
            decimal amount = Convert.ToDecimal((row.FindControl("txtAmount") as TextBox).Text);
            DateTime transactionDate = Convert.ToDateTime((row.FindControl("txtTransactionDate") as TextBox).Text);

            string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("UPDATE Transactions SET Description = @Description, Amount = @Amount, TransactionDate = @TransactionDate WHERE TransactionId = @TransactionId", connection);
                command.Parameters.AddWithValue("@Description", description);
                command.Parameters.AddWithValue("@Amount", amount);
                command.Parameters.AddWithValue("@TransactionDate", transactionDate);
                command.Parameters.AddWithValue("@TransactionId", transactionId);

                connection.Open();
                command.ExecuteNonQuery();
            }

            TransactionsGridView.EditIndex = -1;
            LoadTransactions();
        }

        protected void TransactionsGridView_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int transactionId = Convert.ToInt32(TransactionsGridView.DataKeys[e.RowIndex].Values[0]);

            string connectionString = ConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("DELETE FROM Transactions WHERE TransactionId = @TransactionId", connection);
                command.Parameters.AddWithValue("@TransactionId", transactionId);

                connection.Open();
                command.ExecuteNonQuery();
            }

            LoadTransactions();
        }

        protected void btnAddTransaction_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddTransaction.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}
