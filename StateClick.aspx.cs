using System;
using System.Web.UI;

namespace MyProject
{
    public partial class StateClick : System.Web.UI.Page
    {
        private static readonly string[] Regions = new string[]
{
    "ကချင် ပြည်နယ်",   // Kachin State
    "စစ်ကိုင်း တိုင်းဒေသကြီး", // Sagaing District
    "ရှမ်း ပြည်နယ်",   // Shan State
    "ချင်း ပြည်နယ်",   // Chin State
    "မကွေး တိုင်းဒေသကြီး", // Magway District
    "နေပြည်တော်",     // Nay Pyi Taw
    "ရခိုင် ပြည်နယ်",   // Rakhine State
    "ပဲခူး တိုင်းဒေသကြီး", // Bago District
    "ဧရာဝတီ တိုင်းဒေသကြီး", // Ayeyarwady District
    "ကယား ပြည်နယ်",   // Kayah State
    "ကရင် ပြည်နယ်",   // Kayin State
    "မွန် ပြည်နယ်",    // Mon State
    "ရန်ကုန် တိုင်းဒေသကြီး", // Yangon District
    "မန္တလေး တိုင်းဒေသကြီး", // Mandalay District
    "တနင်္သာရီ တိုင်းဒေသကြီး" // Tanintharyi District
};


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Score"] = 0;
                Session["TimeLeft"] = 30;
                lblScore.Text = "0";
                lblTimer.Text = "20";
                SetRandomTarget();

            }

        }
        protected override void Render(HtmlTextWriter writer)
        {
            foreach (string region in Regions)
            {
                ClientScript.RegisterForEventValidation(lnkRegionPostback.UniqueID, region);
            }
            base.Render(writer);
        }


        // Timer tick every second
        protected void Timer1_Tick(object sender, EventArgs e)
        {
            int timeLeft = (int)Session["TimeLeft"];
            timeLeft--;
            Session["TimeLeft"] = timeLeft;
            lblTimer.Text = timeLeft.ToString();

            if (timeLeft <= 0)
            {
                Timer1.Enabled = false;
                pnlFinish.Visible = true;
                lblFinalScore.Text = Session["Score"].ToString();
                lblGrade.Text = GetGrade((int)Session["Score"]);
            }
        }

        // Handle image map click postback
        protected void lnkRegionPostback_Click(object sender, EventArgs e)
        {
            string clickedRegion = Request["__EVENTARGUMENT"];
            lblClicked.Text = clickedRegion;

            string target = lblTargetRegion.Text;

            if (clickedRegion == target)
            {
                int score = (int)Session["Score"] + 1;
                Session["Score"] = score;
                lblScore.Text = score.ToString();
                SetRandomTarget();
            }
            else
            {
                int score = (int)Session["Score"] - 1;
                Session["Score"] = score;
                lblScore.Text = score.ToString();
                SetRandomTarget();
            }
        }

        // Retry button
        protected void btnRetry_Click(object sender, EventArgs e)
        {
            Session["Score"] = 0;
            Session["TimeLeft"] = 30;
            lblScore.Text = "0";
            lblTimer.Text = "20";
            lblClicked.Text = "None";
            pnlFinish.Visible = false;
            Timer1.Enabled = true;
            SetRandomTarget();
        }

        // Set a new random target region
        private void SetRandomTarget()
        {
            Random rnd = new Random();
            int index = rnd.Next(Regions.Length);
            lblTargetRegion.Text = Regions[index];
        }

        // Simple grade logic
        private string GetGrade(int score)
        {
            if (score >= 8) return "A+";
            if (score >= 6) return "A";
            if (score >= 4) return "B";
            if (score >= 2) return "C";
            return "D";
        }
    }
}
