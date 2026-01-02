<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashBoard.aspx.cs" Inherits="EDUBox.AdminDashBoard" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
   <style>
/* Basic Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background-color: #f5f7f9;
    color: #333;
    display: flex;
    min-height: 100vh;
    flex-direction: row;
}

/* Sidebar */
.sidebar {
    width: 250px;
    background-color: #00712D;
    color: white;
    padding: 20px 0;
    
    height: 100vh;
    position: fixed;
    overflow-y: auto;
    transition: all 0.3s ease;
    z-index: 1000;
}

.sidebar.collapsed {
    transform: translateX(-100%);
}

.logo {
    text-align: center;
    padding: 20px;
    font-size: 24px;
    font-weight: bold;
    border-bottom: 1px solid #658c5f;
    margin-bottom: 20px;
}

.menu-item {
    padding: 15px 20px;
    display: flex;
    align-items: center;
    color: white;
    text-decoration: none;
    transition: all 0.3s;
    border-left: 4px solid transparent;
    cursor: pointer;
}

.menu-item i {
    margin-right: 10px;
    font-size: 18px;
}

.menu-item:hover, .menu-item.active {
    background-color: #5A8055;
    border-left: 4px solid #FFF085;
}

.submenu {
    padding-left: 30px;
    max-height: 0;
    overflow: hidden;
    transition: max-height 0.3s ease;
}

.submenu.show {
    max-height: 500px; /* enough to show all items */
}

.submenu-item {
    padding: 12px 20px;
    display: block;
    color: white;
    text-decoration: none;
    transition: all 0.3s;
}

.submenu-item:hover, .submenu-item.active {
    color: white;
    background-color: #5A8055;
}

/* Hamburger for mobile */
.hamburger {
    display: none;
    font-size: 28px;
    color: white;
    padding: 10px 20px;
    cursor: pointer;
}

/* Main Content */
.main-content {
    width: calc(100vw - 250px);
    margin-left: 250px;
    padding: 20px;
    transition: all 0.3s ease;
}

.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 15px 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    margin-bottom: 20px;
}

.user-info {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-info img {
    width: 45px;
    height: 45px;
    border-radius: 50%;
}

/* Dashboard Cards */
.dashboard {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.dashboard .card {
    flex: 1;
    min-width: 200px;
    text-align: center;
    padding: 20px;
    background-color: white;
    border-radius: 8px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
}

.stat-card i {
    font-size: 36px;
    color: #00712D;
    margin-bottom: 10px;
}

.stat-card h3 {
    font-size: 28px;
    margin-bottom: 5px;
    color: #52734D;
}

/* Forms */
.form-group {
    margin-bottom: 15px;
}

.form-row {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.form-row .form-group {
    flex: 1;
    min-width: 150px;
}

.form-label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: #52734D;
}

.form-control {
    width: 100%;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

/* Buttons */
.btn {
    padding: 10px 15px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    font-weight: 500;
}

.btn-primary {
    background-color: #52734D;
    color: #FFF085;
}

.btn-primary:hover {
    background-color: #5A8055;
}

/* Table */
.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table th, .data-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
}

.data-table th {
    background-color: #52734D;
    color: #FFF085;
}

.data-table tr:nth-child(even) {
    background-color: #f9f9f9;
}

.data-table tr:hover {
    background-color: #f1f1f1;
}

/* ===== Dropdowns ===== */
#ddlGradeView,
#ddlSubjectView,
#ddlTestView {
    width: 200px;
    padding: 10px 12px;
    margin-right: 15px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 16px;
    background-color: white;
    color: #333;
    transition: border-color 0.3s, box-shadow 0.3s;
}

#ddlGradeView:focus,
#ddlSubjectView:focus,
#ddlTestView:focus {
    outline: none;
    border-color: #52734D;
    box-shadow: 0 0 5px rgba(82, 115, 77, 0.5);
}

/* Container for dropdowns (optional) */
.dropdown-container {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    margin-bottom: 20px;
}

/* ===== GridView ===== */
#gvQuestions {
    width: 100%;
    border-collapse: collapse;
    margin-top: 15px;
    font-size: 16px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
}

/* Table header */
#gvQuestions th {
    background-color: #52734D;
    color: #FFF085;
    padding: 12px 15px;
    text-align: left;
}

/* Table rows */
#gvQuestions td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
}

/* Alternate row colors */
#gvQuestions tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* Hover effect */
#gvQuestions tr:hover {
    background-color: #f1f1f1;
}

/* Edit row background */
#gvQuestions .edit-row {
    background-color: #FFF9E6 !important;
}

/* Buttons inside GridView */
#gvQuestions .aspNetDisabled {
    opacity: 0.6;
    cursor: not-allowed;
}

#gvQuestions input[type="submit"],
#gvQuestions input[type="button"],
#gvQuestions .btn {
    background-color: #00712D;
    color: white;
    border: none;
    border-radius: 5px;
    padding: 6px 12px;
    cursor: pointer;
    transition: background-color 0.3s;
}

#gvQuestions input[type="submit"]:hover,
#gvQuestions input[type="button"]:hover,
#gvQuestions .btn:hover {
    background-color: #5A8055;
}

/* ===== Grade GridView ===== */
#gvGrades {
    width: 400px;
    border-collapse: collapse;
    margin-top: 15px;
    font-size: 16px;
    box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    border-radius: 8px;
    overflow: hidden;
    background-color: white;
}

/* Table header */
#gvGrades th {
    background-color: #00712D; /* Green header */
    color: white; /* Light yellow text */
    padding: 12px 15px;
    text-align: left;
}

/* Table rows */
#gvGrades td {
    padding: 12px 15px;
    border-bottom: 1px solid #eee;
    vertical-align: middle;
}

/* Alternate row colors */
#gvGrades tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* Hover effect */
#gvGrades tr:hover {
    background-color: #f1f1f1;
}

/* Edit row background */
#gvGrades .edit-row {
    background-color: #FFF9E6 !important;
}

/* Buttons inside GridView */
#gvGrades input[type="submit"],
#gvGrades input[type="button"],
#gvGrades .btn {
    background-color: #52734D;
    color: #FFF085;
    border: none;
    border-radius: 5px;
    padding: 6px 12px;
    cursor: pointer;
    transition: background-color 0.3s;
}

#gvGrades input[type="submit"]:hover,
#gvGrades input[type="button"]:hover,
#gvGrades .btn:hover {
    background-color: #5A8055;
}

/* Disabled buttons */
#gvGrades .aspNetDisabled {
    opacity: 0.6;
    cursor: not-allowed;
}

/* Responsive */
@media (max-width: 768px) {
    #gvGrades {
        font-size: 14px;
    }
}


/* Responsive */
@media (max-width: 768px) {
    .dropdown-container {
        flex-direction: column;
    }
    #ddlGradeView,
    #ddlSubjectView,
    #ddlTestView {
        width: 100%;
        margin-right: 0;
    }
}


/* Responsive */
@media (max-width: 992px) {
    .sidebar {
        width: 200px;
    }
    .main-content {
        width: calc(100vw - 200px);
        margin-left: 200px;
    }
}

@media (max-width: 768px) {
    body {
        flex-direction: column;
    }
    .hamburger {
        display: block;
    }
    .sidebar {
        position: absolute;
        left: -100%;
        top: 0;
        width: 250px;
        height: 100vh;
        z-index: 1000;
    }
    .sidebar.show {
        left: 0;
    }
    .main-content {
        width: 100%;
        margin-left: 0;
        padding: 15px;
    }
    .dashboard {
        flex-direction: column;
    }
}


    /* Excel Upload Section Styling */
    #excel-upload-section {
        background-color: #f9f9f9; /* light background */
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        width: 90%;
        max-width: 800px;
        margin: 20px auto;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        font-family: Arial, sans-serif;
    }

    #excel-upload-section h2 {
        color: #333;
        margin-bottom: 15px;
    }

    #excel-upload-section h3 {
        color: #555;
        margin-top: 25px;
        margin-bottom: 10px;
    }

    #excel-upload-section table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    #excel-upload-section table th,
    #excel-upload-section table td {
        border: 1px solid #ccc;
        padding: 8px 12px;
        text-align: center;
    }

    #excel-upload-section table th {
        background-color: #f0f0f0;
        color: #333;
    }

    #excel-upload-section table tr:nth-child(even) {
        background-color: #fafafa;
    }

    /* FileUpload & Button Styling */
    #excel-upload-section input[type="file"] {
        margin-top: 10px;
        margin-bottom: 10px;
    }

    #excel-upload-section input[type="submit"],
    #excel-upload-section .btnUpload {
        background-color: #4CAF50;
        color: white;
        padding: 8px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin-top: 5px;
    }

    #excel-upload-section input[type="submit"]:hover,
    #excel-upload-section .btnUpload:hover {
        background-color: #45a049;
    }

    #lblMsg {
        display: block;
        margin-top: 10px;
        color: red;
        font-weight: bold;
    }


}

</style>



</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="logo">Admin Panel</div>
            <a href="#" class="menu-item " onclick="showSection('dashboard'); return false;">
                <i class="fas fa-tachometer-alt"></i> Dashboard
            </a>
            <a href="#" class="menu-item  " onclick="toggleSubmenu('history-submenu'); return false;">
                <i class="fas fa-scroll"></i> Quiz Add
            </a>
            <div id="history-submenu" class="submenu">
               <a href="#" class="submenu-item " onclick="showSection('quiz-add'); return false;">Add Data</a>
                <a href="#" class="submenu-item" onclick="showSection('quiz-view'); return false;">View All Data</a>

            </div>
             <a href="#" class="menu-item" onclick="showSection('grade-view'); return false;">

                <i class="fas fa-graduation-cap"></i> View All Grade
            </a>
            <a href="#" class="menu-item" onclick="showSection('excel-upload-section'); return false;">
                <i class="fas fa-file-excel"></i> Upload Excel
            </a>

           <div id="geography-submenu" class="submenu">
              <!--  <a href="#" class="submenu-item active" onclick="showSection('geography-management'); return false;">Add Grade</a> -->

         </div>
          <a href="#" class="menu-item" onclick="showSection('subject-view'); return false;"> <i class="fas fa-book"></i>Add & View All Subject</a>
            
          
          
        </div>
      

        <!-- Main Content -->
        <div class="main-content">
            <!-- Header -->
            <div class="header">
                <h2 runat="server">👋 Welcome To Admin Dashboard,  <%=  Session["AdminName"]%> 🎉</h2>
                
            </div>
        
            <!-- Dashboard Section -->
            <div id="dashboard" class="content-section ">
                <h3 class="section-title">Dashboard Overview</h3>
                
                <div class="dashboard">
                    <div class="card stat-card">
                        <i class="fas fa-scroll"></i>
                        <h3><asp:Label ID="lblQuestionsCount" runat="server" Text="0" /></h3>
                        <p>Questions</p>
                    </div>
                    <div class="card stat-card">
                        <i class="fas fa-book"></i>
                        <h3><asp:Label ID="lblSubjectCount" runat="server" Text="0" /></h3>
                        <p>Subjects</p>
                    </div>
                    <div class="card stat-card">
                        <i class="fas fa-calendar-days"></i>
                        <h3><asp:Label ID="lblMonthlyTestCount" runat="server" Text="0" /></h3>
                        <p>Monthly Test</p>
                    </div>
                    <div class="card stat-card">
                        <i class="fas fa-graduation-cap"></i>
                        <h3><asp:Label ID="lblGradeCount" runat="server" Text="0" /></h3>
                        <p>Grade</p>
                    </div>
                </div>
                
               <div class="card">
                <h3 class="section-title">Admin Details</h3>


                </div>
         </div>

    <div id="quiz-add" class="content-section" style="display: none;">
    <h3 class="section-title">Quiz Add</h3>
    <div class="card">    

        <h3>Add New Quiz Record</h3>
        <div class="form-group">
            <label class="form-label">Question</label>
            <asp:TextBox runat="server" ID="txtQuestion" CssClass="form-control" placeholder="Enter question" />
        </div>
        
        <div class="form-row">
            <div class="form-group">
                <label class="form-label">Option 1</label>
                <asp:TextBox runat="server" ID="txtChoice1" CssClass="form-control" placeholder="Enter choice 1" />
            </div>
            <div class="form-group">
                <label class="form-label">Option 2</label>
                <asp:TextBox runat="server" ID="txtChoice2" CssClass="form-control" placeholder="Enter choice 2" />
            </div>
            <div class="form-group">
                <label class="form-label">Answer</label>
                <asp:TextBox runat="server" ID="txtAnswer" CssClass="form-control" placeholder="Enter answer" />
            </div>
        </div>
        
        <div class="form-row">
            <div class="form-group">
                  <label class="form-label">Grade</label>
             <asp:DropDownList ID="ddlGenGrade" runat="server" CssClass="form-control"
                AutoPostBack="true" OnSelectedIndexChanged="ddlGenGrade_SelectedIndexChanged">
            </asp:DropDownList>
            </div>
            <div class="form-group">
                <label class="form-label">Monthly Exam</label>
                <asp:DropDownList runat="server" ID="ddlGenMonth" CssClass="form-control">
                    <asp:ListItem Text="ပထမ လပတ်" Value="M1" />
                    <asp:ListItem Text="ဒုတိယ လပတ်" Value="M2" />
                    <asp:ListItem Text="တတိယ လပတ်" Value="M3" />
                    <asp:ListItem Text="နောက်ဆုံးစာမေးပွဲ" Value="FN" />
                </asp:DropDownList>
            </div>
             <div class="form-group">
                    <label class="form-label">Subject</label>
                  <asp:DropDownList ID="ddlGenSubject" runat="server" CssClass="form-control">
                    <asp:ListItem Text="--Select Subject--" Value="0" />
                </asp:DropDownList>
                </div>

            </div>
        <div class="form-row">

            <div class="form-group">
                <label class="form-label">Image</label>
                <div class="file-upload">
                    <div class="file-upload-btn">Choose File</div>
                    <asp:FileUpload runat="server" ID="fuGenImage" CssClass="form-control" onchange="previewImage(this)" />
                </div>

                <div class="file-name" id="gen-file-name">No file chosen</div>
                
            </div>
              
         


        </div>
        
       <asp:Button runat="server" ID="btnAddGen" Text="Add Record" CssClass="btn btn-primary" OnClick="btnAddGen_Click" />

    </div>
</div>

            <div class="content-section" id="excel-upload-section" style="display:none;">

                <h2>Upload Quiz Excel</h2>
              <asp:FileUpload ID="fuExcel" runat="server" />
            <asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
                  <h3>Example Excel Format:</h3>
                <table border="1" cellpadding="5" cellspacing="0">
                    <tr>
                        <th>Grade</th>
                        <th>Subject</th>
                        <th>Month</th>
                        <th>Question</th>
                        <th>OptionA</th>
                        <th>OptionB</th>
                        <th>Answer</th>
                    </tr>
                    <tr>
                        <td>Grade 1</td>
                        <td>English</td>
                        <td>ပထမလပတ်</td>
                        <td>What is A?</td>
                        <td>Apple</td>
                        <td>Ant</td>
                        <td>A</td>
                    </tr>
                    <tr>
                        <td>Grade 1</td>
                        <td>Maths</td>
                        <td>ဒုတိယလပတ်</td>
                        <td>2+2</td>
                        <td>3</td>
                        <td>4</td>
                        <td>4</td>
                    </tr>
                </table>

                 
                </div>

        <!--View All Data -->
        <div id="quiz-view" class="content-section" style="display: none;">
            <h3 class="section-title">Recent Quiz Records</h3>
            <div class="card">
               <div class="dropdown-container">
                <asp:DropDownList ID="ddlGradeView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlGradeView_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlSubjectView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSubjectView_SelectedIndexChanged"></asp:DropDownList>
                <asp:DropDownList ID="ddlTestView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlTestView_SelectedIndexChanged">
                    <asp:ListItem Text="ပထမလပတ်" Value="M1"></asp:ListItem>
                    <asp:ListItem Text="ဒုတိယလပတ်" Value="M2"></asp:ListItem>
                    <asp:ListItem Text="တတိယလပတ်" Value="M3"></asp:ListItem>
                    <asp:ListItem Text="နောက်ဆုံးစာမေးပွဲ" Value="FN"></asp:ListItem>
                </asp:DropDownList>
                   <asp:HiddenField ID="hfActiveSection" runat="server" />

            </div>


                <!-- Grid to show Questions -->
               <asp:GridView ID="gvQuestions" runat="server" AutoGenerateColumns="false" DataKeyNames="Id" 
                OnRowEditing="gvQuestions_RowEditing" OnRowUpdating="gvQuestions_RowUpdating"
                OnRowCancelingEdit="gvQuestions_RowCancelingEdit" OnRowDeleting="gvQuestions_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="QuestionText" HeaderText="Question" />
                    <asp:BoundField DataField="OptionA" HeaderText="Option A" />
                    <asp:BoundField DataField="OptionB" HeaderText="Option B" />
                    <asp:BoundField DataField="CorrectAnswer" HeaderText="Answer" />
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
                </Columns>
            </asp:GridView>


            </div>
        </div>

                   <!-- View All Grades -->
            <div id="grade-view" class="content-section" style="display: none;">
                <div class="card">
                    <h3>All Grades</h3>
                    <asp:GridView ID="gvGrades" runat="server" AutoGenerateColumns="false" DataKeyNames="Id"
                        OnRowEditing="gvGrades_RowEditing" 
                        OnRowUpdating="gvGrades_RowUpdating"
                        OnRowCancelingEdit="gvGrades_RowCancelingEdit"
                        OnRowDeleting="gvGrades_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="Grade" HeaderText="Grade Name" />
                            <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <asp:ScriptManager ID="ScriptManager1" runat="server" />


      <asp:UpdatePanel ID="updSubjects" runat="server" UpdateMode="Conditional">
    <ContentTemplate>
        <div id="subject-view" class="content-section" style="display:none;">
            <div class="card">
                <h3>Manage Subjects</h3>
                <div class="form-group">
                    <label class="form-label">Select Grade</label>
                    <asp:DropDownList ID="ddlSubjectViewGrade" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="ddlSubjectViewGrade_SelectedIndexChanged" CssClass="form-control">
                    </asp:DropDownList>
                </div>

                <!-- Insert new Subject -->
                <div class="form-group" style="margin-top:15px;">
                    <label class="form-label">New Subject Name</label>
                    <asp:TextBox ID="txtNewSubject" runat="server" CssClass="form-control" placeholder="Enter subject" />
                    <asp:Button ID="btnAddNewSubject" runat="server" Text="Add Subject" CssClass="btn btn-primary"
                        OnClick="btnAddNewSubject_Click" style="margin-top:10px;" />
                </div>

                <!-- Subject Grid -->
                <asp:GridView ID="gvSubjects" runat="server" AutoGenerateColumns="false" DataKeyNames="Id"
                    OnRowEditing="gvSubjects_RowEditing" OnRowUpdating="gvSubjects_RowUpdating" 
                    OnRowCancelingEdit="gvSubjects_RowCancelingEdit" OnRowDeleting="gvSubjects_RowDeleting"
                    CssClass="data-table" style="margin-top:20px;">
                    <Columns>
                        <asp:BoundField DataField="Subject" HeaderText="Subject Name" />
                        <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="ddlSubjectViewGrade" EventName="SelectedIndexChanged" />
        <asp:AsyncPostBackTrigger ControlID="btnAddNewSubject" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>

      
    </form>

   <script>
       // ===============================
       // Toggle submenus and save state
       // ===============================
       function toggleSubmenu(id) {
           const submenu = document.getElementById(id);
           if (!submenu) return;

           submenu.classList.toggle('show');

           // Save submenu state in localStorage
           const state = submenu.classList.contains('show') ? 'open' : 'closed';
           localStorage.setItem("submenu_" + id, state);
       }

       // ===============================
       // Show a specific section
       // ===============================
       function showSection(sectionId) {
           // Hide all sections
           document.querySelectorAll('.content-section').forEach(function(sec){  sec.style.display = 'none'});

           // Remove 'active' from all menu items
           document.querySelectorAll('.menu-item, .submenu-item').forEach(function(item) { item.classList.remove('active')});

           // Show the target section
           const targetSection = document.getElementById(sectionId);
           if (targetSection) targetSection.style.display = 'block';

           // Set 'active' class on the corresponding menu/submenu item
           const selector = "[onclick*='showSection(\\'" + sectionId + "\\')']";
           document.querySelectorAll(selector).forEach(function(item){  item.classList.add('active')});

           // Update hidden field for server-side persistence
           const hf = document.getElementById('<%= hfActiveSection.ClientID %>');
        if (hf) hf.value = sectionId;

        // Save active section in localStorage for page reload
        localStorage.setItem("activeSection", sectionId);
    }

    // ===============================
    // File upload preview
    // ===============================
    function previewImage(input) {
        const fileNameEl = document.getElementById('gen-file-name');
        if (!fileNameEl) return;

        // Update file name display
        if (input.files && input.files[0]) {
            fileNameEl.textContent = input.files[0].name;

            // Optional image preview (ensure you have <img id="preview-img"> in HTML)
            const previewImg = document.getElementById('preview-img');
            if (previewImg) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    previewImg.src = e.target.result;
                    previewImg.style.display = 'block';
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    }

    // ===============================
    // DOMContentLoaded - Initialization
    // ===============================
    document.addEventListener('DOMContentLoaded', function() {
        // Restore last active section (default to 'dashboard')
        const lastSection = localStorage.getItem("activeSection") || "dashboard";
        showSection(lastSection);

        // Restore submenu states
        document.querySelectorAll(".submenu").forEach(function(submenu)  {
            const state = localStorage.getItem("submenu_" + submenu.id);
        if (state === "open") submenu.classList.add("show");
    });

    // Create mobile hamburger menu
    const hamburger = document.createElement('div');
    hamburger.classList.add('hamburger');
    hamburger.innerHTML = '<i class="fas fa-bars"></i>';
    document.body.prepend(hamburger);

    const sidebar = document.querySelector('.sidebar');
    hamburger.addEventListener('click', function() { sidebar.classList.toggle('show')});
    });

    // ===============================
    // PageLoad for ASP.NET AJAX postbacks
    // ===============================
    function pageLoad(sender, args) {
        const activeIdField = document.getElementById('<%= hfActiveSection.ClientID %>');
        const sectionId = activeIdField ? activeIdField.value : 'dashboard';
        if (sectionId) showSection(sectionId);

        console.log("pageLoad called. Active section set to: " + sectionId);
    }
</script>


</body>
</html>