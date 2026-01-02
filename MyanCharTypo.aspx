<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyanCharTypo.aspx.cs" Inherits="MyProject.MyanCharTypo" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Myanmar Typing Practice</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
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

        
        body {  
            background-image: url('IMG/bg3.jpg');
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-size: cover; 
            color: #d4d4d4; 
            min-height: 100vh; 
          
            flex-direction: column; 
            align-items: center; 
 
        }
        
        .container { 
            width: 100%; 
            max-width: 1000px; 
            background: rgba(255, 255, 255, 0.6); 
            border-radius: 8px; 
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.5); 
            overflow: hidden; 
            margin-top: 20px; 
            
        }
        
        .typing-area { 
            padding: 20px; 
            border-bottom: 1px solid #3e3e42; 
        }
        
        .text-display { 
            background: #1e1e1e; 
            border: 1px solid #3e3e42; 
            border-radius: 4px; 
            padding: 15px; 
            min-height: 150px; 
            margin-bottom: 20px; 
            font-size: 20px; 
            line-height: 1.6; 
            color: #ce9178; 
            overflow-y: auto; 
            max-height: 200px; 
        }
        
        .input-area { 
            display: flex; 
            gap: 10px; 
        }
        
        #typing-input { 
            flex: 1; 
            padding: 12px 15px; 
            background: #1e1e1e; 
            border: 1px solid #007acc; 
            border-radius: 4px; 
            color: #d4d4d4; 
            font-size: 18px; 
            outline: none; 
        }
        
        #typing-input:focus { 
            box-shadow: 0 0 0 2px rgba(0, 122, 204, 0.5); 
        }
        a{
            text-decoration:none;
        }
        
        .btn { 
            padding: 12px 20px; 
            background: #0e639c; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
            transition: background 0.2s; 
        }
        
        .btn:hover { 
            background: #1177bb; 
        }
        
        .virtual-keyboard { 
            padding: 20px; 
            background: #2d2d30; 
        }
        
        .keyboard-title { 
            color: #569cd6; 
            margin-bottom: 15px; 
            text-align: center; 
            font-size: 18px; 
        }
        
        .keyboard-row { 
            display: flex; 
            justify-content: center; 
            margin-bottom: 8px; 
            gap: 6px; 
        }
        
        .key { 
            width: 50px; 
            height: 50px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            background: #3c3c3c; 
            border: 1px solid #5a5a5a; 
            border-radius: 4px; 
            color: #d4d4d4; 
            font-size: 18px; 
            cursor: pointer; 
            transition: all 0.2s; 
            user-select: none; 
        }
        
        .key:hover { 
            background: #4a4a4a; 
            border-color: #7a7a7a; 
        }
        
        .key:active { 
            background: #007acc; 
            transform: translateY(2px); 
        }
        
        .key-highlight { 
            background: #4ec9b0; 
            color: #1e1e1e; 
            border-color: #4ec9b0; 
            box-shadow: 0 0 10px rgba(78, 201, 176, 0.5); 
            font-weight: bold; 
        }
        
        .key-wide { 
            width: 80px; 
        }
        
        .key-extra-wide { 
            width: 120px; 
        }
        
        .key-space { 
            width: 250px; 
        }
        
        .stats { 
            display: flex; 
            justify-content: space-around; 
            padding: 15px 20px; 
            background: #2d2d30; 
            border-top: 1px solid #3e3e42; 
        }
        
        .stat-box { 
            text-align: center; 
        }
        
        .stat-value { 
            font-size: 24px; 
            color: #569cd6; 
            font-weight: bold; 
        }
        
        .stat-label { 
            font-size: 14px; 
            color: #9cdcfe; 
        }
        
        footer { 
            margin-top: 20px; 
            text-align: center; 
            color: #858585; 
            font-size: 14px; 
        }
        
        .highlight { 
            background: rgba(86, 156, 214, 0.2); 
            border-radius: 2px; 
        }
        
        .correct { 
            color: #608b4e; 
        }
        
        .incorrect { 
            color: #f44747; 
            text-decoration: underline; 
        }
        
        .instructions { 
            background: #2d2d30; 
            padding: 15px 20px; 
            margin-top: 20px; 
            border-radius: 8px; 
            max-width: 1000px; 
        }
        
        .instructions h3 { 
            color: #569cd6; 
            margin-bottom: 10px; 
        }
        
        .instructions p { 
            margin-bottom: 10px; 
            line-height: 1.5; 
        }
          .back-arrow {
    position: fixed;   /* stays in the corner */
    top: 5px;         /* distance from top */
    left: 20px;        /* distance from left */
    font-size: 80px;
    font-weight: 700;
    color: #91C788;
    text-decoration: none;
    cursor: pointer;
    z-index: 1000;     /* ensures it stays above other elements */
}

.back-arrow:hover {
    color: #DDFFBC;
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
        <div class="typing-area">
            <div class="text-display" id="text-display">
                <!-- Your ASP.NET literal control would go here -->
                <asp:Literal ID="myLiteralControl" runat="server"></asp:Literal>
            </div>
            <div class="input-area">
                <input type="text" id="typing-input" placeholder="Start typing here...">
                <button class="btn" id="reset-btn">Reset</button>
            </div>
        </div>

        <div class="virtual-keyboard">
            <h3 class="keyboard-title">Myanmar Virtual Keyboard</h3>
            <!-- Keyboard rows -->
            <div class="keyboard-row">
                <div class="key" data-key="ဆ">ဆ</div>
                <div class="key" data-key="တ">တ</div>
                <div class="key" data-key="န">န</div>
                <div class="key" data-key="မ">မ</div>
                <div class="key" data-key="အ">အ</div>
                <div class="key" data-key="ပ">ပ</div>
                <div class="key" data-key="က">က</div>
                <div class="key" data-key="င">င</div>
                <div class="key" data-key="သ">သ</div>
                <div class="key" data-key="စ">စ</div>
                <div class="key" data-key="ဟ">ဟ</div>
                <div class="key" data-key="၏">၏</div>
            </div>
            <div class="keyboard-row">
                <div class="key" data-key="ေ">ေ</div>
                <div class="key" data-key="ျ">ျ</div>
                <div class="key" data-key="ိ">ိ</div>
                <div class="key" data-key="်">်</div>
                <div class="key" data-key="ါ">ါ</div>
                <div class="key" data-key="့">့</div>
                <div class="key" data-key="ြ">ြ</div>
                <div class="key" data-key="ု">ု</div>
                <div class="key" data-key="ူ">ူ</div>
                <div class="key" data-key="း">း</div>
                <div class="key" data-key="'">'</div>
                <div class="key" data-key="-">-</div>
            </div>
            <div class="keyboard-row">
                <div class="key" data-key="ဖ">ဖ</div>
                <div class="key" data-key="ထ">ထ</div>
                <div class="key" data-key="ခ">ခ</div>
                <div class="key" data-key="လ">လ</div>
                <div class="key" data-key="ဘ">ဘ</div>
                <div class="key" data-key="ည">ည</div>
                <div class="key" data-key="ာ">ာ</div>
                <div class="key" data-key=",">,</div>
                <div class="key" data-key=".">.</div>
                <div class="key" data-key="/">/</div>
                <div class="key key-wide" data-key="Shift">Shift</div>
            </div>
            <div class="keyboard-row">
                <div class="key key-extra-wide" data-key="ဣ">ဣ</div>
                <div class="key" data-key="ဤ">ဤ</div>
                <div class="key" data-key="ဥ">ဥ</div>
                <div class="key" data-key="ဦ">ဦ</div>
                <div class="key" data-key="ဧ">ဧ</div>
                <div class="key" data-key="ဩ">ဩ</div>
                <div class="key" data-key="ဪ">ဪ</div>
                <div class="key" data-key="၎">၎</div>
                <div class="key" data-key="၊">၊</div>
                <div class="key" data-key="။">။</div>
                <div class="key key-space" data-key=" " id="space-key">Space</div>
                <div class="key key-wide" data-key="Backspace">←</div>
            </div>
        </div>

        <div class="stats">
            <div class="stat-box"><div class="stat-value" id="wpm">0</div><div class="stat-label">WPM</div></div>
            <div class="stat-box"><div class="stat-value" id="accuracy">100%</div><div class="stat-label">Accuracy</div></div>
            <div class="stat-box"><div class="stat-value" id="time">02:00</div><div class="stat-label">Time</div></div>
        </div>
    </div>

    <div class="instructions">
        <h3>How to Use</h3>
        <p>1. The next character to type will be highlighted in the text</p>
        <p>2. The corresponding key on the virtual keyboard will be highlighted with a different color</p>
        <p>3. Type the character using your keyboard or click on the virtual keyboard</p>
        <p>4. Correct characters will turn green, incorrect characters will turn red</p>
    </div>

    <footer>
        <p>Designed for VS Code 2013 support with ASP.NET Web Forms compatibility</p>
    </footer>
     </center>
    <script>
        var shiftRequiredMap = {
            // Symbols to Numbers
            '!': '1',
            '@': '2',
            '#': '3',
            '$': '4',
            '%': '5',
            '^': '6',
            '&': '7',
            '*': '8',
            '(': '9',
            ')': '0',
            '_': '-',
            '+': '=',

            // Shifted Myanmar Characters to Unshifted
            'ဈ': 'q',
            'ဝ': 'w',
            'ဣ': 'e',
            '၎င်း': 'r',
            'ဤ': 't',
            '၌': 'y',
            'ဥ': 'u',
            '၍': 'i',
            'ဿ': 'o',
            'ဏ': 'p',
            '{': '[',
            '}': ']',
            '|': '\\',
            'ဗ': 'a',
            'ှ': 's',
            'ီ': 'd',
            '္': 'f',
            'ွ': 'g',
            'ံ': 'h',
            'ဲ': 'j',
            'ဒ': 'k',
            'ဓ': 'l',
            'ဂ': ';',
            '"': "'",
            'ဇ': 'z',
            'ဌ': 'x',
            'ဃ': 'c',
            'ဠ': 'v',
            'ယ': 'b',
            'ဉ': 'n',
            'ဦ': 'm',
            '၊': ',',
            '။': '.',
            '?': '/',
            'ွ': 'ြ',
            'ဲ': 'ေ',
            'ီ': 'ိ',
            'ူ': 'ု',
            'း': '့',
            '်': '်'
        };

        function initializeText() {
            var textDisplay = document.getElementById('text-display');
            var originalText = textDisplay.innerText;
            textDisplay.innerHTML = '<span class="highlight">' + originalText[0] + '</span>' + originalText.substring(1);
            highlightKey(originalText[0]);
        }

        function highlightKey(char) {
            var keys = document.querySelectorAll('.key');
            for (var i = 0; i < keys.length; i++) {
                keys[i].classList.remove('key-highlight');
                // restore original label if changed
                if (keys[i].hasAttribute('data-original')) {
                    keys[i].textContent = keys[i].getAttribute('data-original');
                }
            }

            var shiftKey = document.querySelector('.key[data-key="Shift"]');
            var baseChar = shiftRequiredMap[char] || char;

            for (var i = 0; i < keys.length; i++) {
                if (keys[i].getAttribute('data-key') === baseChar) {
                    keys[i].classList.add('key-highlight');

                    if (shiftRequiredMap[char]) {
                        shiftKey.classList.add('key-highlight');
                        window.shiftActive = true;
                        if (!keys[i].hasAttribute('data-original')) {
                            keys[i].setAttribute('data-original', keys[i].textContent);
                        }
                        keys[i].textContent = char; // show shifted char
                    } else {
                        shiftKey.classList.remove('key-highlight');
                        window.shiftActive = false;
                    }
                    break;
                }
            }

            if (char === ' ') document.getElementById('space-key').classList.add('key-highlight');
        }

        document.addEventListener('DOMContentLoaded', function () {
            var typingInput = document.getElementById('typing-input');
            var textDisplay = document.getElementById('text-display');
            var resetBtn = document.getElementById('reset-btn');
            var keys = document.querySelectorAll('.key');
            var spaceKey = document.getElementById('space-key');
            var wpmElement = document.getElementById('wpm');
            var accuracyElement = document.getElementById('accuracy');
            var timeElement = document.getElementById('time');

            window.originalText = textDisplay.innerText;
            window.startTime = null;
            window.timerInterval = null;
            window.totalKeystrokes = 0;
            window.incorrectKeystrokes = 0;
            window.shiftActive = false;

            initializeText();
            typingInput.focus();

            var shiftMap = {
                // Row 1: Numbers and Symbols
                '1': '!',
                '2': '@',
                '3': '#',
                '4': '$', // Note: Pyidaungsu layout shows %, but a common alternative is $, so I've included both. The image you sent shows '%' on the unshifted key, which is unusual for a US keyboard base, but I'll stick to what the keyboard image shows. Let's correct this. The image shows '%' on the unshifted key. Let's assume the user wants that specific layout.
                '5': '%',
                '6': '^',
                '7': '&',
                '8': '*',
                '9': '(',
                '0': ')',
                '-': '_',
                '=': '+',

                // Row 2: QWERTY
                'q': 'ဆ',
                'w': 'တ',
                'e': 'န',
                'r': 'မ',
                't': 'အ',
                'y': 'ပ',
                'u': 'က',
                'i': 'င',
                'o': 'သ',
                'p': 'စ',
                '[': '{',
                ']': '}',
                '\\': '|',

                // Row 3: ASDF
                'a': '‌ေ',
                's': 'ျ',
                'd': 'ိ',
                'f': '်',
                'g': 'ါ',
                'h': '့',
                'j': 'ြ',
                'k': 'ု',
                'l': 'ူ',
                ';': ':',
                "'": '"',

                // Row 4: ZXCV
                'z': 'ဖ',
                'x': 'ထ',
                'c': 'ခ',
                'v': 'ဠ',
                'b': 'ဘ',
                'n': 'ည',
                'm': 'ာ',
                ',': '<',
                '.': '>',
                '/': '?',

                // Other specific keys from the image
                'ါ': 'ွ',
                'ေ': 'ဲ',
                'ိ': 'ီ',
                'ု': 'ူ',
                '့': 'း',
                'ြ': 'ွ', // A common behavior on some keyboards
                '်': '်',
            };

            // Keyboard clicks
            for (var i = 0; i < keys.length; i++) {
                keys[i].addEventListener('click', function () {
                    var keyValue = this.getAttribute('data-key');
                    if (keyValue === 'Shift') {
                        window.shiftActive = !window.shiftActive;
                        this.classList.toggle('key-highlight', window.shiftActive);
                        return;
                    } else if (keyValue === 'Backspace') {
                        typingInput.value = typingInput.value.slice(0, -1);
                    } else {
                        var charToAdd = keyValue;
                        if (window.shiftActive && shiftMap[keyValue]) {
                            charToAdd = shiftMap[keyValue];
                            window.shiftActive = false;
                            document.querySelector('.key[data-key="Shift"]').classList.remove('key-highlight');
                        }
                        typingInput.value += charToAdd;
                    }
                    var event = document.createEvent('Event');
                    event.initEvent('input', true, true);
                    typingInput.dispatchEvent(event);
                    typingInput.focus();
                });
            }

            spaceKey.addEventListener('click', function () {
                typingInput.value += ' ';
                var event = document.createEvent('Event');
                event.initEvent('input', true, true);
                typingInput.dispatchEvent(event);
                typingInput.focus();
            });

            resetBtn.addEventListener('click', function () {
                typingInput.value = '';
                window.totalKeystrokes = 0;
                window.incorrectKeystrokes = 0;
                wpmElement.textContent = '0';
                accuracyElement.textContent = '100%';
                timeElement.textContent = '02:00';
                if (window.timerInterval) { clearInterval(window.timerInterval); window.timerInterval = null; }
                window.startTime = null;
                window.shiftActive = false;
                document.querySelector('.key[data-key="Shift"]').classList.remove('key-highlight');
                initializeText();
                typingInput.focus();
            });

            typingInput.addEventListener('input', function () {
                if (!window.startTime) {
                    window.startTime = new Date();
                    window.timerInterval = setInterval(updateTimer, 1000);
                }

                var inputText = typingInput.value;
                var originalArray = window.originalText.split('');
                window.totalKeystrokes++;
                if (inputText !== window.originalText.substring(0, inputText.length)) window.incorrectKeystrokes++;

                var newHtml = '';
                for (var i = 0; i < originalArray.length; i++) {
                    if (i < inputText.length) {
                        newHtml += originalArray[i] === inputText[i] ? '<span class="correct">' + originalArray[i] + '</span>' : '<span class="incorrect">' + originalArray[i] + '</span>';
                    } else if (i === inputText.length) {
                        newHtml += '<span class="highlight">' + originalArray[i] + '</span>';
                        highlightKey(originalArray[i]);
                    } else newHtml += originalArray[i];
                }
                textDisplay.innerHTML = newHtml;

                var elapsedTime = (new Date() - window.startTime) / 60000;
                var wordsTyped = inputText.trim().length / 5;
                var wpm = Math.round(wordsTyped / elapsedTime);
                wpmElement.textContent = isFinite(wpm) ? wpm : '0';
                var accuracy = Math.round(((window.totalKeystrokes - window.incorrectKeystrokes) / window.totalKeystrokes) * 100);
                accuracyElement.textContent = isNaN(accuracy) ? '100%' : accuracy + '%';

                if (inputText === window.originalText) setTimeout(function () { alert('Congratulations! You completed the text.'); resetBtn.click(); }, 500);
            });

            function updateTimer() {
                if (!window.startTime) return;
                var elapsed = Math.floor((new Date() - window.startTime) / 1000);
                var remaining = 120 - elapsed;
                if (remaining <= 0) { clearInterval(window.timerInterval); timeElement.textContent = '00:00'; alert('Time is up!'); return; }
                var minutes = Math.floor(remaining / 60);
                var seconds = remaining % 60;
                timeElement.textContent = (minutes < 10 ? '0' : '') + minutes + ':' + (seconds < 10 ? '0' : '') + seconds;
            }
        });
        function goBack() {
            window.history.back();
        }
    </script>

</body>
</html>