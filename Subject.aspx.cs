using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDUBox
{
    public partial class Subject : System.Web.UI.Page
    {
        private string conStr = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\EDUBox\EDUBox\EDUBox\App_Data\Quiz.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["GradeId"] != null)
                {
                    int gradeId;
                    if (int.TryParse(Request.QueryString["GradeId"], out gradeId))
                    {
                        // Store grade id in hidden field so client-side doesn't need inline QueryString
                        hdnSelectedGradeId.Value = gradeId.ToString();

                        BindSubjects(gradeId);
                    }
                    else
                    {
                        Response.Redirect("index.aspx");
                    }
                }
                else
                {
                    Response.Redirect("index.aspx");
                }
            }
        }

        private void BindSubjects(int gradeId)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(conStr))
                {
                    string query = "SELECT Id, Subject, Image FROM Subjects WHERE GradeId = @GradeId";

                    SqlCommand cmd = new SqlCommand(query, connection);
                    cmd.Parameters.AddWithValue("@GradeId", gradeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptSubjects.DataSource = dt;
                    rptSubjects.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Database Error in BindSubjects: " + ex.Message);
                // Optionally show a friendly message on the page (Label) for production
            }
        }

        protected void btnStartQuiz_Click(object sender, EventArgs e)
        {
            string gradeId = hdnSelectedGradeId.Value;
            string subjectName = hdnSelectedSubject.Value;
            string examPeriod = rblExamPeriod.SelectedValue;

            if (!string.IsNullOrEmpty(gradeId) && !string.IsNullOrEmpty(subjectName) && !string.IsNullOrEmpty(examPeriod))
            {
                string redirectUrl = string.Format(
                    "Quiz.aspx?GradeId={0}&Subject={1}&ExamPeriod={2}",
                    Server.UrlEncode(gradeId),
                    Server.UrlEncode(subjectName),
                    Server.UrlEncode(examPeriod)
                );
                    Response.Redirect(redirectUrl);
            }
            else
            {
                System.Diagnostics.Debug.WriteLine("Redirect failed: Missing Grade, Subject, or Exam Period.");
            }
        }
       

    }
}
