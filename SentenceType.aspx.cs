using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace MyProject
{
    public partial class SentenceType : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename='D:\EduBox (2)final\EduBox\HH\MyProject\MyProject\App_Data\Quiz.mdf';Integrated Security=True");

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Random rnd = new Random();
                int randomNumber = rnd.Next(5);
                string paragraph = GetParagraph(randomNumber);
                // Set the literal text
                myLiteralControl.Text = paragraph;

                string escapedParagraph = paragraph.Replace("'", "\\'").Replace("\"", "\\\"").Replace("\r\n", " ").Replace("\n", " ");
                string script = string.Format("var paragraphText = '{0}';", escapedParagraph);
                ClientScript.RegisterStartupScript(this.GetType(), "setText", script, true);

            }
        }

        public string GetParagraph(int id)
        {
            string paragraph = string.Empty;
            string query = "SELECT paragraph FROM TypoParagraph WHERE Id = @Id";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                con.Open();

                // Use ExecuteScalar since we're getting a single value
                object result = cmd.ExecuteScalar();

                if (result != null && result != DBNull.Value)
                {
                    paragraph = result.ToString();
                }

                con.Close();
            }

            return paragraph;
        }
    }
}