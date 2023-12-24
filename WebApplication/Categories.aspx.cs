using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

namespace WebApplication
{
    public partial class Categories : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                this.UpdateGridView();
            }
        }

        void UpdateGridView()
        {
            DataTable dtbl = new DataTable();
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();
            using (SqlConnection sqlCon = connection)
            {
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM Categories", sqlCon);
                sqlDa.Fill(dtbl);
            }
            if (dtbl.Rows.Count > 0)
            {
                GridViewCategories.DataSource = dtbl;
                GridViewCategories.DataBind();
            }
            else
            {
                dtbl.Rows.Add(dtbl.NewRow());
                GridViewCategories.DataSource = dtbl;
                GridViewCategories.DataBind();
                GridViewCategories.Rows[0].Cells.Clear();
                GridViewCategories.Rows[0].Cells.Add(new TableCell());
                GridViewCategories.Rows[0].Cells[0].ColumnSpan = dtbl.Columns.Count;
                GridViewCategories.Rows[0].Cells[0].Text = " ";
                GridViewCategories.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
            connection.Close();
        }

        protected void GridViewCategories_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewCategories.EditIndex = e.NewEditIndex;
            this.UpdateGridView();
        }

        protected void GridViewCategories_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewCategories.EditIndex = -1;
            this.UpdateGridView();
        }

        protected void GridViewCategories_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"UPDATE Categories SET Name=@Name WHERE ID = @id", connection);
                command.Parameters.AddWithValue("@Name", (GridViewCategories.Rows[e.RowIndex].FindControl("txtName") as TextBox).Text.Trim());
                command.Parameters.AddWithValue("@id", Convert.ToInt32(GridViewCategories.DataKeys[e.RowIndex].Value.ToString()));
                command.ExecuteNonQuery();
                GridViewCategories.EditIndex = -1;
                this.UpdateGridView();
                connection.Close();
            }
            catch
            {
                Response.Write("Не вдалося оновити інформацію, перевірте правильність введення.");
            }
        }

        protected void GridViewCategories_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"DELETE FROM Categories WHERE ID = @id", connection);
                command.Parameters.AddWithValue("@id", Convert.ToInt32(GridViewCategories.DataKeys[e.RowIndex].Value.ToString()));
                command.ExecuteNonQuery();
                this.UpdateGridView();
                connection.Close();
            }
            catch
            {
                Response.Write("Не вдалося видалити категорію, містяться зв'язані дані.");
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtNameFooter.Text.Trim();

                if (name == "")
                {
                    Response.Write("Ви не вказали назву категорії.");
                    return;
                }

                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"INSERT INTO Categories (Name) VALUES (@Name)", connection);
                command.Parameters.AddWithValue("@Name", name);
                command.ExecuteNonQuery();
                this.UpdateGridView();
                connection.Close();
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
    }
}