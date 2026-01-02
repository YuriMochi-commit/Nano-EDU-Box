<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SentenceType.aspx.cs" Inherits="MyProject.SentenceType" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>Typing Game</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
            a{
            text-decoration:none;
            color: black;
        }
        body {
           
            color: #70ff70; /* green text */
            font-family: monospace, Courier New, Courier  font-family: Arial, sans-serif;
           
           
            background-image:url('IMG/Bg2.png');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: 100% 100%;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            margin: 0;
        }

        /* Header */
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

       
        #textDisplay {
            background-color: rgba(255, 255, 255, 0.9);
            white-space: pre-wrap;
            font-size: 20px;
            line-height: 1.4;
            max-width: 800px;
            border: 1px solid #333;

            padding: 10px;
            margin-bottom: 20px;
            min-height: 200px;
        }
       
        .word {
            color: #0077b6; /* green */
        }

        .correct {
            color: #31572c; /* green */
            font-weight:600;
        }

        .current {
            background-color: #444;
            color: cyan;
            font-weight: bold;
            text-decoration: underline;
        }

        .wrong {
            color: red;
        }

       .score {
            margin-bottom:100px;
            font-size: 18px;
            color: #31572c;
            text-align: center;
           
            width: 800px;
            max-width: 100%;
        }
       .scoreContainer{
           display:flex;
           flex-direction:row;
           justify-content:flex-start;
       }

        #inputArea {
            width: 800px;
            font-size: 20px;
            padding: 5px;
            border: none;
            outline: none;
            background: #90a955;
            color:black;
            color: #70ff70;
            border-bottom: 2px solid #70ff70;
            display: block;
            margin: 0 auto; /* Center the input */
        } 

        /* Custom alert box styles */
.custom-alert {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: #1a1a1a;
    border: 2px solid #70ff70;
    padding: 30px;
    border-radius: 10px;
    text-align: center;
    max-width: 400px;
    box-shadow: 0 0 20px rgba(112, 255, 112, 0.3);
    z-index: 1000;
}

.custom-alert-message {
    color: #70ff70;
    font-size: 18px;
    margin-bottom: 20px;
    line-height: 1.5;
    white-space: pre-line;
}

.custom-alert-button {
    background-color: #70ff70;
    color: black;
    border: none;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    font-weight: bold;
}

.custom-alert-button:hover {
    background-color: #50cc50;
}

.overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.7);
    z-index: 999;
}

.statsContainer {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-bottom: 20px;
    flex-wrap: wrap;
}

.statBox {
    background-color: rgba(49, 87, 44, 0.8);
    border: 1px solid #70ff70;
    border-radius: 8px;
    padding: 15px;
    min-width: 100px;
    text-align: center;
}

.statLabel {
    color: #70ff70;
    font-size: 14px;
    margin-bottom: 5px;
    font-weight: bold;
}

.statValue {
    color: cyan;
    font-size: 20px;
    font-weight: bold;
}


  .header-icons {
                display: flex;
                align-items: center;
                margin: 20px 20px;
                position:left;
                 margin-bottom:150px;
    
        }

        .back-btn {
            color:  #00712D;
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
    <center >
   <div class="statsContainer"> 
       <div style="border: solid 2px green; padding:2px; width:95px; border-radius:10%; background-color:rgba(49, 87, 44, 0.8);;">
           <button id="startBtn" style="padding:2px ; outline:none; border:none; background-color: #ffff;border-radius:30px; width:100%;">Start</button>
            <div id="countdown" style="font-size: 2em; font-weight: bold; color: cyan; align-items:center;"></div>

       </div>
    <div class="statBox">
        <div class="statLabel">Word Count</div>
        <div class="statValue"><span id="currentWord">0</span>/<span id="totalWords">0</span></div>
    </div>
    <div class="statBox">
        <div class="statLabel">Time</div>
        <div class="statValue" id="timeDisplay">0s</div>
    </div>
    <div class="statBox">
        <div class="statLabel">WPM</div>
        <div class="statValue" id="wpmDisplay">0</div>
    </div>
  <div class="statBox">
        <div class="statLabel">Score</div>
        <div class="statValue" id="scoreValue">0</div>
    </div> 
    <div class="statBox">
        <div class="statLabel">Accuracy</div>
        <div class="statValue" id="accuracyDisplay">100%</div>
    </div>
</div>

<div id="textDisplay" runat="server">
    <asp:Literal ID="myLiteralControl" runat="server"></asp:Literal>
</div>

<input type="text" id="inputArea" autocomplete="off" autofocus placeholder="Start typing here..."/>
</center>

   <script>
       var textDisplay = document.getElementById('<%= textDisplay.ClientID %>');
       var text = textDisplay.textContent || textDisplay.innerText;
       var words = text.split(/\s+/).filter(function (word) {
           return word.length > 0;
       });

       // Track penalty per word (so we don’t deduct multiple times on same word)
       var wrongPenalized = new Array(words.length).fill(false);

       var currentWordIndex = 0;
       var score = 0;
       var startTime;
       var timerInterval;
       var totalTime = 0;
       var correctChars = 0;
       var totalCharsTyped = 0;

       // Initialize stats display
       function initializeStats() {
           document.getElementById('totalWords').textContent = words.length;
           document.getElementById('currentWord').textContent = '0';
           document.getElementById('timeDisplay').textContent = '0s';
           document.getElementById('wpmDisplay').textContent = '0';
           document.getElementById('scoreValue').textContent = '0';
           document.getElementById('accuracyDisplay').textContent = '100%';
       }

       // Timer function
       function startTimer() {
           timerInterval = setInterval(function () {
               totalTime++;
               updateTimeDisplay();
               updateWPMDisplay();
           }, 1000);
       }

       function updateTimeDisplay() {
           var minutes = Math.floor(totalTime / 60);
           var seconds = totalTime % 60;
           var timeString = '';

           if (minutes > 0) {
               timeString = minutes + 'm ' + seconds + 's';
           } else {
               timeString = seconds + 's';
           }

           document.getElementById('timeDisplay').textContent = timeString;
       }

       function updateWPMDisplay() {
           if (totalTime > 0) {
               var minutes = totalTime / 60;
               if (minutes <= 0) return;
               var netWPM = (correctChars / 5) / minutes;
               var wpm = Math.round(netWPM * 100) / 100;
               document.getElementById('wpmDisplay').textContent = wpm;
           }
       }

       function updateWordCount() {
           document.getElementById('currentWord').textContent = currentWordIndex;
       }

       function updateAccuracy() {
           if (totalCharsTyped > 0) {
               var accuracy = Math.round((correctChars / totalCharsTyped) * 100);
               if (accuracy > 100) accuracy = 100; // fix max 100%
               document.getElementById('accuracyDisplay').textContent = accuracy + '%';
           }
       }

       // Render text with spans
       function renderText() {
           textDisplay.innerHTML = '';
           for (var i = 0; i < words.length; i++) {
               var span = document.createElement('span');
               span.textContent = words[i] + (i !== words.length - 1 ? ' ' : '');
               span.className = 'word';
               if (i === currentWordIndex) {
                   span.className += ' current';
               }
               textDisplay.appendChild(span);
           }
       }

       // Update word highlights + scoring
       function updateHighlight(isCorrect) {
           var wordSpans = textDisplay.querySelectorAll('.word');

           if (isCorrect) {
               wordSpans[currentWordIndex].classList.remove('current', 'wrong');
               wordSpans[currentWordIndex].classList.add('correct');

               score += words[currentWordIndex].length;
               correctChars += words[currentWordIndex].length;

               wrongPenalized[currentWordIndex] = false;
               currentWordIndex++;
           } else {
               wordSpans[currentWordIndex].classList.add('wrong');

               if (!wrongPenalized[currentWordIndex]) {
                   var penalty = Math.ceil(words[currentWordIndex].length / 2);
                   score -= penalty;
                   if (score < 0) score = 0;
                   wrongPenalized[currentWordIndex] = true;
               }
           }

           document.getElementById('scoreValue').textContent = score;
           updateWordCount();
           updateWPMDisplay();
           updateAccuracy();

           if (currentWordIndex < wordSpans.length) {
               for (var i = 0; i < wordSpans.length; i++) {
                   wordSpans[i].classList.remove('current');
               }
               wordSpans[currentWordIndex].classList.add('current');
           } else {
               clearInterval(timerInterval);
               var duration = getDuration();
               var wpm = calculateWPM();
               var accuracy = Math.round((correctChars / totalCharsTyped) * 100);
               if (accuracy > 100) accuracy = 100;
               var message = "Congratulations!\n\nFinal Score: " + score + " points\nTime: " + duration + "\nWPM: " + wpm + "\nAccuracy: " + accuracy + "%";
               document.getElementById('inputArea').disabled = true;
               showCustomAlert(message);
           }
       }

       // Countdown logic
       document.getElementById('startBtn').addEventListener('click', function () {
           var countdownDisplay = document.getElementById('countdown');
           var countdown = 3; // seconds

           countdownDisplay.textContent = countdown;

           var countdownInterval = setInterval(function () {
               countdown--;
               if (countdown > 0) {
                   countdownDisplay.textContent = countdown;
               } else {
                   clearInterval(countdownInterval);
                   countdownDisplay.textContent = "Go!";

                   document.getElementById('inputArea').disabled = false;
                   document.getElementById('inputArea').focus();

                   // Start timer ONLY once here
                   startTime = new Date();
                   startTimer();

                   setTimeout(function () {
                       countdownDisplay.textContent = "";
                   }, 1000);
               }
           }, 1000);
       });

       function getDuration() {
           var minutes = Math.floor(totalTime / 60);
           var seconds = totalTime % 60;

           if (minutes > 0) {
               return minutes + " minute" + (minutes > 1 ? "s" : "") + " and " + seconds + " second" + (seconds !== 1 ? "s" : "");
           } else {
               return seconds + " second" + (seconds !== 1 ? "s" : "");
           }
       }

       function calculateWPM() {
           if (totalTime > 0) {
               var minutes = totalTime / 60;
               if (minutes <= 0) return 0;
               var netWPM = (correctChars / 5) / minutes;
               return Math.round(netWPM * 100) / 100;
           }
           return 0;
       }

       function showCustomAlert(message) {
           alert(message);
       }

       var inputArea = document.getElementById('inputArea');
       inputArea.addEventListener('input', function () {
           var currentInput = this.value;
           var targetWord = words[currentWordIndex];
           var wordSpans = textDisplay.querySelectorAll('.word');

           wordSpans[currentWordIndex].classList.remove('wrong');

           totalCharsTyped++;
           updateAccuracy();

           if (targetWord.startsWith(currentInput)) {
               wordSpans[currentWordIndex].classList.remove('wrong');
           } else {
               wordSpans[currentWordIndex].classList.add('wrong');
           }

           if (this.value.endsWith(' ') || this.value.endsWith('\n')) {
               var trimmedInput = this.value.trim();

               if (trimmedInput === targetWord) {
                   updateHighlight(true);
               } else {
                   updateHighlight(false);
               }
               this.value = '';
           }
       });

       window.onload = function () {
           initializeStats();
           renderText();

           // Disable input until countdown
           document.getElementById('inputArea').disabled = true;
       };
       function goBack() {
           window.history.back();
       }
</script>


</body>
</html>
>