using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace EDUBox
{
    public partial class Typing : System.Web.UI.Page
    {
        String con = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\EDUBox\EDUBox\EDUBox\App_Data\Quiz.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrades();
            }

        }
        private void BindGrades()
        {
            using (SqlConnection connection = new SqlConnection(con))
            {
                string query = "SELECT Id, Type, image, Typename FROM Typing";
                SqlDataAdapter da = new SqlDataAdapter(query, connection);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptGrades.DataSource = dt;
                rptGrades.DataBind();
            }
        }



    }
}