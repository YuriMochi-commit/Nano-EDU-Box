<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CharTyping.aspx.cs" Inherits="MyProject.CharTyping" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Character Typing Game</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

   <style>
    a {
        text-decoration: none;
        color: black;
    }

    body {
        font-family: Arial, sans-serif;
        background: linear-gradient(to bottom, #91C788, #52734D);
        margin: 0;
      
        color: #333;
        min-height: 100vh;
    }

    .container {
        width: 90%;
        max-width: 900px;
        margin: 0 auto;
        background-color: #FEFFDE;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0,0,0,0.3);
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

    /* Game Panel */
    .gamePanel {
        width: 100%;
        height: 400px;
        margin: 20px auto;
        background-color: rgba(255, 255, 255, 0.3);
        border: 2px solid #DDDDDD;
        border-radius: 10px;
        position: relative;
        overflow: hidden;
        background-image: url('IMG/bg1.png');
        background-size: cover;
    }

    .balloon {
        position: absolute;
        width: 70px;
        height: 90px;
        background-image: url('IMG/balloon.png');
        background-size: contain;
        background-repeat: no-repeat;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 24px;
        font-weight: 700;
        color: #FEFFDE;
        bottom: -100px;
    }

    .ImagePanel {
        text-align: center;
        margin: 20px 0;
        padding: 10px;
    }

    .char-image {
        width: 100%;
        max-width: 700px;
        height: auto;
        border: 2px solid #52734D;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .instructions {
        background-color: #DDFFBC;
        padding: 20px;
        margin: 20px;
        border-radius: 10px;
        border: 1px solid #91C788;
    }

    .instructions h2 {
        color: #52734D;
        text-align: center;
    }

    /* Responsive Styles */
    @media (max-width: 768px) {
        .header-container {
            flex-direction: column;
            align-items: flex-start;
        }

        nav ul {
            flex-direction: column;
            width: 100%;
            display: none;
        }

        nav ul.active {
            display: flex;
        }

        nav ul li {
            margin: 10px 0;
        }

        .mobile-menu {
            display: block;
            color: white;
        }

        .container {
            width: 95%;
        }

        .gamePanel {
            height: 300px;
        }

        .balloon {
            width: 60px;
            height: 80px;
            font-size: 20px;
        }

        .instructions {
            font-size: 14px;
        }
    }
      .close {
            width: 120px;
            height: 40px;
            background-color: transparent;
            color: #FEFFDE;
            font-size: 24px;
            font-weight: 600;
            border: 2px solid #FEFFDE;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .close:hover {
            background-color: rgba(255, 255, 255, 0.2);
            transform: scale(1.05);
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

<script>
    // Mobile menu toggle
    document.addEventListener("DOMContentLoaded", function () {
        const mobileMenu = document.getElementById("mobileMenu");
        const navMenu = document.getElementById("navMenu");

        mobileMenu.addEventListener("click", function () {
            navMenu.classList.toggle("active");
        });
    });
    function goBack() {
        window.history.back();
    }

</script>

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
           

        <div class="container">
            
            <div class="TypoHeader">
                <div class="header-cell">
                    <asp:Label CssClass="close" ID="lblTimer1" runat="server" Text="Timer: 60s"></asp:Label>
                </div>
                <div class="header-cell">
                    <asp:Label CssClass="close" ID="lblScore" runat="server" Text="Score: 0"></asp:Label>
                </div>
                <div class="header-cell">
                    <asp:Label CssClass="close" ID="lblError" runat="server" Text="Errors: 0"></asp:Label>
                </div>
                <div class="header-cell">
                    <button type="button" class="close" id="btnStart">Start</button>
                </div>
                <div class="header-cell">
                    <button type="button" class="close" id="btnStop">Stop</button>
                </div>
            </div>
            
            <div class="gamePanel" id="gamePanel">
             
                <div class="cloud" style="top: 50px; left: 100px;"></div>
                <div class="cloud" style="top: 150px; left: 600px;"></div>
                <div class="cloud" style="top: 300px; left: 300px;"></div>
            </div>
            
           

          
            <div class="instructions">
                <h2>How to Play</h2>
                <p>1. Click the Start button to begin the game.</p>
                <p>2. Type the characters shown on the balloons before they fly away.</p>
                <p>3. Each correct character typed will increase your score.</p>
                <p>4. Each mistake will increase your error count.</p>
                <p>5. Try to get the highest score before time runs out!</p>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        // Game state
        var gameState = {
            timer: 60,
            score: 0,
            errors: 0,
            isPlaying: false,
            timerInterval: null,
            balloonInterval: null,
            characters: [
                { id: 'a', char: 'B', image: '' },
                { id: 'c', char: 'D', image: '' },
                { id: 'e', char: 'F', image: '' },
                { id: 'g', char: 'H', image: '' },
                { id: 'i', char: 'J', image: '' }
            ],
            activeBalloons: [],
            speed: 1
        };

        // Initialize game when page loads
        window.onload = function () {
            initGame();
        };

        // Initialize game
        function initGame() {
            // Add event listeners to buttons
            document.getElementById('btnStart').addEventListener('click', startGame);
            document.getElementById('btnStop').addEventListener('click', stopGame);

            // Listen for keyboard events
            document.addEventListener('keydown', handleKeyPress);
        }

        // Start the game
        function startGame() {
            if (gameState.isPlaying) return;

            gameState.isPlaying = true;
            gameState.timer = 60;
            gameState.score = 0;
            gameState.errors = 0;
            gameState.speed = 1;

            updateUI();

            // Start timer
            gameState.timerInterval = setInterval(function () {
                gameState.timer--;
                document.getElementById('lblTimer1').textContent = "Timer: " + gameState.timer + "s";

                if (gameState.timer <= 0) {
                    stopGame();
                }
            }, 1000);

            // Start balloon animation
            gameState.balloonInterval = setInterval(moveBalloons, 50);

            // Generate initial balloons
            generateBalloons();
        }

        // Stop the game
        function stopGame() {
            if (!gameState.isPlaying) return;

            gameState.isPlaying = false;
            clearInterval(gameState.timerInterval);
            clearInterval(gameState.balloonInterval);

            // Remove all balloons
            gameState.activeBalloons = [];
            var gamePanel = document.getElementById('gamePanel');
            var balloons = gamePanel.querySelectorAll('.balloon');
            for (var i = 0; i < balloons.length; i++) {
                gamePanel.removeChild(balloons[i]);
            }

            // Show game over message
            alert("Game Over!\nYour final score: " + gameState.score + "\nErrors: " + gameState.errors);
        }

        // Generate balloons with random characters
        function generateBalloons() {
            if (!gameState.isPlaying) return;

            var gamePanel = document.getElementById('gamePanel');

            // Create 5 balloons
            for (var i = 0; i < 5; i++) {
                var randomIndex = Math.floor(Math.random() * gameState.characters.length);
                var randomChar = gameState.characters[randomIndex];

                var balloon = document.createElement('div');
                balloon.className = 'balloon';
                balloon.textContent = randomChar.char;

                // Calculate position
                var leftPos = 10 + (i * 20);
                balloon.style.left = leftPos + '%';

                // Store character data for comparison
                balloon.setAttribute('data-char', randomChar.char);
                balloon.setAttribute('data-image', randomChar.image);

                gamePanel.appendChild(balloon);
                gameState.activeBalloons.push({
                    element: balloon,
                    speed: 0.5 + Math.random() * 0.5,
                    image: randomChar.image
                });
            }
        }

        // Move balloons upward
        function moveBalloons() {
            if (!gameState.isPlaying) return;

            var gamePanel = document.getElementById('gamePanel');
            var gamePanelHeight = gamePanel.offsetHeight;
            var firstBalloonToTop = Infinity;
            var topBalloonImage = null;

            for (var i = 0; i < gameState.activeBalloons.length; i++) {
                var balloon = gameState.activeBalloons[i];
                var currentBottom = parseFloat(balloon.element.style.bottom || 0);
                var newBottom = currentBottom + balloon.speed * gameState.speed;

                // Update position
                balloon.element.style.bottom = newBottom + 'px';

                // Check if balloon is at the top
                var balloonTop = gamePanelHeight - newBottom - 100;
                if (balloonTop < 0) {
                    // Balloon has reached the top
                    gamePanel.removeChild(balloon.element);
                    gameState.activeBalloons.splice(i, 1);
                    i--;

                    // Show error if balloon wasn't popped
                    gameState.errors++;
                    updateUI();
                    continue;
                }

                // Track which balloon is closest to the top
                if (balloonTop < firstBalloonToTop) {
                    firstBalloonToTop = balloonTop;
                    topBalloonImage = balloon.image;
                }
            }

            // Show image of the balloon closest to the top
            if (topBalloonImage) {
                document.getElementById('charImage').src = topBalloonImage;
            }

            // Increase speed over time
            gameState.speed += 0.001;

            // Generate new balloons if needed
            if (gameState.activeBalloons.length < 3) {
                generateBalloons();
            }
        }

        // Handle keyboard press
        function handleKeyPress(event) {
            if (!gameState.isPlaying) return;

            var keyPressed = String.fromCharCode(event.keyCode).toUpperCase();
            typeCharacter(keyPressed);
        }

        // Type a character
        function typeCharacter(char) {
            if (!gameState.isPlaying) return;

            var found = false;

            for (var i = 0; i < gameState.activeBalloons.length; i++) {
                var balloon = gameState.activeBalloons[i];

                if (balloon.element.getAttribute('data-char') === char) {
                    // Correct character
                    found = true;
                    gameState.score += 1;

                    // Create score popup
                    var popup = document.createElement('div');
                    popup.className = 'score-popup';
                    popup.textContent = '+10';
                    popup.style.left = balloon.element.style.left;
                    popup.style.bottom = balloon.element.style.bottom;
                    document.getElementById('gamePanel').appendChild(popup);

                    // Animate popup
                    setTimeout(function () {
                        popup.style.opacity = '1';
                        popup.style.bottom = (parseFloat(balloon.element.style.bottom || 0) + 100) + 'px';
                    }, 10);

                    setTimeout(function () {
                        popup.style.opacity = '0';
                    }, 500);

                    setTimeout(function () {
                        if (popup.parentNode) {
                            popup.parentNode.removeChild(popup);
                        }
                    }, 1500);

                    // Remove the balloon
                    balloon.element.parentNode.removeChild(balloon.element);
                    gameState.activeBalloons.splice(i, 1);


                    break;
                }
            }

            if (!found) {
                // Wrong character
                gameState.errors++;
                // Shake the image panel to indicate error
                var imagePanel = document.querySelector('.ImagePanel');
                imagePanel.style.transform = 'translateX(10px)';
                setTimeout(function () {
                    imagePanel.style.transform = 'translateX(-10px)';
                    setTimeout(function () {
                        imagePanel.style.transform = 'translateX(0)';
                    }, 100);
                }, 100);
            }

            updateUI();
        }

        // Update UI elements
        function updateUI() {
            document.getElementById('lblScore').textContent = "Score: " + gameState.score;
            document.getElementById('lblError').textContent = "Errors: " + gameState.errors;
        }
    </script>
</body>
</html>