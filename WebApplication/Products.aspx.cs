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
    public partial class Products : System.Web.UI.Page
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
            SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
            connection.Open();
            DataTable dtbl = new DataTable();
            using (SqlConnection sqlCon = connection)
            {
                SqlDataAdapter sqlDa = new SqlDataAdapter("SELECT * FROM Products", sqlCon);
                sqlDa.Fill(dtbl);
            }
            if (dtbl.Rows.Count > 0)
            {
                GridViewProducts.DataSource = dtbl;
                GridViewProducts.DataBind();
            }
            else
            {
                dtbl.Rows.Add(dtbl.NewRow());
                GridViewProducts.DataSource = dtbl;
                GridViewProducts.DataBind();
                GridViewProducts.Rows[0].Cells.Clear();
                GridViewProducts.Rows[0].Cells.Add(new TableCell());
                GridViewProducts.Rows[0].Cells[0].ColumnSpan = dtbl.Columns.Count;
                GridViewProducts.Rows[0].Cells[0].Text = " ";
                GridViewProducts.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
            connection.Close();
        }

        protected void GridViewProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridViewProducts.EditIndex = e.NewEditIndex;
            this.UpdateGridView();
        }

        protected void GridViewProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridViewProducts.EditIndex = -1;
            this.UpdateGridView();
        }

        protected void GridViewProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"UPDATE Products SET CategoryID=@CategoryID, Name=@Name, Description=@Description, Price=@Price WHERE ID = @id", connection);
                command.Parameters.AddWithValue("@CategoryID", (GridViewProducts.Rows[e.RowIndex].FindControl("DropDownList2") as DropDownList).SelectedValue);
                command.Parameters.AddWithValue("@Name", (GridViewProducts.Rows[e.RowIndex].FindControl("txtName") as TextBox).Text.Trim());
                command.Parameters.AddWithValue("@Description", (GridViewProducts.Rows[e.RowIndex].FindControl("txtDescription") as TextBox).Text.Trim());
                command.Parameters.AddWithValue("@Price", (GridViewProducts.Rows[e.RowIndex].FindControl("txtPrice") as TextBox).Text.Replace(',', '.').Trim());
                command.Parameters.AddWithValue("@id", Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value.ToString()));
                command.ExecuteNonQuery();
                GridViewProducts.EditIndex = -1;
                this.UpdateGridView();
                connection.Close();
            }
            catch
            {
                Response.Write("Не вдалося оновити інформацію. Перевірте правильність введення.");
            }
        }

        protected void GridViewProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                connection.Open();
                SqlCommand command = new SqlCommand($"DELETE FROM Products WHERE ID = @id", connection);
                command.Parameters.AddWithValue("@id", Convert.ToInt32(GridViewProducts.DataKeys[e.RowIndex].Value.ToString()));
                command.ExecuteNonQuery();
                this.UpdateGridView();
                connection.Close();
            }
            catch
            {
                Response.Write("Не вдалося видалити товар через наявність зв'язаних даних.");
            }
        }

        protected void GridViewProducts_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Footer)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");

                    if (ddl != null)
                    {
                        int CategoryID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "CategoryID"));
                        ddl.SelectedValue = CategoryID.ToString();
                    }
                }
            }
            catch
            {

            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtNameFooter.Text.Trim() == "" ||
                    txtDescriptionFooter.Text.Trim() == "" ||
                    txtPriceFooter.Text.Replace(',', '.').Trim() == ""
                    )
                {
                    Response.Write($"Необхідно заповнити всі дані для додавання нового товару.");
                    return;
                }

                    SqlConnection connection = new SqlConnection(WebConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString);
                    connection.Open();
                    SqlCommand command = new SqlCommand($"INSERT INTO Products (CategoryID, Name, Description, Price) VALUES (@CategoryID, @Name, @Description, @Price)", connection);
                    command.Parameters.AddWithValue("@CategoryID", DropDownList3.SelectedValue);
                    command.Parameters.AddWithValue("@Name", txtNameFooter.Text.Trim());
                    command.Parameters.AddWithValue("@Description", txtDescriptionFooter.Text.Trim());
                    command.Parameters.AddWithValue("@Price", txtPriceFooter.Text.Replace(',', '.').Trim());
                    command.ExecuteNonQuery();
                    this.UpdateGridView();
                connection.Close();
            }
            catch
            {
                Response.Write($"Не вдалося додати новий елемент. Перевірте правильність введених даних.");
            }
        }
    }
}