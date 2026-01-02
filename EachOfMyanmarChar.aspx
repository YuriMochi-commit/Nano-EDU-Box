<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EachOfMyanmarChar.aspx.cs" Inherits="MyProject.EachOfMyanmarChar" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Typing Game with Virtual Keyboard</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
         /* Remove all unwanted space around everything */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Body full screen gradient background */
body {
    background: linear-gradient(135deg, #1a2a6c, #b21f1f, #fdbb2d);
    min-height: 100vh;
    display: flex;
    flex-direction: column; /* stack header + content */
   
}

/* Remove blue link underline globally */
a {
    text-decoration: none;
    color: black;
}

/* ---------------- HEADER ---------------- */
header {
    background-color: #00712D;
    color: white;
    width: 100%;
    padding: 0; /* remove extra padding */
    margin: 0; /* remove space around header */
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
    padding: 15px 20px;
    flex-wrap: wrap;
}

.logo {
    font-size: 26px;
    font-weight: bold;
    display: flex;
    align-items: center;
    gap: 8px;
}

/* Navigation */
nav ul {
    display: flex;
    list-style: none;
}

nav ul li {
    margin-left: 20px;
    position: relative;
}

nav ul li a {
    color: white;
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

/* Mobile menu icon */
.mobile-menu {
    display: none;
    font-size: 24px;
    cursor: pointer;
}

/* ---------------- CONTAINER ---------------- */
.container {
    width: 90%;
    max-width: 900px;
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    border-radius: 20px;
     align-items: center;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
    margin-top: 30px; /* space below navbar */
}

/* Header inside game */
.header {
    display: flex;
    justify-content: space-around;
    align-items: center;
    padding: 20px;
    background: rgba(0, 0, 0, 0.2);
}

.header-item {
    text-align: center;
    color: white;
}

/* Buttons */
.btn {
    background: rgba(254, 255, 222, 0.2);
    color: #FEFFDE;
    border: 2px solid #FEFFDE;
    padding: 10px 20px;
    border-radius: 10px;
    font-size: 18px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s;
}

.btn:hover {
    background: rgba(254, 255, 222, 0.3);
    transform: translateY(-2px);
}

/* ---------------- GAME AREA ---------------- */
.game-area {
    padding: 30px;
    text-align: center;
}

.game-panel {
    width: 100%;
    height: 300px;
    background-color: rgba(255, 255, 255, 0.3);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    margin: 0 auto 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    overflow: hidden;
    box-shadow: inset 0 0 15px rgba(0, 0, 0, 0.2);
}

.falling-character {
    position: absolute;
    top: -50px;
    font-size: 42px;
    font-weight: bold;
    color: #1a2a6c;
    text-shadow: 2px 2px 4px rgba(255, 255, 255, 0.5);
    animation: fall linear;
}

@keyframes fall {
    to {
        transform: translateY(350px);
    }
}

/* ---------------- KEYBOARD ---------------- */
 .keyboard-container {
            background: rgba(82, 115, 77, 0.85);
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }
        
        .keyboard-row {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }
        
        .key {
            width: 50px;
            height: 50px;
            margin: 5px;
            background: rgba(254, 255, 222, 0.9);
            border-radius: 8px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: 600;
            box-shadow: 0 4px 0 rgba(0, 0, 0, 0.2);
            user-select: none;
            transition: all 0.1s;
        }
        
        .key-wide {
            width: 80px;
        }
        
        .key-extra-wide {
            width: 100px;
        }
        
        .key-space {
            width: 300px;
        }
        
        .key-pressed {
            background: #fdbb2d;
            transform: translateY(4px);
            box-shadow: 0 1px 0 rgba(0, 0, 0, 0.2);
        }
        
        .instructions {
            text-align: center;
            color: white;
            margin-top: 20px;
            font-size: 16px;
            line-height: 1.6;
        }

/* ---------------- TEXT ---------------- */
.instructions {
    text-align: center;
    color: white;
    margin: 20px 0 30px;
    font-size: 16px;
    line-height: 1.6;
}

/* ---------------- BACK ARROW ---------------- */


/* ---------------- RESPONSIVE ---------------- */
@media (max-width: 768px) {
    .btn {
        padding: 8px 16px;
        font-size: 16px;
    }

    .key {
        width: 35px;
        height: 45px;
        font-size: 14px;
    }

    .key-wide { width: 60px; }
    .key-extra-wide { width: 80px; }
    .key-space { width: 180px; }

    .header-container {
        flex-direction: column;
        gap: 10px;
    }
}
  .header-icons {
        display: flex;
        align-items: center;
        margin: 20px 20px;
        position:left;
    
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
           
    <center>
    <div class="container">

        <hr />
        <div class="header" style="display:flex; justify-content:space-around;">
            <div class="header-item">
                <div class="header-label">Timer</div>
                <div class="header-value">60</div>
            </div>
            <div class="header-item">
                <div class="header-label">Score</div>
                <div class="header-value">0</div>
            </div>
            <div class="header-item">
                <div class="header-label">Errors</div>
                <div class="header-value">0</div>
            </div>
            <button class="btn">Start</button>
          
        </div>
        
        <div class="game-area">
            <div class="game-panel" id="gamePanel">
                <!-- Falling characters will appear here -->
            </div>
            
            <div class="keyboard-container">
                <!-- Row 1 -->
                <div class="keyboard-row">
                    <div class="key" data-key="`">`</div>
                    <div class="key" data-key="1">1</div>
                    <div class="key" data-key="2">2</div>
                    <div class="key" data-key="3">3</div>
                    <div class="key" data-key="4">4</div>
                    <div class="key" data-key="5">5</div>
                    <div class="key" data-key="6">6</div>
                    <div class="key" data-key="7">7</div>
                    <div class="key" data-key="8">8</div>
                    <div class="key" data-key="9">9</div>
                    <div class="key" data-key="0">0</div>
                    <div class="key" data-key="-">-</div>
                    <div class="key" data-key="=">=</div>
                    <div class="key key-wide" data-key="backspace">delete</div>
                </div>
                
                <!-- Row 2 -->
                <div class="keyboard-row">
                    <div class="key key-wide" data-key="tab">tab</div>
                    <div class="key" data-key="q">ဆ</div>
                    <div class="key" data-key="w">တ</div>
                    <div class="key" data-key="e">န</div>
                    <div class="key" data-key="r">မ</div>
                    <div class="key" data-key="t">အ</div>
                    <div class="key" data-key="y">ပ</div>
                    <div class="key" data-key="u">က</div>
                    <div class="key" data-key="i">င</div>
                    <div class="key" data-key="o">သ</div>
                    <div class="key" data-key="p">စ</div>
                    <div class="key" data-key="[">ဟ</div>
                    <div class="key" data-key="]">ဩ</div>
                    <div class="key" data-key="\\">၏</div>
                </div>
                
                <!-- Row 3 -->
                <div class="keyboard-row">
                    <div class="key key-extra-wide" data-key="capslock">caps lock</div>
                    <div class="key" data-key="a">‌ေ</div>
                    <div class="key" data-key="s">ျ</div>
                    <div class="key" data-key="d">ိ</div>
                    <div class="key" data-key="f">်</div>
                    <div class="key" data-key="g">ါ</div>
                    <div class="key" data-key="h">့</div>
                    <div class="key" data-key="j">ြ</div>
                    <div class="key" data-key="k">ု</div>
                    <div class="key" data-key="l">ူ</div>
                    <div class="key" data-key=";">း</div>
                    <div class="key" data-key="'">'</div>
                    <div class="key key-extra-wide" data-key="enter">enter</div>
                </div>
                
                <!-- Row 4 -->
                <div class="keyboard-row">
                    <div class="key key-extra-wide" data-key="shift">shift</div>
                    <div class="key" data-key="z">ဖ</div>
                    <div class="key" data-key="x">ထ</div>
                    <div class="key" data-key="c">ခ</div>
                    <div class="key" data-key="v">လ</div>
                    <div class="key" data-key="b">ဘ</div>
                    <div class="key" data-key="n">ည</div>
                    <div class="key" data-key="m">ာ</div>
                    <div class="key" data-key=",">,</div>
                    <div class="key" data-key=".">.</div>
                    <div class="key" data-key="/">/</div>
                    <div class="key key-extra-wide" data-key="shift">shift</div>
                </div>
                
                <!-- Row 5 -->
                <div class="keyboard-row">
                    <div class="key" data-key="ctrl">ctrl</div>
                    <div class="key" data-key="alt">alt</div>
                    <div class="key" data-key="cmd">cmd</div>
                    <div class="key key-space" data-key=" "> </div>
                    <div class="key" data-key="cmd">cmd</div>
                    <div class="key" data-key="alt">alt</div>
                    <div class="key" data-key="ctrl">ctrl</div>
                </div>
            </div>
            
            <div class="instructions">
                <p>Type the falling characters on your keyboard. The corresponding key will highlight when pressed.</p>
                <p>Press Start to begin the game!</p>
            </div>
        </div>
    </div>
    </center>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var gamePanel = document.getElementById('gamePanel');
            var keys = document.querySelectorAll('.key');
            var startBtn = document.querySelector('.btn');
            var timerValue = document.querySelector('.header-item:nth-child(1) .header-value');
            var scoreValue = document.querySelector('.header-item:nth-child(2) .header-value');
            var errorValue = document.querySelector('.header-item:nth-child(3) .header-value');

            var gameActive = false;
            var timer;
            var timeLeft = 60;
            var score = 0;
            var errors = 0;
            var currentCharacters = [];

            // Initialize game
            function initGame() {
                gameActive = true;
                timeLeft = 60;
                score = 0;
                errors = 0;

                timerValue.textContent = timeLeft;
                scoreValue.textContent = score;
                errorValue.textContent = errors;

                // Clear any existing characters
                currentCharacters = [];
                gamePanel.innerHTML = '';

                // Start the timer
                timer = setInterval(function () {
                    timeLeft--;
                    timerValue.textContent = timeLeft;

                    if (timeLeft <= 0) {
                        endGame();
                    }
                }, 1000);

                // Start generating characters
                generateCharacter();
            }

            // Generate a random character
            function generateCharacter() {
                if (!gameActive) return;

                var characters = 'ဆတနမအပကငသစဟဖထခလဘည၁၂၃၄၅၆၇၈၉၀';
                var randomChar = characters.charAt(Math.floor(Math.random() * characters.length));

                var charElement = document.createElement('div');
                charElement.className = 'falling-character';
                charElement.textContent = randomChar;
                charElement.style.left = Math.random() * (gamePanel.offsetWidth - 40) + "px";
                charElement.style.animationDuration = (Math.random() * 3 + 2) + "s";
                charElement.setAttribute("data-char", randomChar);

                gamePanel.appendChild(charElement);
                currentCharacters.push({
                    element: charElement,
                    char: randomChar,
                    position: 0
                });

                // Remove the character when animation completes
                charElement.addEventListener('animationend', function () {
                    if (gameActive) {
                        errors++;
                        errorValue.textContent = errors;
                        charElement.parentNode.removeChild(charElement);

                        currentCharacters = currentCharacters.filter(function (c) {
                            return c.element !== charElement;
                        });
                    }
                });

                // Schedule next character
                var nextTime = Math.random() * 1500 + 500;
                setTimeout(generateCharacter, nextTime);
            }

            // End the game
            function endGame() {
                gameActive = false;
                clearInterval(timer);

                // Remove all falling characters
                currentCharacters.forEach(function (c) {
                    if (c.element && c.element.parentNode) {
                        c.element.parentNode.removeChild(c.element);
                    }
                });
                currentCharacters = [];

                alert("Game Over!\nYour Score: " + score + "\nErrors: " + errors);
            }

            // Handle keyboard events
            document.addEventListener('keydown', function (e) {
                if (!gameActive) return;

                var key = e.key.toLowerCase();
                var found = false;

                // Highlight the pressed key
                var keyElement = document.querySelector('.key[data-key="' + key + '"]');
                if (keyElement) {
                    keyElement.classList.add('key-pressed');

                    setTimeout(function () {
                        keyElement.classList.remove('key-pressed');
                    }, 200);
                }

                // Check if pressed key matches
                currentCharacters.forEach(function (character) {
                    if (character.char.toLowerCase() === key) {
                        if (character.element && character.element.parentNode) {
                            character.element.parentNode.removeChild(character.element);
                        }
                        currentCharacters = currentCharacters.filter(function (c) {
                            return c !== character;
                        });
                        score++;
                        scoreValue.textContent = score;
                        found = true;
                    }
                });

                if (!found && key.length === 1) {
                    errors++;
                    errorValue.textContent = errors;
                }
            });

            // Start/stop button
            startBtn.addEventListener('click', function () {
                if (gameActive) {
                    endGame();
                    this.textContent = 'Start';
                } else {
                    initGame();
                    this.textContent = 'Stop';
                }
            });

            // Virtual keyboard feedback
            for (var i = 0; i < keys.length; i++) {
                (function (key) {
                    key.addEventListener('mousedown', function () {
                        this.classList.add('key-pressed');

                        if (gameActive) {
                            var keyChar = this.getAttribute("data-key");
                            var found = false;

                            currentCharacters.forEach(function (character) {
                                if (character.char.toLowerCase() === keyChar) {
                                    if (character.element && character.element.parentNode) {
                                        character.element.parentNode.removeChild(character.element);
                                    }
                                    currentCharacters = currentCharacters.filter(function (c) {
                                        return c !== character;
                                    });
                                    score++;
                                    scoreValue.textContent = score;
                                    found = true;
                                }
                            });

                            if (!found && keyChar.length === 1) {
                                errors++;
                                errorValue.textContent = errors;
                            }
                        }
                    });

                    key.addEventListener('mouseup', function () {
                        this.classList.remove('key-pressed');
                    });

                    key.addEventListener('mouseleave', function () {
                        this.classList.remove('key-pressed');
                    });
                })(keys[i]);
            }
        });

        function goBack() {
            window.history.back();
        }
</script>

</body>
</html>