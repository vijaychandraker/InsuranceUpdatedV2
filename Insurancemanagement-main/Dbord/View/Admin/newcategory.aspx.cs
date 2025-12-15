using ClosedXML.Excel;
using Dbord.helpers;
using Dbord.Helpers;
using DocumentFormat.OpenXml.Office2010.Excel;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Dbord.View.Admin
{
    public partial class newcategory : System.Web.UI.Page
    {
        private readonly DatabaseHelper db = new DatabaseHelper();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
              LoadCategories();
             //   BindGrid();
            }
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            gvcate.PageIndex = 0;
           // BindGrid();
        }
        //private void BindGrid()
        //{
        //    string q = txtSearch.Text.Trim();

        //    using (SqlConnection con = new SqlConnection(
        //        ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
        //    {
        //        SqlCommand cmd = new SqlCommand(
        //            "SELECT c_id, CompanyName FROM mst_Company WHERE CompanyName LIKE @q", con);
        //        cmd.Parameters.AddWithValue("@q", "%" + q + "%");

        //        SqlDataAdapter da = new SqlDataAdapter(cmd);
        //        DataTable dt = new DataTable();
        //        da.Fill(dt);

        //        gvcate.DataSource = dt;
        //        gvcate.DataBind();
        //    }
        //}

        private void LoadCategories()
        {
            DataTable dt = db.ExecuteQuery("sp_GetAllCategories", null);
            gvcate.DataSource = dt;
            gvcate.DataBind();
           
        }
        protected void gvcate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvcate.EditIndex = e.NewEditIndex;
            LoadCategories();
        }
        protected void gvcate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvcate.EditIndex = -1;
            LoadCategories();
        }

        protected void gvcate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvcate.DataKeys[e.RowIndex].Value);

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM mst_category WHERE c_id=@id", con);

                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadCategories();
        }
        protected void gvcate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvcate.DataKeys[e.RowIndex].Value);
            TextBox txtCompanyName =
                (TextBox)gvcate.Rows[e.RowIndex].FindControl("txtCategoryName");

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE mst_category SET CategoryName=@CategoryName WHERE c_id=@id", con);

                cmd.Parameters.AddWithValue("@CategoryName", txtCompanyName.Text);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvcate.EditIndex = -1;
            LoadCategories();
        }
        protected void gvcate_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvcate.EditIndex = -1;   // important
            gvcate.PageIndex = e.NewPageIndex;
            LoadCategories();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;
            SqlParameter[] parameters =
{
    new SqlParameter("@CategoryName", txtcategoryname.Text.Trim()),

    new SqlParameter("@c_id", SqlDbType.Int)
    {
        Direction = ParameterDirection.Output
    }
};

            db.ExecuteNonQuery("sp_Insertcategory", parameters);

            int newPolicyId = Convert.ToInt32(parameters[1].Value);

            if (newPolicyId > 0)
            {
                AlertHelper.ShowSuccess(this, "Success");
                txtcategoryname.Text = "";
                LoadCategories();
            }
            else
            {
                AlertHelper.ShowError(this, "Failed.");
            }


        }

        //protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    gvcate.PageSize = int.Parse(ddlPageSize.SelectedValue);
        //    gvcate.PageIndex = 0;
        //    BindGrid();
        //}
    }
}