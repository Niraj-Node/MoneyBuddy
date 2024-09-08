using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.Configuration;

namespace MoneyBuddy
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                // If the user is logged in, redirect to login page
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text;
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                return;
            }

            // Hash the password for security
            string hashedPassword = HashPassword(password);

            string connectionString = WebConfigurationManager.ConnectionStrings["MoneyBuddyDBConnectionString"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE UserName = @UserName";
                string insertQuery = "INSERT INTO Users (UserName, Password) VALUES (@UserName, @Password)";
                SqlCommand checkCmd = new SqlCommand(checkUserQuery, con);
                checkCmd.Parameters.AddWithValue("@UserName", username);

                try
                {
                    con.Open();

                    int userExists = (int)checkCmd.ExecuteScalar();
                    if (userExists > 0)
                    {
                        lblMessage.Text = "Username already exists. Please choose another one.";
                        return;
                    }

                    SqlCommand cmd = new SqlCommand(insertQuery, con);
                    cmd.Parameters.AddWithValue("@UserName", username);
                    cmd.Parameters.AddWithValue("@Password", hashedPassword);
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "Registration successful. Redirecting to login page...";
                    int userId = (int) cmd.ExecuteScalar();
                    Session["UserId"] = userId;
                    Response.Redirect("Home.aspx");
                }
                catch (SqlException ex)
                {
                    lblMessage.Text = "Error occurred: " + ex.Message;
                }
            }
        }

        // Password hashing method using SHA256
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                {
                    sb.Append(b.ToString("x2"));
                }
                return sb.ToString();
            }
        }
    }
}
