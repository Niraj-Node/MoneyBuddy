using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.Configuration;

namespace MoneyBuddy
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                // If the user is already logged in, redirect to the home page
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
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
                string checkUserQuery = "SELECT COUNT(*) FROM Users WHERE UserName = @UserName AND Password = @Password";
                SqlCommand cmd = new SqlCommand(checkUserQuery, con);
                cmd.Parameters.AddWithValue("@UserName", username);
                cmd.Parameters.AddWithValue("@Password", hashedPassword);

                try
                {
                    con.Open();

                    int userExists = (int)cmd.ExecuteScalar();

                    if (userExists > 0)
                    {
                        lblMessage.Text = "Login successful. Redirecting...";
                        int userId = userExists;
                        Session["UserId"] = userId;
                        Response.Redirect("Home.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password.";
                    }
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
