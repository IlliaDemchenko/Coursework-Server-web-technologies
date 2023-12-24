using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace WebApplication
{
    public partial class Orders : System.Web.UI.Page
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
                SqlDataAdapter sqlDa = new SqlDataAdapter($"SELECT * FROM Orders WHERE UserID = '{Context.User.Identity.GetUserId()}'", sqlCon);
                sqlDa.Fill(dtbl);
            }
            if (dtbl.Rows.Count > 0)
            {
                GridViewOrders.DataSource = dtbl;
                GridViewOrders.DataBind();
            }
            else
            {
                dtbl.Rows.Add(dtbl.NewRow());
                GridViewOrders.DataSource = dtbl;
                GridViewOrders.DataBind();
                GridViewOrders.Rows[0].Cells.Clear();
                GridViewOrders.Rows[0].Cells.Add(new TableCell());
                GridViewOrders.Rows[0].Cells[0].ColumnSpan = dtbl.Columns.Count;
                GridViewOrders.Rows[0].Cells[0].Text = " ";
                GridViewOrders.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }
            connection.Close();
        }

        protected void GridViewOrders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (e.Row.RowType == DataControlRowType.DataRow || e.Row.RowType == DataControlRowType.Footer)
                {
                    DropDownList ddl = (DropDownList)e.Row.FindControl("DropDownList1");

                    if (ddl != null)
                    {
                        int ProductID = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "ProductID"));
                        ddl.SelectedValue = ProductID.ToString();
                    }
                }
            }
            catch
            {

            }
        }
    }
}