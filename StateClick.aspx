<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StateClick.aspx.cs" Inherits="MyProject.StateClick" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Myanmar Quiz</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <link rel="stylesheet" href="styles.css" />
    <style>
 
         body{
            background-image:url('IMG/bg1.png');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
         }
          /* Header */
    header {
        background-color: #00712D;
        color: white;
       
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        position: sticky;
      
        z-index: 100;
    }

    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        max-width: 1500px;
        margin: 0 auto;
        padding: 15px 0;
        flex-wrap: wrap;
    }

    .logo {
        font-size: 26px;
        font-weight: bold;
        display: flex;
        align-items: center;
    }

    nav ul {
        display: flex;
        list-style: none;
        margin: 0;
        padding: 0;
    }

    nav ul li {
        margin-left: 20px;
        position: relative;
    }

     .TypoHeader {
            width: 100%;
            height: 100px;
            background-color: #52734D;
            display: table;
            text-align: center;
        }
        
        .header-cell {
            display: table-cell;
            vertical-align: middle;
            padding: 0 15px;
        }

    nav ul li a {
        color: white;
        text-decoration: none;
        font-weight: 500;
        transition: 0.3s;
        padding: 8px 12px;
        border-radius: 4px;
        display: flex;
        align-items: center;
    }

    nav ul li a:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        background-color: #00712D;
        min-width: 180px;
        box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        border-radius: 4px;
        z-index: 1000;
    }

    .dropdown:hover .dropdown-menu {
        display: block;
    }

    .mobile-menu {
        display: none;
        font-size: 24px;
        cursor: pointer;
    }
    .stateArea {
    display: flex;
    
    gap: 20px; /* sidebar နှင့် map အကြား space */
    max-width: 1200px;
    margin: 20px auto;
      align-items: flex-start; /* Top alignment */
    flex-wrap: nowrap;
}

/* Sidebar (left) */
.sideBar {
    margin-top:200px;
    margin-left:100px;
    flex: 0 0 300px; /* Minimum 300px, flexible */
    background-color: rgba(255, 255, 255, 0.7);
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

/* Map container (right) */
.map-container {
    flex: 2 ; /* Sidebar ထက်ကျယ် */
    padding: 10px;
}

.map-container img {
    width: 300px;
    height: 500px;
    border-radius: 8px;
    margin-left:200px;
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

        .finish {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 350px;
    background: white;
    text-align: center;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 0 20px rgba(0,0,0,0.3);
    z-index: 9999;
    animation: fadeIn 0.4s ease;
}

.finish h2 {
    color: #00712D;
    margin-bottom: 15px;
}

.finish button, .finish a {
    width: 100%;
    background-color: #00712D;
    color: white !important;
    padding: 10px 0;
    text-decoration: none;
    border-radius: 8px;
    margin-top: 10px;
    border: none;
    font-size: 16px;
    cursor: pointer;
}

.finish button:hover, .finish a:hover {
    opacity: 0.85;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translate(-50%, -45%); }
    to { opacity: 1; transform: translate(-50%, -50%); }
}

.tryagain{
      width: 50%;
    background-color: #00712D;
    color: white !important;
    padding: 10px 0;
    text-decoration: none;
    border-radius: 8px;
    margin-top: 10px;
    border: none;
    font-size: 16px;
    cursor: pointer;
}


    </style>
</head>
<body>
<form id="form1" runat="server">
     

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
   
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <!-- Hidden postback trigger -->
    <asp:LinkButton ID="lnkRegionPostback" runat="server"
        OnClick="lnkRegionPostback_Click"
        UseSubmitBehavior="false"
        Style="display:none;">post</asp:LinkButton>

    <script type="text/javascript">
        function postRegion(arg) {
            __doPostBack('<%= lnkRegionPostback.UniqueID %>', arg);
        }
    </script>

    <div class="stateArea" id="gameArea">
            <asp:UpdatePanel ID="upGame" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="sideBar">
                        Time Left: <asp:Label ID="lblTimer" runat="server" Text="20"></asp:Label>
                        <h3><asp:Label ID="lblTargetRegion" runat="server"></asp:Label> ကဘယ်နေရာမှာလဲ?</h3>
                        Score: <asp:Label ID="lblScore" runat="server" Text="0"></asp:Label>
                        Last Click: <asp:Label ID="lblClicked" runat="server" Text="None"></asp:Label>

                        <!-- Finish Panel -->
                        <asp:Panel ID="pnlFinish" runat="server" CssClass="finish" Visible="false">
                            <h2>🎉 Quiz Finished!</h2>
                            <div>Score: <asp:Label ID="lblFinalScore" runat="server"/></div>
                            <div>Grade: <asp:Label ID="lblGrade" runat="server"/></div><br />
                            <asp:Button ID="btnRetry" CssClass="tryagain" runat="server" Text="🔄 Try Again" OnClick="btnRetry_Click" />
                            <a href="index.aspx">🏠 Back to Home</a>
                        </asp:Panel>
                  <asp:Timer ID="Timer1" runat="server" Interval="1000" OnTick="Timer1_Tick" />

                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                    <asp:AsyncPostBackTrigger ControlID="lnkRegionPostback" EventName="Click" />
                </Triggers>
</asp:UpdatePanel>

        <!-- Map Container -->
        <div class="map-container">
            <!-- Image from project Picture folder -->
            <img src="IMG/map1.png" usemap="#image-map" alt="Myanmar Map" style="max-width:100%; height:auto;" />

           <map name="image-map">
    <area alt="ကချင် ပြည်နယ်" href="javascript:void(0);" 
          coords="155, 135, 219, 66, 193, 30, 145, 62" shape="poly" onclick="postRegion('ကချင် ပြည်နယ်');">
    <area alt="စစ်ကိုင်း တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="104, 223, 129, 48, 71, 139" shape="poly" onclick="postRegion('စစ်ကိုင်း တိုင်းဒေသကြီး');">
    <area alt="ရှမ်း ပြည်နယ်" href="javascript:void(0);" 
          coords="140, 153, 280, 230, 173, 282" shape="poly" onclick="postRegion('ရှမ်း ပြည်နယ်');">
    <area alt="ချင်း ပြည်နယ်" href="javascript:void(0);" 
          coords="55, 148, 73, 248, 30, 243" shape="poly" onclick="postRegion('ချင်း ပြည်နယ်');">
    <area alt="မကွေး တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="73, 197, 79, 278, 128, 289" shape="poly" onclick="postRegion('မကွေး တိုင်းဒေသကြီး');">
    <area alt="နေပြည်တော်" href="javascript:void(0);" 
          coords="124, 263, 140, 280" shape="rect" onclick="postRegion('နေပြည်တော်');">
    <area alt="ရခိုင် ပြည်နယ်" href="javascript:void(0);" 
          coords="15, 231, 93, 332, 65, 248" shape="poly" onclick="postRegion('ရခိုင် ပြည်နယ်');">
    <area alt="ပဲခူး တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="92, 301, 140, 294, 149, 351, 116, 333" shape="poly" onclick="postRegion('ပဲခူး တိုင်းဒေသကြီး');">
    <area alt="ဧရာဝတီ တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="77, 369, 102, 324, 116, 387" shape="poly" onclick="postRegion('ဧရာဝတီ တိုင်းဒေသကြီး');">
    <area alt="ကယား ပြည်နယ်" href="javascript:void(0);" 
          coords="149, 286, 175, 278, 169, 306" shape="poly" onclick="postRegion('ကယား ပြည်နယ်');">
    <area alt="ကရင် ပြည်နယ်" href="javascript:void(0);" 
          coords="162, 311, 203, 359, 196, 411, 173, 363" shape="poly" onclick="postRegion('ကရင် ပြည်နယ်');">
    <area alt="မွန် ပြည်နယ်" href="javascript:void(0);" 
          coords="156, 341, 184, 409, 182, 376" shape="poly" onclick="postRegion('မွန် ပြည်နယ်');">
    <area alt="ရန်ကုန် တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="117, 338, 147, 358, 123, 370" shape="poly" onclick="postRegion('ရန်ကုန် တိုင်းဒေသကြီး');">
    <area alt="မန္တလေး တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="137, 197, 91, 235, 141, 257" shape="poly" onclick="postRegion('မန္တလေး တိုင်းဒေသကြီး');">
    <area alt="တနင်္သာရီ တိုင်းဒေသကြီး" href="javascript:void(0);" 
          coords="184, 413, 221, 445, 236, 522, 196, 573" shape="poly" onclick="postRegion('တနင်္သာရီ တိုင်းဒေသကြီး');">
        </map>

        </div>
</div>
    
</form>
    <script>
        function goBack() {
            window.history.back();
        }

    </script>
</body>
</html>


