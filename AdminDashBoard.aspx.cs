using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.OleDb;
using ClosedXML.Excel;
using System.Linq;


namespace EDUBox
{
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        private readonly string connectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\EDUBox\EDUBox\EDUBox\App_Data\Quiz.mdf;Integrated Security=True";

        
           protected void Page_Load(object sender, EventArgs e)
            {
                if (!IsPostBack)
                {
                    LoadDashboardCounts();
                    LoadGrades();
                    LoadGrade1();
                    BindGrades();
                    BindGradesForSubjects();
                    hfActiveSection.Value = "dashboard";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowDefault", "showSection('dashboard');", true);
                }
                else
                {
                    string activeSection = hfActiveSection.Value;
                    if (!string.IsNullOrEmpty(activeSection))
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "showSection", "showSection('" + activeSection + "');", true);
                    }
                }
            }



           protected void btnUpload_Click(object sender, EventArgs e)
           {
               lblMsg.ForeColor = System.Drawing.Color.Red;
               if (!fuExcel.HasFile)
               {
                   
                   lblMsg.Text = "Please upload an Excel file.";
                   return;
               }

               string uploadsFolder = Server.MapPath("~/ExcelUploads/");
               if (!System.IO.Directory.Exists(uploadsFolder))
                   System.IO.Directory.CreateDirectory(uploadsFolder);

               string filePath = System.IO.Path.Combine(uploadsFolder, System.IO.Path.GetFileName(fuExcel.FileName));

               try
               {
                   fuExcel.SaveAs(filePath);

                   using (var workbook = new XLWorkbook(filePath))
                   {
                       var worksheet = workbook.Worksheets.First();
                       var lastRow = worksheet.LastRowUsed();
                       if (lastRow == null)
                       {
                           lblMsg.Text = "Excel file has no data.";
                           return;
                       }

                       int rowCount = lastRow.RowNumber();
                       int insertedCount = 0;
                       int skippedCount = 0;

                       for (int row = 2; row <= rowCount; row++) // Skip header
                       {
                           // Read raw values (may be null)
                           string gradeTemp = worksheet.Cell(row, 1).GetValue<string>();
                           string subjectTemp = worksheet.Cell(row, 2).GetValue<string>();
                           string monthTemp = worksheet.Cell(row, 3).GetValue<string>();
                           string questionTemp = worksheet.Cell(row, 4).GetValue<string>();
                           string optionATemp = worksheet.Cell(row, 5).GetValue<string>();
                           string optionBTemp = worksheet.Cell(row, 6).GetValue<string>();
                           string answerTemp = worksheet.Cell(row, 7).GetValue<string>();

                           // Null-safe trim for old C#
                           string grade = gradeTemp != null ? gradeTemp.Trim() : "";
                           string subject = subjectTemp != null ? subjectTemp.Trim() : "";
                           string month = monthTemp != null ? monthTemp.Trim() : "";
                           string question = questionTemp != null ? questionTemp.Trim() : "";
                           string optionA = optionATemp != null ? optionATemp.Trim() : "";
                           string optionB = optionBTemp != null ? optionBTemp.Trim() : "";
                           string answer = answerTemp != null ? answerTemp.Trim() : "";

                           // Skip row if minimal data missing
                           if (string.IsNullOrEmpty(grade) || string.IsNullOrEmpty(subject) || string.IsNullOrEmpty(question))
                           {
                               skippedCount++;
                               continue;
                           }

                           // Create or get IDs
                           int gradeId = GetOrInsertGrade(grade);
                           int subjectId = GetOrInsertSubject(gradeId, subject);

                           if (gradeId == 0 || subjectId == 0)
                           {
                               skippedCount++;
                               continue;
                           }

                           int testId = GetOrInsertMonthlyTest(subjectId, month);

                           // Insert question
                           InsertQuestion(testId, question, optionA, optionB, answer, null);
                           insertedCount++;
                       }

                       lblMsg.ForeColor = System.Drawing.Color.Green;
                       lblMsg.Text = "Excel import finished. Inserted: " + insertedCount + ", Skipped: " + skippedCount + ".";
                   }
               }
               catch (Exception ex)
               {
                   lblMsg.ForeColor = System.Drawing.Color.Red;
                   lblMsg.Text = "Excel import failed: " + ex.Message;
               }
           }


           private int GetOrInsertGrade(string gradeName)
           {
               if (string.IsNullOrEmpty(gradeName))
                   return 0;

               using (SqlConnection con = new SqlConnection(connectionString))
               {
                   con.Open();
                   SqlCommand checkCmd = new SqlCommand("SELECT Id FROM Grade WHERE Grade=@g", con);
                   checkCmd.Parameters.AddWithValue("@g", gradeName);
                   object result = checkCmd.ExecuteScalar();
                   if (result != null)
                       return Convert.ToInt32(result);

                   SqlCommand insertCmd = new SqlCommand("INSERT INTO Grade (Grade) OUTPUT INSERTED.Id VALUES (@g)", con);
                   insertCmd.Parameters.AddWithValue("@g", gradeName);
                   return (int)insertCmd.ExecuteScalar();
               }
           }


           private void LoadGrade1()
           {
               using (SqlConnection con = new SqlConnection(connectionString))
               {
                   con.Open();
                   SqlCommand cmd = new SqlCommand("SELECT Id, Grade FROM Grade", con);
                   SqlDataReader reader = cmd.ExecuteReader();
                   ddlGenGrade.DataSource = reader;
                   ddlGenGrade.DataTextField = "Grade";
                   ddlGenGrade.DataValueField = "Id";
                   ddlGenGrade.DataBind();


               }

               ddlGenGrade.Items.Insert(0, new ListItem("--Select Grade--", "0"));
           }
        private void LoadDashboardCounts()
        {

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                string query = "SELECT COUNT(*) FROM Questions";
                SqlCommand cmd = new SqlCommand(query, con);
                lblQuestionsCount.Text = cmd.ExecuteScalar().ToString();

                // Load total grades count
                query = "SELECT COUNT(*) FROM Grade";
                cmd = new SqlCommand(query, con);
                lblGradeCount.Text = cmd.ExecuteScalar().ToString();

                // Load total subjects count
                query = "SELECT COUNT(*) FROM Subjects";
                cmd = new SqlCommand(query, con);
                lblSubjectCount.Text = cmd.ExecuteScalar().ToString();

                // Load total tests count
                query = "SELECT COUNT(*) FROM MonthlyTest";
                cmd = new SqlCommand(query, con);
                lblMonthlyTestCount.Text = cmd.ExecuteScalar().ToString();


            }

        }



        protected void btnAddGen_Click(object sender, EventArgs e)
        {
            try
            {
                int gradeId = int.Parse(ddlGenGrade.SelectedValue);
                int subjectId = int.Parse(ddlGenSubject.SelectedValue);  // Already loaded
                string monthlyTestCode = ddlGenMonth.SelectedValue;
                string questionText = txtQuestion.Text.Trim();
                string optionA = txtChoice1.Text.Trim();
                string optionB = txtChoice2.Text.Trim();
                string correctAnswer = txtAnswer.Text.Trim();
                string imageFileName = null;

                if (fuGenImage.HasFile)
                {
                    string folderPath = Server.MapPath("~/Uploads/");
                    if (!System.IO.Directory.Exists(folderPath))
                        System.IO.Directory.CreateDirectory(folderPath);

                    imageFileName = fuGenImage.FileName;
                    fuGenImage.SaveAs(System.IO.Path.Combine(folderPath, imageFileName));
                }

                // Ensure monthly test exists or create
                int testId = GetOrInsertMonthlyTest(subjectId, monthlyTestCode);

                // Insert the question (this was missing previously)
                InsertQuestion(testId, questionText, optionA, optionB, correctAnswer, imageFileName);

                // Clear form
                txtQuestion.Text = "";
                txtChoice1.Text = "";
                txtChoice2.Text = "";
                txtAnswer.Text = "";
                ddlGenGrade.SelectedIndex = 0;
                ddlGenSubject.SelectedIndex = 0;
                ddlGenMonth.SelectedIndex = 0;

                hfActiveSection.Value = "quiz-add"; // Quiz Add section
                ScriptManager.RegisterStartupScript(this, this.GetType(), "showSection", "showSection('" + hfActiveSection.Value + "');", true);
                Response.Write("<script>alert('Quiz added successfully!');</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }


        private int GetOrInsertSubject(int gradeId, string subjectName)
        {
            if (gradeId == 0 || string.IsNullOrEmpty(subjectName))
                return 0;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand checkCmd = new SqlCommand("SELECT Id FROM Subjects WHERE GradeId=@GradeId AND Subject=@Subject", con);
                checkCmd.Parameters.AddWithValue("@GradeId", gradeId);
                checkCmd.Parameters.AddWithValue("@Subject", subjectName);
                object result = checkCmd.ExecuteScalar();
                if (result != null)
                    return Convert.ToInt32(result);

                SqlCommand insertCmd = new SqlCommand("INSERT INTO Subjects (GradeId, Subject) OUTPUT INSERTED.Id VALUES (@GradeId, @Subject)", con);
                insertCmd.Parameters.AddWithValue("@GradeId", gradeId);
                insertCmd.Parameters.AddWithValue("@Subject", subjectName);
                return (int)insertCmd.ExecuteScalar();
            }
        }
        private int GetOrInsertMonthlyTest(int subjectId, string testCode)
        {
            if (subjectId == 0)
                return 0;

            // Use empty string if testCode is null to avoid null DB parameter issues
            string code = testCode ?? "";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand checkCmd = new SqlCommand("SELECT Id FROM MonthlyTest WHERE SubjectId=@sid AND TestCode=@code", con);
                checkCmd.Parameters.AddWithValue("@sid", subjectId);
                checkCmd.Parameters.AddWithValue("@code", code);
                object result = checkCmd.ExecuteScalar();
                if (result != null)
                    return Convert.ToInt32(result);

                SqlCommand insertCmd = new SqlCommand("INSERT INTO MonthlyTest (SubjectId, TestCode) OUTPUT INSERTED.Id VALUES (@sid, @code)", con);
                insertCmd.Parameters.AddWithValue("@sid", subjectId);
                insertCmd.Parameters.AddWithValue("@code", code);
                return (int)insertCmd.ExecuteScalar();
            }
        }




        private void InsertQuestion(int testId, string questionText, string optionA, string optionB, string correctAnswer, string image)
        {
            if (testId == 0 || string.IsNullOrEmpty(questionText))
                return;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    @"INSERT INTO Questions (TestId, QuestionText, OptionA, OptionB, CorrectAnswer, Image)
                      VALUES (@TestId, @QuestionText, @OptionA, @OptionB, @CorrectAnswer, @Image)", con);

                cmd.Parameters.AddWithValue("@TestId", testId);
                cmd.Parameters.AddWithValue("@QuestionText", questionText);
                cmd.Parameters.AddWithValue("@OptionA", (object)optionA ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@OptionB", (object)optionB ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@CorrectAnswer", (object)correctAnswer ?? DBNull.Value);
                cmd.Parameters.AddWithValue("@Image", (object)image ?? DBNull.Value);

                cmd.ExecuteNonQuery();
            }
        }
      
          

        private void LoadGrades()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Grade FROM Grade", con);
                SqlDataReader dr = cmd.ExecuteReader();
                ddlGradeView.DataSource = dr;
                ddlGradeView.DataTextField = "Grade";
                ddlGradeView.DataValueField = "Id";
                ddlGradeView.DataBind();
            }
            ddlGradeView.Items.Insert(0, new ListItem("--Select Grade--", "0"));
        }
        protected void ddlGenGrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            int gradeId = int.Parse(ddlGenGrade.SelectedValue);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Subject FROM Subjects WHERE GradeId=@GradeId", con);
                cmd.Parameters.AddWithValue("@GradeId", gradeId);
                SqlDataReader dr = cmd.ExecuteReader();

                ddlGenSubject.DataSource = dr;
                ddlGenSubject.DataTextField = "Subject";
                ddlGenSubject.DataValueField = "Id";
                ddlGenSubject.DataBind();
            }

            ddlGenSubject.Items.Insert(0, new ListItem("--Select Subject--", "0"));

            // Optionally, clear GridView
            gvQuestions.DataSource = null;
            gvQuestions.DataBind();
            hfActiveSection.Value = "quiz-add";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "showSection",
                "showSection('" + hfActiveSection.Value + "');", true);
        }


        protected void ddlGradeView_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadSubjects(int.Parse(ddlGradeView.SelectedValue));
            hfActiveSection.Value = "quiz-view";
        }

        private void LoadSubjects(int gradeId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Subject FROM Subjects WHERE GradeId=@GradeId", con);
                cmd.Parameters.AddWithValue("@GradeId", gradeId);
                SqlDataReader dr = cmd.ExecuteReader();
                ddlSubjectView.DataSource = dr;
                ddlSubjectView.DataTextField = "Subject";
                ddlSubjectView.DataValueField = "Id";
                ddlSubjectView.DataBind();
            }
            ddlSubjectView.Items.Insert(0, new ListItem("--Select Subject--", "0"));
            gvQuestions.DataSource = null;
            gvQuestions.DataBind();
        }

       

        protected void ddlTestView_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadQuestions();
        }

        private void LoadQuestions()
        {
            int subjectId = int.Parse(ddlSubjectView.SelectedValue);
            string testCode = ddlTestView.SelectedValue;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"
            SELECT q.Id, q.QuestionText, q.OptionA, q.OptionB, q.CorrectAnswer
            FROM Questions q
            INNER JOIN MonthlyTest m ON q.TestId = m.Id
            WHERE m.SubjectId=@SubjectId AND m.TestCode=@TestCode", con);
                cmd.Parameters.AddWithValue("@SubjectId", subjectId);
                cmd.Parameters.AddWithValue("@TestCode", testCode);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvQuestions.DataSource = dt;
                gvQuestions.DataBind();
            }
        }

        protected void gvQuestions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvQuestions.EditIndex = e.NewEditIndex;
            LoadQuestions(); // reload data
            hfActiveSection.Value = "quiz-view";
        }

        protected void gvQuestions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvQuestions.EditIndex = -1;
            LoadQuestions();
        }

        protected void gvQuestions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int questionId = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvQuestions.Rows[e.RowIndex];

            string questionText = ((TextBox)row.Cells[0].Controls[0]).Text.Trim();
            string optionA = ((TextBox)row.Cells[1].Controls[0]).Text.Trim();
            string optionB = ((TextBox)row.Cells[2].Controls[0]).Text.Trim();
            string correctAnswer = ((TextBox)row.Cells[3].Controls[0]).Text.Trim();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE Questions 
                                         SET QuestionText=@QuestionText, OptionA=@OptionA, OptionB=@OptionB, CorrectAnswer=@CorrectAnswer
                                         WHERE Id=@Id", con);
                cmd.Parameters.AddWithValue("@QuestionText", questionText);
                cmd.Parameters.AddWithValue("@OptionA", optionA);
                cmd.Parameters.AddWithValue("@OptionB", optionB);
                cmd.Parameters.AddWithValue("@CorrectAnswer", correctAnswer);
                cmd.Parameters.AddWithValue("@Id", questionId);
                cmd.ExecuteNonQuery();
            }

            gvQuestions.EditIndex = -1;
            LoadQuestions();
        }

        protected void gvQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int questionId = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("DELETE FROM Questions WHERE Id=@Id", con);
                cmd.Parameters.AddWithValue("@Id", questionId);
                cmd.ExecuteNonQuery();
            }

            LoadQuestions();
        }


        private void BindGrades()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT Id, Grade FROM Grade";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    gvGrades.DataSource = reader;
                    gvGrades.DataBind();
                    con.Close();
                }
            }
        }

        protected void gvGrades_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvGrades.EditIndex = e.NewEditIndex;
            BindGrades();
        }

        protected void gvGrades_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvGrades.EditIndex = -1;
            BindGrades();
        }

        protected void gvGrades_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvGrades.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvGrades.Rows[e.RowIndex];
            string gradeName = ((TextBox)row.Cells[0].Controls[0]).Text;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "UPDATE Grade SET Grade=@GradeName WHERE Id=@Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@GradeName", gradeName);
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            gvGrades.EditIndex = -1;
            BindGrades();
        }

        protected void gvGrades_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvGrades.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Grade WHERE Id=@Id";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Id", id);
                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }

            BindGrades();
        }

        private void BindGradesForSubjects()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Grade FROM Grade ORDER BY Id", con);
                SqlDataReader dr = cmd.ExecuteReader();
                ddlSubjectViewGrade.DataSource = dr;
                ddlSubjectViewGrade.DataTextField = "Grade";
                ddlSubjectViewGrade.DataValueField = "Id";
                ddlSubjectViewGrade.DataBind();
            }
            ddlSubjectViewGrade.Items.Insert(0, new ListItem("Select Grade", "0"));
        }

        private void BindSubjectsGrid()
        {
            int gradeId = int.Parse(ddlSubjectViewGrade.SelectedValue);
            if (gradeId == 0) { gvSubjects.DataSource = null; gvSubjects.DataBind(); return; }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SELECT Id, Subject FROM Subjects WHERE GradeId=@grade", con);
                cmd.Parameters.AddWithValue("@grade", gradeId);
                SqlDataReader dr = cmd.ExecuteReader();
                gvSubjects.DataSource = dr;
                gvSubjects.DataBind();
            }
        }

        protected void ddlSubjectViewGrade_SelectedIndexChanged(object sender, EventArgs e)
        {
            hfActiveSection.Value = "subject-view";
            BindSubjectsGrid();
        }

        protected void btnAddNewSubject_Click(object sender, EventArgs e)
        {
            string subjectName = txtNewSubject.Text.Trim();
            int gradeId = int.Parse(ddlSubjectViewGrade.SelectedValue);

            if (string.IsNullOrEmpty(subjectName) || gradeId == 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Please enter subject and select grade.');", true);
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Subjects (Subject, GradeId) VALUES (@name, @grade)", con);
                cmd.Parameters.AddWithValue("@name", subjectName);
                cmd.Parameters.AddWithValue("@grade", gradeId);
                cmd.ExecuteNonQuery();
            }

            txtNewSubject.Text = "";
            BindSubjectsGrid();
        }


        protected void gvSubjects_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSubjects.EditIndex = e.NewEditIndex;
            BindSubjectsGrid();
        }

        protected void gvSubjects_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSubjects.EditIndex = -1;
            BindSubjectsGrid();
        }

        protected void gvSubjects_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int subjectId = Convert.ToInt32(gvSubjects.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvSubjects.Rows[e.RowIndex];
            string subjectName = ((TextBox)row.Cells[0].Controls[0]).Text.Trim();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("UPDATE Subjects SET Subject=@name WHERE Id=@id", con);
                cmd.Parameters.AddWithValue("@name", subjectName);
                cmd.Parameters.AddWithValue("@id", subjectId);
                cmd.ExecuteNonQuery();
            }

            gvSubjects.EditIndex = -1;
            BindSubjectsGrid();
        }

        protected void gvSubjects_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int subjectIdToDelete = Convert.ToInt32(gvSubjects.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
    {
        con.Open();
        SqlTransaction transaction = con.BeginTransaction();

        try
        {
            // STEP 1: Delete all dependent MonthlyTest records
            string sqlDeleteTests = "DELETE FROM MonthlyTest WHERE SubjectId = @SubjectId";
            using (SqlCommand cmdTests = new SqlCommand(sqlDeleteTests, con, transaction))
            {
                cmdTests.Parameters.AddWithValue("@SubjectId", subjectIdToDelete);
                cmdTests.ExecuteNonQuery();
            }

            // STEP 2: Delete the Subject record (now safe)
            string sqlDeleteSubject = "DELETE FROM Subjects WHERE Id = @SubjectId";
            using (SqlCommand cmdSubject = new SqlCommand(sqlDeleteSubject, con, transaction))
            {
                cmdSubject.Parameters.AddWithValue("@SubjectId", subjectIdToDelete);
                cmdSubject.ExecuteNonQuery();
            }

            // If both commands succeed, commit the transaction
            transaction.Commit();
        }
        catch (Exception ex)
        {
            // If anything fails, rollback all changes
            transaction.Rollback();
            // Log the error (ex.Message) and inform the user
            // You might want to display a custom error message instead of re-throwing the raw exception.
        }
    }
            BindGradesForSubjects();
            BindSubjectsGrid();
        }
        protected void ddlSubjectView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubjectView.SelectedValue != "0")
                LoadTestsForSubject(int.Parse(ddlSubjectView.SelectedValue));

            gvQuestions.DataSource = null;
            gvQuestions.DataBind();
            hfActiveSection.Value = "quiz-view";
        }

        private void LoadTestsForSubject(int subjectId)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand(
                    "SELECT DISTINCT TestCode FROM MonthlyTest WHERE SubjectId=@sub",
                    con
                );
                cmd.Parameters.AddWithValue("@sub", subjectId);

                SqlDataReader dr = cmd.ExecuteReader();
                ddlTestView.DataSource = dr;
                ddlTestView.DataTextField = "TestCode";
                ddlTestView.DataValueField = "TestCode";
                ddlTestView.DataBind();
            }

            ddlTestView.Items.Insert(0, new ListItem("--Select Test--", ""));
        }


    }
}
        


