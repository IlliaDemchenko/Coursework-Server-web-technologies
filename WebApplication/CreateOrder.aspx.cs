using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication.Account;

namespace WebApplication
{
    public partial class CreateOrder : System.Web.UI.Page
    {
        decimal price;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"SELECT * FROM Products WHERE ID = {Request.QueryString["id"]}", connection);
                var reader = command.ExecuteReader();
                string txt = "";
                if (reader.Read())
                {
                    txt += $"{reader["Name"]}<br />";
                    txt += $"{reader["Description"]}<br />";
                    txt += $"{reader["Price"]} грн.<br />";
                    this.price = (decimal)reader["Price"];
                }
                Label1.Text = txt;
                connection.Close();
            }
            catch
            {
                Response.Redirect("/");
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            try
            {
                Order order = new Order();
                this.Label2.Text = $"Всього: {order.РозрахуватиВартість(this.price, int.Parse(TextBox1.Text))} грн.";
            }
            catch
            {

            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand(
                    $"INSERT INTO Orders (ProductID, UserID, Count, Sum, Address) " +
                    $"VALUES " +
                    $"(@ProductID, @UserID, @Count, @Sum, @Address)",
                    connection);

                command.Parameters.AddWithValue("@ProductID", int.Parse(Request.QueryString["id"]));
                command.Parameters.AddWithValue("@UserID", Context.User.Identity.GetUserId());
                command.Parameters.AddWithValue("@Count", int.Parse(TextBox1.Text));
                command.Parameters.AddWithValue("@Sum", this.price * int.Parse(TextBox1.Text));
                command.Parameters.AddWithValue("@Address", TextBox2.Text);

                command.ExecuteNonQuery();
                connection.Close();
                Response.Redirect("/Orders");
            }
            catch
            {
                Response.Write("Виникла помилка при оформленні замовлення.");
            }
        }
    }
}