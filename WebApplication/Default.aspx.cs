using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"SELECT * FROM Categories", connection);
                var reader = command.ExecuteReader();
                RadioButtonList1.Items.Clear();
                RadioButtonList1.Items.Add(new ListItem(" Всі", "0"));
                RadioButtonList1.SelectedIndex = 0;
                while (reader.Read())
                {
                    RadioButtonList1.Items.Add(new ListItem(" " + (string)reader["Name"], reader["ID"].ToString()));
                }
                this.updateRepeater();
                connection.Close();
            }
        }

        void updateRepeater()
        {
            string where = RadioButtonList1.SelectedValue == "0" ? $"" : $" WHERE CategoryID = {RadioButtonList1.SelectedValue}";

            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();
            SqlCommand command = new SqlCommand($"SELECT * FROM Products{where}", connection);
            Repeater1.DataSource = command.ExecuteReader();
            Repeater1.DataBind();
            connection.Close();
        }

        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.updateRepeater();
        }

        protected void btnOrder_Click(object sender, EventArgs e)
        {
            var button = (Button)sender;
            Response.Redirect($"/CreateOrder?id={button.CommandArgument}");
        }
    }
}