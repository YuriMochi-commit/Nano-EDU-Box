<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Quiz.aspx.cs" Inherits="EDUBox.Quiz" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>EDU BOX - History Quiz</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link href="https://fonts.googleapis.com/css?family=Roboto:400,700" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />

    <style>
        /* ✅ Body background */
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f5f7fa;
            background-image: url('Picture/bg1.png');
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
        }

        /* ✅ EDU BOX Header */
        header {
            background-color: #00712D;
            color: white;
            padding: 15px 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        .header-container {
            max-width: 1100px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.5em;
            font-weight: bold;
            gap: 10px;
        }

        .logo i {
            color: #FEFFDE;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 25px;
            margin: 0;
            padding: 0;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            color: white;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s;
        }

        nav ul li a:hover {
            color: #DDFFBC;
        }

        .img{
            width:300px;
            height:300px;
        }
        /* Dropdown */
        .dropdown-menu {
            display: none;
            position: absolute;
            background-color: #00712D;
            top: 35px;
            left: 0;
            min-width: 160px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .dropdown:hover .dropdown-menu {
            display: block;
        }

        .dropdown-menu li {
            padding: 10px;
        }

        .dropdown-menu li a {
            color: white;
            font-weight: 500;
        }

        .dropdown-menu li a:hover {
            color: #FEFFDE;
        }

        /* Responsive Mobile */
        .mobile-menu {
            display: none;
            cursor: pointer;
        }

        .mobile-menu i {
            font-size: 24px;
            color: white;
        }

        @media screen and (max-width: 768px) {
            nav ul {
                flex-direction: column;
                background-color: #00712D;
                width: 100%;
                display: none;
            }

            nav ul.show {
                display: flex;
            }

            .mobile-menu {
                display: block;
            }
        }

        /* ✅ Quiz Page Design */
        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
        }

        .quiz-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
        }

        .steps-container {
            display: flex;
            justify-content: center;
            margin-bottom: 25px;
            align-items: center;
        }

        .circle {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: #ccc;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }

        .active {
            background: #00712D;
        }

        .line {
            flex: 1;
            height: 4px;
            background: #ccc;
            margin: 0 5px;
            border-radius: 2px;
        }
            /* In Quiz.aspx <style> block */

            /* Current Question */
            .circle.active {
                background: #00712D; /* Your brand green */
                border: 2px solid #005a24;
            }

            /* Completed Questions (New Class) */
            .circle.completed {
                background: #DDFFBC; /* A lighter green for completed */
                color: #00712D;
                border: 2px solid #00712D;
            }

        .header-info {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            color: #333;
            font-weight: bold;
        }

        .timer {
            color: #d9534f;
        }

        .quiz-area {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
        }

        .image-container {
            flex-basis: 40%;
        }

        #questionImage {
            width: 100%;
            border-radius: 10px;
        }

        .question-box {
            flex-basis: 55%;
        }

        #questionText {
            color: #00712D;
            margin-bottom: 15px;
        }

       

        
        .choice-btn{
            display: block;
            width: 300px;
            background: #f9f9f9;
            padding: 10px 15px;
            margin-bottom: 10px;
            border-radius: 8px;
            cursor: pointer;
            border: 1px solid #e9ecef;
        }
        .choice-btn:hover {
            background: #e9f9e9;
            border-color: #00712D;
        }
        .choice-btn.correct {
            background-color: #28a745 !important; /* Green */
            color: white !important;
        }

        .choice-btn.wrong {
            background-color: #dc3545 !important; /* Red */
            color: white !important;
        }

        .choice-btn:disabled {
            cursor: not-allowed;
            opacity: 0.8;
        }

        .submit-btn {
            background: #00712D;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #005a24;
        }
        /* Add this to your main stylesheet (e.g., style.css) */
            .quiz-feedback-center {
                text-align: center;
                /* You might also want to increase the font size for the final message */
                font-size: 1.5em; 
                padding: 20px;
                display: block; /* Ensure it takes full width for centering */
            }

        .nextBtnContainer {
            text-align: center;
            margin-top: 20px;
        }

        .nextBtnContainer .nav-button,
        .nextBtnContainer input[type="submit"],
        .nextBtnContainer button {
            background-color: #00712D;
            color: white;
            border: none;
            border-radius: 8px;
            padding: 10px 18px;
            margin: 8px;
            cursor: pointer;
            font-weight: bold;
        }

        .nextBtnContainer .nav-button:hover,
        .nextBtnContainer input[type="submit"]:hover {
            background-color: #005a24;
        }
        .header-icons {
        display: flex;
        align-items: center;
        margin: 20px 20px;
        position:left;
    
}

        .back-btn {
            color: #00712D;
            font-size: 30px;
            text-decoration: none;
            transition: transform 0.2s, opacity 0.2s;
        }

        .back-btn:hover {
            transform: scale(1.1);
            opacity: 0.9;
        }
    </style>
</head>

<body>
  
 <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <header>
        <div class="header-container">
            <div class="logo">
                <i class="fas fa-cubes"></i>
                <span>Nano EDU BOX</span>
            </div>

            <nav>
                <div class="mobile-menu" id="mobileMenu">
                    <i class="fas fa-bars"></i>
                </div>
                <ul id="navMenu">
                    <li><a href="index.aspx"><i class="fas fa-home"></i> Home</a></li>
                    <li class="dropdown">
                        <a href="#"><i class="fas fa-cubes-stacked"></i> Category <i class="fas fa-chevron-down"></i></a>
                        <ul class="dropdown-menu">
                              <li><a href="index.aspx"><i class="fas fa-scroll"></i> Quiz</a></li>
                                <li><a href="Typing.aspx"><i class="fas fa-font"></i> Typing</a></li>
                        </ul>
                    </li>
                    <li><a href="#"><i class="fas fa-address-card"></i> About Us</a></li>
                    <li><a href="#"><i class="fas fa-envelope"></i> Contact Us</a></li>
                   
                </ul>
            </nav>
        </div>
    </header>
      <div class="header-icons">
                    <a href="index.aspx" class="back-btn" onclick="goBack(); return false;">
                        <i class="fa-solid fa-circle-left"></i>
                    </a>
        </div>
        <div class="container">
            <div class="quiz-container">

                  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                <div id="stepsContainer" runat="server" class="steps-container">
                    <asp:PlaceHolder ID="phSteps" runat="server" />
                </div>
                   <div class="header-info">
                        <div>
                            <asp:Label ID="lblQuestionNumber" runat="server" Text=""></asp:Label>
                        </div>
                        <asp:Panel ID="timerDisplay" runat="server" CssClass="timer">Time: 20s 
                            <asp:Button ID="btnTimeout" runat="server" Text="Timeout"
                                OnClick="Timeout_Click"
                                UseSubmitBehavior="false"
                                style="visibility:hidden; height:0; width:0;" />
                        </asp:Panel>
                    </div>
                    <div class="quiz-area">
                        <div class="image-container">
                            <asp:Image CssClass="img" ID="quizImg" runat="server" />
                        </div>

                        <div class="question-box">
                            <h2 id="questionText"></h2>
                            <asp:Literal ID="litQuestionText" runat="server"></asp:Literal>

                            <asp:Button ID="btnA" runat="server" CssClass="choice-btn" OnClick="Answer_Click" />
                            <asp:Button ID="btnB" runat="server" CssClass="choice-btn" OnClick="Answer_Click" />
                            <asp:Button ID="btnC" runat="server" CssClass="choice-btn" OnClick="Answer_Click" />

                            <div class="nextBtnContainer">
                                <asp:Label ID="feedback" runat="server" Text="" CssClass="quiz-feedback-center"/><br />
                                <asp:Button ID="nextBtn" runat="server" Text="Next" OnClick="next_Click" CssClass="nav-button" />
                                 <asp:Button ID="homeBtn" runat="server" Text="Back to Home" Visible="false" 
    CssClass="nav-button" />
                            </div>

                        </div>
                    </div>

                </ContentTemplate>
            </asp:UpdatePanel>

           
                
                    <!-- Hidden field to detect when timer ends -->
                    <asp:HiddenField ID="hiddenTimer" runat="server" />
                </div>

            </div>
       
    </form>
    <script>
        var timer = 20;
        var countdown;
        var timerDisplay;
        var btnTimeout;

        function disableAllButtons() {
            var choiceBtns = document.querySelectorAll('.choice-btn');
            choiceBtns.forEach(function (btn) {
                btn.disabled = true;
            });
        }

        function bindChoiceButtonEvents() {
            var choiceBtns = document.querySelectorAll('.choice-btn');
            choiceBtns.forEach(function (btn) {
                btn.addEventListener('click', function () {
                    clearInterval(countdown);
                    setTimeout(function () {
                        disableAllButtons();
                    }, 150);
                });
            });
        }

        function startTimer() {
            clearInterval(countdown);
            timer = 20;
            timerDisplay = document.getElementById('timerDisplay');
            btnTimeout = document.getElementById('<%= btnTimeout.ClientID %>');

        timerDisplay.textContent = 'Time: ' + timer + 's';

        var choiceBtns = document.querySelectorAll('.choice-btn');
        choiceBtns.forEach(function (btn) { btn.disabled = false; });

        countdown = setInterval(function () {
            timer--;
            timerDisplay.textContent = 'Time: ' + timer + 's';
            if (timer <= 0) {
                clearInterval(countdown);
                disableAllButtons();
                btnTimeout.click();
            }
        }, 1000);
    }

    function initQuizScript() {
        bindChoiceButtonEvents();
        startTimer();
    }

    // ✅ On full page load
    window.onload = function () {
        initQuizScript();

        // ✅ Re-run timer + events after UpdatePanel partial refresh
        if (typeof Sys !== 'undefined' && Sys.WebForms && Sys.WebForms.PageRequestManager) {
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function () {
                initQuizScript();
            });
        }
    };
    function goBack() {
        window.history.back();
    }
</script>

</body>
</html>
