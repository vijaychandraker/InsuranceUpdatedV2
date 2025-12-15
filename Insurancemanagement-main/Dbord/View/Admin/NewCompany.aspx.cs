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
    public partial class NewCompany : System.Web.UI.Page
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
            gvcatecmpny.PageIndex = 0;
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
            DataTable dt = db.ExecuteQuery("sp_GetAllCompanies", null);
            gvcatecmpny.DataSource = dt;
            gvcatecmpny.DataBind();

        }
        protected void gvcate_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvcatecmpny.EditIndex = e.NewEditIndex;
            LoadCategories();
        }
        protected void gvcate_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvcatecmpny.EditIndex = -1;
            LoadCategories();
        }

        protected void gvcate_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvcatecmpny.DataKeys[e.RowIndex].Value);

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "DELETE FROM mst_Company WHERE c_id=@id", con);

                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            LoadCategories();
        }
        protected void gvcate_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvcatecmpny.DataKeys[e.RowIndex].Value);
            TextBox txtCompanyName =
                (TextBox)gvcatecmpny.Rows[e.RowIndex].FindControl("txtCompanyName");

            string cs = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(
                    "UPDATE mst_Company SET CompanyName=@CompanyName WHERE c_id=@id", con);

                cmd.Parameters.AddWithValue("@CompanyName", txtCompanyName.Text);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvcatecmpny.EditIndex = -1;
            LoadCategories();
        }
        protected void gvcate_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvcatecmpny.EditIndex = -1;   // important
            gvcatecmpny.PageIndex = e.NewPageIndex;
            LoadCategories();
        }

        protected void btnSubmitcmpny_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;
            SqlParameter[] parameters =
{
    new SqlParameter("@CompanyName", txtcompany.Text.Trim()),

    new SqlParameter("@c_id", SqlDbType.Int)
    {
        Direction = ParameterDirection.Output
    }
};

            db.ExecuteNonQuery("sp_InsertCompany", parameters);

            int newPolicyId = Convert.ToInt32(parameters[1].Value);

            if (newPolicyId > 0)
            {
                AlertHelper.ShowSuccess(this, "Success");
                txtcompany.Text = "";
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