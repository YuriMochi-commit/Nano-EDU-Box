<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StateClickIntro.aspx.cs" Inherits="MyProject.StateClickIntro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Conquer the States</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <link rel="stylesheet" href="styles.css"></link>
   <style>
       * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
         body{
              background-image:url('IMG/bg1.png');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
         }
         .startbtn{
            width: 100px;
            height:50px;
            background-color:#52734D;
            color: #FFF085;
            font-size: 30px;
            font-weight: 800;
            border-radius: 30%;
            border:none;
            
        }
        
}
           /* Header Styles */
        header {
            background-color: #00712D;
            color: white;
           
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .header-container {
             background-color: #00712D;
        
            color: white;
            display: flex;
            font-size:20px;
            justify-content: space-between;
            align-items: center;
            max-width: 1560px;
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
         .header-icons {
        display: flex;
        align-items: center;
        margin: 20px 20px;
    
}

        .back-btn {
            color: white;
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
<body >
    
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
                       
                    </ul>
                </nav>
            </div>
        </header>

     <div class="header-icons">
                    <a href="index.aspx" class="back-btn" onclick="goBack(); return false;">
                        <i class="fa-solid fa-circle-left"></i>
                    </a>
              </div>
<form id="form1" runat="server">
        <div style="margin:40px;
                margin-left: 110px;
                display: flex;
                flex-direction: column;
                justify-content: space-around;
                border-radius: 40px;
                padding: 20px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
                background-color: rgba(255, 255, 255, 0.3);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px); 
                margin-right: 52px;
                align-items: flex-start;        
           
" >
             <h2>State Clicker</h2><br />
            <p>‌ဖော်ပြချက် - မြန်မာနိုင်ငံနဲ့ စပ်လျဉ်းပြီး မြန်မာ့မြေပုံမှာပါရှိတဲ့ ပြည်နယ်နှင့်တိုင်းဒေသကြီးများ ကို လေ့လာနိုင်မယ့် အလွန်စိတ်ဝင်စားဖို့ကောင်းတဲ့ ဂိမ်းပါ။
            သင့်လုပ်စရာကတော့ ၁ မိနစ် (၆၀ စက္ကန့်) အတွင်းမှာ ပြည်နယ်နဲ့တိုင်းဒေသကြီးများဧ်။အမည်တွေကို မြေပုံပေါ်မှာ အမြန်ဆုံး  မှန်မှန် ရွေးချယ်ရမယ့်ဂိမ်း ဖြစ်ပါတယ်။
            ကလေးငယ်များအတွက် မြန်မာနိုင်ငံအကြောင်း သိသင့်သိထိုက်တဲ့ အခြေခံပညာ ကို လွယ်လွယ်ကူကူ သင်ယူနိုင်ဖို့ ဒီဂိမ်းက အထောက်အကူဖြစ်မယ်။</p>
            <br /><br />
            <h3>Type: Social Studies Fun</h3><br />

            <h3>Format: State Cliper game</h3><br />

            <h3>Grade Levels: 4, 5, 6, 7, 8</h3><br />

                <div style="width:100%;height:100%;display:flex; align-items:center; justify-content:center; ">
                    <asp:Button ID="Button1" class="startbtn" runat="server" Text="Start" OnClick="Button1_Click" />
                </div>
        </div>
    <script src="mapScript.js">
         function goBack() {
            window.history.back();
        }
    </script>
    </form>
</body>
</html>

