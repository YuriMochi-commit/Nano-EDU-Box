<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="EDUBox.index" %>

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
            margin: 30px auto;
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

        /* Tablet Styles */
        @media (max-width: 992px) {
            .card-grid {
                grid-template-columns: repeat(3, 1fr);
            }

            /* Dropdown on tablet: Keep hover, but adjust width if needed */
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

            /* Mobile: Keep flex alignment for straight li items */
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
                              
                                <!-- Add more <li> items as needed -->
                            </ul>
                        </li>
                        <li><a href="#"><i class="fas fa-address-card"></i> About Us</a></li>
                        <li><a href="#"><i class="fas fa-envelope"></i> Contact Us</a></li>
                        <!--<li>
                            <asp:LinkButton ID="btnLogin" runat="server" CssClass="login-btn">
                                <i class="fas fa-user"></i> 
                                <asp:Literal ID="litLoginText" runat="server" Text="Login/Logout"></asp:Literal>
                            </asp:LinkButton>
                        </li> -->
                    </ul>
                </nav>
            </div>
        </header>
        
        <!-- Main Content Section -->
        <div class="container">
            <h1 class="page-title">Quiz Time!</h1>
            
            <div class="card-grid">
                <asp:Repeater ID="rptGrades" runat="server">
                    <ItemTemplate>
                        <a href='Subject.aspx?GradeId=<%# Eval("Id") %>' style="text-decoration:none; color:inherit;">
                        <div class="card">
                            <img src='<%# Eval("image") %>' alt="Image" class="card-img" />
                            <div class="card-content">
                                <h3 class="card-title"><%# Eval("Grade") %></h3>
                            </div>
                        </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </form>

    <script>
        // Mobile menu toggle
        document.getElementById('mobileMenu').addEventListener('click', function () {
            document.getElementById('navMenu').classList.toggle('show');
        });

        // Mobile dropdown toggle (only on screens ≤768px) - No arrow functions
        document.addEventListener('DOMContentLoaded', function () {
            var dropdownToggles = document.querySelectorAll('.dropdown-toggle');
            var toggleCount = dropdownToggles.length;
            for (var i = 0; i < toggleCount; i++) {
                var toggle = dropdownToggles[i];
                toggle.addEventListener('click', function (e) {
                    if (window.innerWidth <= 768) {
                        e.preventDefault(); // Prevent link navigation on mobile
                        var submenu = this.nextElementSibling;
                        submenu.classList.toggle('show');

                    
                    }
                });
            }

            // Re-check on resize (e.g., rotate device)
            window.addEventListener('resize', function () {
                if (window.innerWidth > 768) {
                    // Close all submenus on desktop
                    var allMenus = document.querySelectorAll('.dropdown-menu');
                    for (var k = 0; k < allMenus.length; k++) {
                        allMenus[k].classList.remove('show');
                    }
                }
            });
        });

       
    </script>
</body>
</html>