
let score = 0;

function selectRegion(region) {
    const correctAnswer = "Region1"; // Change this for your quiz logic
    if (region === correctAnswer) {
        score++;
    } else {
        score--;
    }
    document.getElementById('scoreValue').innerText = score;

}

let timeLeft = 60;

let timer;

function startTimer() {
    timer = setInterval(function () {
        timeLeft--;
        document.getElementById("timer").innerText = timeLeft;
        if (timeLeft <= 0) {
            clearInterval(timer);
            alert("Time's up! Your final score is: " + score);
            document.getElementById("gameArea").style.display = "none";
        }
    }, 1000);
}

function checkAnswer(selectedState) {
    const correctState = document.getElementById("correctState").value;
    if (selectedState === correctState) {
        score++;
        alert("Correct!");
    } else {
        score--;
        alert("Incorrect! The correct answer was " + correctState);
    }
    document.getElementById("score").innerText = score;

    loadNextQuestion();
}

function loadNextQuestion() {
    // Load a new state question (this is a simplified implementation)
    document.getElementById("correctState").value = "Pennsylvania"; // Change as needed
}

