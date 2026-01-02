<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Subject.aspx.cs" Inherits="EDUBox.Subject" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>ASP.NET UI Index</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
           * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
        }

        /* Header Styles */
        header {
            background-color: #00712D;
            color: white;
            padding: 0 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
            padding: 15px 0;
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }

        .logo i {
            margin-right: 10px;
        }

        nav ul {
            display: flex;
            list-style: none;
        }

        nav ul li {
            margin-left: 25px;
            position: relative; /* For dropdown positioning */
        }

        /* Consistent alignment for all nav links */
        nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s;
            padding: 8px 12px;
            border-radius: 4px;
            display: flex; /* Flex for vertical centering */
            align-items: center; /* Center icons/text vertically */
            line-height: 1.2; /* Normalize line-height to prevent descent */
        }

        nav ul li a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        nav ul li a i {
            margin-right: 8px; /* Consistent spacing for main icons */
            vertical-align: middle; /* Ensure icons don't cause baseline shift */
        }

        .login-btn {
            background-color: rgba(255, 255, 255, 0.2);
            padding: 8px 16px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            line-height: 1.2;
        }

        .mobile-menu {
            display: none;
            font-size: 24px;
            cursor: pointer;
        }

        /* Dropdown Styles */
        .dropdown {
            position: relative;
        }

        .dropdown-toggle {
            display: flex; /* Already flex from above, but explicit for clarity */
            align-items: center;
        }

        .dropdown-toggle i.fa-chevron-down {
            margin-left: 5px; /* Space after text */
            margin-right: 0; /* No extra right margin */
            vertical-align: middle; /* Align chevron perfectly */
            transition: transform 0.3s;
            font-size: 12px; /* Slightly smaller to avoid height impact */
        }

        .dropdown:hover .dropdown-toggle i.fa-chevron-down {
            transform: rotate(180deg);
        }

        .dropdown-menu {
            display: none;
            position: absolute;
            top: 100%;
            left: 0;
            background-color: #00712D;
            min-width: 200px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            border-radius: 4px;
            list-style: none;
        }

        .dropdown-menu li {
            margin: 0;
        }

        .dropdown-menu a {
            display: block;
            padding: 10px 15px;
            color: white;
            transition: background-color 0.3s;
            display: flex; /* Flex for submenu icons too */
            align-items: center;
            line-height: 1.2;
        }

        .dropdown-menu a:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .dropdown-menu a i {
            margin-right: 8px;
            vertical-align: middle;
        }

        .dropdown:hover .dropdown-menu {
            display: block;
        }

        /* Container Styles */
        .container {
            max-width: 1500px;
            margin: 10px auto;
            padding: 0 20px;
        }

        .page-title {
            text-align: center;
            margin-bottom: 30px;
            color: #00712D;
        }

        /* Card Grid Styles */
        .card-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }

        .card {
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            cursor: pointer; /* Added cursor pointer */
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15);
        }

        .card-img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }

        .card-content {
            padding: 15px;
        }

        .card-title {
            font-size: 18px;
            margin-bottom: 10px;
            color: #00712D;
        }

        .card-text {
            color: #666;
            font-size: 14px;
        }

        /* New Modal Styles */
        .modal {
            display: none; /* Hidden by default */
            position: fixed;
            z-index: 1001; /* Above header */
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto; /* 15% from the top and centered */
            padding: 25px;
            border: 1px solid #888;
            width: 80%; /* Could be more responsive */
            max-width: 500px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .close-btn {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }

        .close-btn:hover,
        .close-btn:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }

        #modalTitle {
            color: #00712D;
            margin-bottom: 20px;
        }

        /* Radio Button List Styles (FIXED for ASP.NET rendering as <ul>) */
        .radio-group-container {
            padding: 10px 0;
            text-align: left; /* Align list items to the left */
        }

        /* The ASP:RadioButtonList renders as <ul> with RepeatLayout="UnorderedList" */
        .exam-radio-list {
            list-style: none;
            padding: 0;
            display: flex;
            flex-direction: column;
            gap: 10px; /* Space between radio items */
        }
        
        /* IMPORTANT: Target the LI wrapper and style the LABEL inside it */
        .exam-radio-list li {
            list-style: none; /* Remove list bullet */
            margin: 0;
        }

        /* Style for each radio item label */
        /* Note: The asp:RadioButtonList renders input and label as siblings inside <li>, 
           so the original CSS logic for styling the label when the input is checked is kept, 
           as it often works when RepeateLayout is set to UnorderedList. */
        .exam-radio-list label {
            display: block;
            cursor: pointer;
            background-color: #f0fff0; /* Very light green background */
            border: 2px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            transition: all 0.3s;
            font-weight: 500;
            color: #333;
            text-align: left;
        }

        .exam-radio-list label:hover {
            background-color: #e0f8e0;
            border-color: #00712D;
        }

        /* Style for the CHECKED radio item: this relies on the input and label being siblings */
        .exam-radio-list input[type="radio"]:checked + label {
            background-color: #00712D; /* Main brand color when selected */
            color: white; /* White text on selection */
            border-color: #00712D;
            box-shadow: 0 0 5px rgba(0, 113, 45, 0.5);
        }

        /* Hide default radio buttons visually, but keep accessible */
        .exam-radio-list input[type="radio"] {
            position: absolute;
            opacity: 0;
            width: 0;
            height: 0;
        }

        /* Style for the Start Quiz Button */
        .start-quiz-btn {
            background-color: #00712D;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 20px;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        .start-quiz-btn:hover {
            background-color: #005a23;
        }

        /* Tablet Styles */
        @media (max-width: 992px) {
            .card-grid {
                grid-template-columns: repeat(3, 1fr);
            }

            .dropdown-menu {
                min-width: 180px;
            }
        }

        /* Mobile Styles */
        @media (max-width: 768px) {
            .mobile-menu {
                display: block;
            }

            nav ul {
                display: none;
                position: absolute;
                top: 70px;
                left: 0;
                width: 100%;
                background-color: #00712D;
                flex-direction: column;
                padding: 20px;
                box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
            }

            nav ul.show {
                display: flex;
            }

            nav ul li {
                margin: 10px 0;
                width: 100%; /* Full width on mobile */
            }

            nav ul li a {
                justify-content: space-between; /* Push chevron to right on mobile if needed */
                padding: 12px; /* Slightly more padding for touch */
            }

            /* Mobile Dropdown Adjustments */
            .dropdown-menu {
                position: static; /* Stack vertically instead of absolute */
                display: none; /* Hidden by default */
                background-color: rgba(0, 0, 0, 0.1); /* Slightly transparent for nesting */
                box-shadow: none; /* No shadow on mobile */
                margin-top: 5px;
                padding-left: 20px; /* Indent for hierarchy */
                min-width: auto; /* Full width */
                border-radius: 0;
            }

            .dropdown-menu.show {
                display: block; /* Show on toggle */
            }

            .dropdown-menu li {
                margin: 5px 0;
            }

            .dropdown-menu a {
                padding: 8px 10px;
                font-size: 16px; /* Larger touch target */
            }

            .dropdown:hover .dropdown-menu {
                display: none; /* Disable hover on mobile */
            }

            .card-grid {
                grid-template-columns: 1fr;
            }

            .card {
                display: flex;
                flex-direction: row;
                height: 150px;
            }

            .card-img {
                width: 40%;
                height: 150px;
            }

            .card-content {
                width: 60%;
                padding: 15px;
            }
        }

        /* Footer Styles */
        footer {
            background-color: #00712D;
            color: white;
            text-align: center;
            padding: 20px;
            margin-top: 50px;
        }
        
        /* Responsive adjustment for small screens */
        @media (max-width: 600px) {
            .modal-content {
                width: 95%;
                margin: 20% auto;
            }
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
        <!-- Header Section -->
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
                            <a href="#" class="dropdown-toggle">
                                <i class="fas fa-cubes-stacked"></i> Category
                                <i class="fas fa-chevron-down"></i>
                            </a>
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
        <!-- Main Content Section -->
        <div class="container">
            <h1 class="page-title">Let's Quiz</h1>
            <h2 class="page-title">Choose your subject</h2>

            <div class="card-grid">
                <!-- Removed OnItemCommand attribute (it referenced a missing handler) -->
                <asp:Repeater ID="rptSubjects" runat="server">
                    <ItemTemplate>
                        <%-- Use data-subject attribute and HTML-encode the subject to avoid JS quoting issues --%>
                        <div class="card" data-subject='<%# Server.HtmlEncode(Eval("Subject").ToString()) %>'
                             onclick="window.openModalAndSetData(this.getAttribute('data-subject'))">
                            <img src='<%# Eval("Image") %>' alt="Subject Image" class="card-img" />
                            <div class="card-content">
                                <h3 class="card-title"><%# Eval("Subject") %></h3>
                                <p class="card-text">Click to choose exam period</p>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Exam Period Selection Modal -->
        <div id="examModal" class="modal">
            <div class="modal-content">
                <span class="close-btn" onclick="window.closeModal()">&times;</span>
                <h3 id="modalTitle">Select Exam Period for [Subject Name]</h3>

                <div class="radio-group-container">
                    <asp:RadioButtonList ID="rblExamPeriod" runat="server" 
                        CssClass="exam-radio-list"
                        RepeatLayout="UnorderedList">
                        <asp:ListItem Text="ပထမလပတ် (First Term)" Value="M1" />
                        <asp:ListItem Text="ဒုတိယလပတ် (Second Term)" Value="M2" />
                        <asp:ListItem Text="တတိယလပတ် (Third Term)" Value="M3" />
                        <asp:ListItem Text="နောက်ဆုံးစာမေးပွဲ (Final Exam)" Value="FN" />
                    </asp:RadioButtonList>
                </div>

                <asp:HiddenField ID="hdnSelectedGradeId" runat="server" />
                <asp:HiddenField ID="hdnSelectedSubject" runat="server" />
                
                <!-- Added OnClientClick so client-side validation runs before postback -->
                <asp:Button ID="btnStartQuiz" runat="server" Text="Start Quiz" CssClass="start-quiz-btn"
                            OnClick="btnStartQuiz_Click" OnClientClick="return validateExamPeriod();" />
            </div>
        </div>
    </form>

    <script>
        // Global function to open the modal and set the subject/grade data
        window.openModalAndSetData = function (subjectName) {
            // 1. Set the modal title
            document.getElementById('modalTitle').innerText = 'Select Exam Period for ' + subjectName;

            // 2. Set the hidden fields to be accessible by the C# code
            document.getElementById('<%= hdnSelectedSubject.ClientID %>').value = subjectName;

            // If server set the grade hidden field already, no need to pass grade here.
            // But in case it's empty, try to set it from QueryString fallback (not required).
            // Show the modal
            document.getElementById('examModal').style.display = 'block';
        }

        // Global function to close the modal
        window.closeModal = function () {
            document.getElementById('examModal').style.display = 'none';
        }

        // Client-side validation function (prevents postback if no radio button is selected)
        function validateExamPeriod() {
            var radioListContainer = document.getElementById('<%= rblExamPeriod.ClientID %>');
            if (!radioListContainer) {
                console.error("Radio button list container not found.");
                return true;
            }

            var radioButtons = radioListContainer.querySelectorAll('input[type="radio"]');

            var isChecked = false;
            for (var i = 0; i < radioButtons.length; i++) {
                if (radioButtons[i].checked) {
                    isChecked = true;
                    break;
                }
            }

            if (!isChecked) {
                alert('Please select an exam period before starting the quiz.');
                return false; // Prevent postback
            }
            return true; // Allow postback
        }

        // Mobile menu and other DOMContentLoaded handlers
        document.addEventListener('DOMContentLoaded', function () {
            // Mobile menu toggle
            var mob = document.getElementById('mobileMenu');
            if (mob) {
                mob.addEventListener('click', function () {
                    document.getElementById('navMenu').classList.toggle('show');
                });
            }

            // Mobile dropdown toggle (only on screens ≤768px)
            var dropdownToggles = document.querySelectorAll('.dropdown-toggle');
            for (var i = 0; i < dropdownToggles.length; i++) {
                var toggle = dropdownToggles[i];
                toggle.addEventListener('click', function (e) {
                    if (window.innerWidth <= 768) {
                        e.preventDefault();
                        var submenu = this.nextElementSibling;
                        submenu.classList.toggle('show');
                    }
                });
            }

            // Close the modal if the user clicks anywhere outside of it
            window.onclick = function (event) {
                var modal = document.getElementById('examModal');
                if (event.target == modal) {
                    window.closeModal();
                }
            }

            // Re-check on resize (e.g., rotate device)
            window.addEventListener('resize', function () {
                if (window.innerWidth > 768) {
                    var allMenus = document.querySelectorAll('.dropdown-menu');
                    for (var k = 0; k < allMenus.length; k++) {
                        allMenus[k].classList.remove('show');
                    }
                }
            });
        });
        function goBack() {
            window.history.back();
        }
    </script>
</body>
</html>
