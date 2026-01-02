using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EDUBox
{
    public partial class Quiz : System.Web.UI.Page
    {
        private readonly string connectionString = @"Data Source=(LocalDB)\v11.0;AttachDbFilename=D:\EDUBox\EDUBox\EDUBox\App_Data\Quiz.mdf;Integrated Security=True";

        private List<Question> questions
        {
            get { return (List<Question>)Session["Questions"]; }
            set { Session["Questions"] = value; }
        }

        private int QIndex
        {
            get { return (int)(ViewState["QIndex"] ?? 0); }
            set { ViewState["QIndex"] = value; }
        }

        private int Score
        {
            get { return (int)(Session["Score"] ?? 0); }
            set { Session["Score"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
        
                string grade = Request.QueryString["GradeId"];
                string subject = Request.QueryString["Subject"];
                ViewState["SubjectName"] = subject;
                string test = Request.QueryString["ExamPeriod"];

                if (!string.IsNullOrEmpty(grade) && !string.IsNullOrEmpty(subject) && !string.IsNullOrEmpty(test))
                {
                    LoadQuestions(grade, subject, test);
                    homeBtn.PostBackUrl = string.Format("~/Subject.aspx?GradeId={0}", grade);
                }
                else
                    litQuestionText.Text = "❌ Missing Grade, Subject, or Test parameters!";
              
            }
        }

        private void LoadQuestions(string gradeId, string subject, string examPeriod)
        {
            questions = new List<Question>();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TOP 5 q.QuestionText, q.OptionA, q.OptionB, q.CorrectAnswer, q.Image
                    FROM Questions q
                    INNER JOIN MonthlyTest mt ON q.TestId = mt.Id
                    INNER JOIN Subjects s ON mt.SubjectId = s.Id
                    INNER JOIN Grade g ON s.GradeId = g.Id
                    WHERE g.Id = @GradeId AND s.Subject = @Subject AND mt.TestCode = @ExamPeriod  ORDER BY NEWID() 
                ";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@GradeId", gradeId);
                cmd.Parameters.AddWithValue("@Subject", subject);
                cmd.Parameters.AddWithValue("@ExamPeriod", examPeriod);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    questions.Add(new Question
                    {
                        QuestionText = reader["QuestionText"].ToString(),
                        OptionA = reader["OptionA"].ToString(),
                        OptionB = reader["OptionB"].ToString(),
                        CorrectAnswer = reader["CorrectAnswer"].ToString(),
                        ImageUrl = reader["Image"].ToString()
                    });
                }
            }

            if (questions.Count > 0)
            {
                QIndex = 0;
                Score = 0;
                ShowQuestion();
                RenderSteps();
            }
            else
            {
                litQuestionText.Text = "😕 No questions found for this quiz!";
            }
        }

        // In Quiz.aspx.cs
        private void RenderSteps()
        {
            if (questions == null || questions.Count == 0) return;

            // Use a System.Text.StringBuilder for efficient HTML construction
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            int totalQuestions = questions.Count;

            for (int i = 0; i < totalQuestions; i++)
            {
                // Determine if the current step is active (the current question)
                // or completed (all previous questions)
                string cssClass = "circle";
                if (i < QIndex)
                {
                    cssClass += " completed"; // Add a new CSS class for completed steps
                }
                else if (i == QIndex)
                {
                    cssClass += " active";
                }

                // Use simple string concatenation
                sb.Append("<div class='");
                sb.Append(cssClass);
                sb.Append("'>");
                sb.Append(i + 1);
                sb.Append("</div>");

                // Add a line between circles, unless it's the last circle
                if (i < totalQuestions - 1)
                {
                    sb.Append("<div class='line'></div>");
                }
            }

            // Assign the generated HTML to the PlaceHolder
            phSteps.Controls.Clear();
            phSteps.Controls.Add(new LiteralControl(sb.ToString()));
        }
        private void ShowQuestion()
        {
            btnA.Enabled = btnB.Enabled = btnC.Enabled = true;
            btnA.CssClass = btnB.CssClass = btnC.CssClass = "choice-btn";
            feedback.Text = "";

            var q = questions[QIndex];

            // Randomize options
            List<string> options = new List<string> { q.OptionA, q.OptionB, q.CorrectAnswer };
            Random rnd = new Random();
            for (int i = options.Count - 1; i > 0; i--)
            {
                int j = rnd.Next(i + 1);
                string temp = options[i];
                options[i] = options[j];
                options[j] = temp;
            }

            litQuestionText.Text = q.QuestionText;
            quizImg.ImageUrl = q.ImageUrl;

            btnA.Text = options[0];
            btnB.Text = options[1];
            btnC.Text = options[2];

            lblQuestionNumber.Text = "Question: " + (QIndex + 1) + "/" + questions.Count;

            // ✅ Save correct answer for Answer_Click()
            ViewState["CorrectAnswer"] = q.CorrectAnswer;

            nextBtn.Visible = true;
            RenderSteps();
        }

        protected void Answer_Click(object sender, EventArgs e)
        {
            var q = questions[QIndex];

            // If timeout triggered, sender might not be an actual button
            Button clicked = sender as Button;
            if (hiddenTimer.Value == "timeout")
            {
                // Time’s up → just show correct/wrong answers, no score change
                btnA.Enabled = btnB.Enabled = btnC.Enabled = false;

                // Reset CSS
                btnA.CssClass = btnB.CssClass = btnC.CssClass = "choice-btn";

                // Highlight correct answer
                if (btnA.Text == q.CorrectAnswer)
                    btnA.CssClass += " correct";
                else if (btnB.Text == q.CorrectAnswer)
                    btnB.CssClass += " correct";
                else if (btnC.Text == q.CorrectAnswer)
                    btnC.CssClass += " correct";

                feedback.Text = "⏰ Time’s up! The correct answer was: " + q.CorrectAnswer;
                feedback.ForeColor = System.Drawing.Color.OrangeRed;
             
                hiddenTimer.Value = ""; // reset for next question
                return; // ✅ Don’t go further (no scoring)
            }

            // Normal case → user clicked something
            btnA.Enabled = btnB.Enabled = btnC.Enabled = false;
            btnA.CssClass = btnB.CssClass = btnC.CssClass = "choice-btn";

            if (btnA.Text == q.CorrectAnswer)
                btnA.CssClass += " correct";
            else if (btnB.Text == q.CorrectAnswer)
                btnB.CssClass += " correct";
            else if (btnC.Text == q.CorrectAnswer)
                btnC.CssClass += " correct";

            if (clicked.Text != q.CorrectAnswer)
                clicked.CssClass += " wrong";

            if (clicked.Text == q.CorrectAnswer)
            {
                Score++;
                feedback.Text = "✅ Correct!";
                feedback.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                feedback.Text = "❌ Wrong! Correct answer: " + q.CorrectAnswer;
                feedback.ForeColor = System.Drawing.Color.Red;
            }
            nextBtn.Visible = true;
            RenderSteps();
        }



        protected void Timeout_Click(object sender, EventArgs e)
        {
            var q = questions[QIndex];

            // Disable buttons
            btnA.Enabled = btnB.Enabled = btnC.Enabled = false;

            // Reset CSS
            btnA.CssClass = btnB.CssClass = btnC.CssClass = "choice-btn";

            // Highlight correct answer
            if (btnA.Text == q.CorrectAnswer) btnA.CssClass += " correct";
            if (btnB.Text == q.CorrectAnswer) btnB.CssClass += " correct";
            if (btnC.Text == q.CorrectAnswer) btnC.CssClass += " correct";

            // Highlight all wrong answers
            if (btnA.CssClass != "choice-btn correct") btnA.CssClass += " wrong";
            if (btnB.CssClass != "choice-btn correct") btnB.CssClass += " wrong";
            if (btnC.CssClass != "choice-btn correct") btnC.CssClass += " wrong";

            // Feedback
            feedback.Text = "⏰ Time's up! Correct answer: " + q.CorrectAnswer;
            feedback.ForeColor = System.Drawing.Color.OrangeRed;

            // ✅ Next button always visible
            nextBtn.Visible = true;
            ScriptManager.RegisterStartupScript(this, GetType(), "StopTimer", "clearInterval(countdown);", true);
            RenderSteps();
        }
        // In Quiz.aspx.cs
        private string CalculateUserGrade(double percentage)
        {
            if (percentage >= 90)
            {
                return "A+ (Excellent!) </br> လက်ဆောင်ရရှိပါသည်။";
            }
            else if (percentage >= 80)
            {
                return "A (Great job!) </br> လက်ဆောင်ရရှိပါသည်။";
            }
            else if (percentage >= 70)
            {
                return "B (Good effort) ";
            }
            else if (percentage >= 60)
            {
                return "C (Pass)";
            }
            else
            {
                return "F (Needs improvement)";
            }
        }


       protected void next_Click(object sender, EventArgs e)
            {
                QIndex++; // Advance to the next question index

                // Check if the quiz is complete BEFORE showing the next question
                if (QIndex >= questions.Count)
                {
                    // 1. Calculate Score & Grade
                    double percentage = (double)Score / questions.Count * 100;
                    string userGrade = CalculateUserGrade(percentage);
                    string subjectName = (string)ViewState["SubjectName"] ?? "Quiz";

                    // --- FIX 1 & 2: CONSOLIDATE FEEDBACK TO INCLUDE GRADE/SUBJECT ---
                    // Use HTML breaks (<br/>) for clearer formatting of the final screen
                    feedback.Text = "🎯 " + subjectName + "Quiz Completed!<br/><br/>" +
                                    "Final Score: " + Score + " / " + questions.Count + " ( " + percentage.ToString("F0") + " % )" + "<br/><br/>" +
                                    "Your Performance Grade: " +userGrade; // Display the calculated grade
                    // -----------------------------------------------------------------

                    feedback.ForeColor = System.Drawing.Color.Black;
        
                    // 2. Set "Back to Subject" Button Text
                    homeBtn.Text = subjectName + "ဘာသာရပ်သို့ပြန်သွားမည်။"; // Now the button text is clearer

                    // 3. Hide ALL Quiz UI Elements (This addresses the question text and image)
                    btnA.Visible = btnB.Visible = btnC.Visible = false;
                    nextBtn.Visible = false;
                    quizImg.Visible = false;
                    lblQuestionNumber.Visible = false;
                    stepsContainer.Visible = false;
                    timerDisplay.Visible = false;
        
                    // --- FIX 3: Explicitly hide the Literal control containing the question text ---
                    litQuestionText.Visible = false;
                    // -------------------------------------------------------------------------------
        
                    homeBtn.Visible = true;
        
                    // Stop processing further and display results
                    return; 
                }

                // If the quiz is NOT complete, show the next question
                ShowQuestion();
                ScriptManager.RegisterStartupScript(this, GetType(), "RestartTimer", "startTimer();", true);
            }

        [Serializable]
        public class Question
        {
            public string QuestionText { get; set; }
            public string OptionA { get; set; }
            public string OptionB { get; set; }
            public string CorrectAnswer { get; set; }
            public string ImageUrl { get; set; }
        }
    }
}
