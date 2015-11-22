import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

Window {
    id: window1
    color: "#e5ffe5"
    title: "Speed Match"
    width: Screen.desktopAvailableWidth/2
    height: Screen.desktopAvailableHeight/2

    visible: true

    //increments when user answers correctly and decrements more when user answers incorrectly
    property int score : 0

    //stores the number of correct responses the user has put
    property int numberOfCorrect: 0

    //stores the number of wrong responses the user has put
    property int numberOfWrong: 0

    //amount of time for each game
    property int initialTimeRemaining: 20

    //time remaining until end of game
    property int timeRemaining: 20

    //determines when pressing the left and right arrow will check if the image is correct
    //checking begins once the second image is shown, the first is always shown
    property bool startGame: false

    //displays an image for a brief while to affirm if user's input was correct or wrong
    Image {
        id: correctOrWrongImage
        anchors.left: currentImage.right
        height: currentImage.height / 3
        anchors.verticalCenter: currentImage.verticalCenter
        fillMode: Image.PreserveAspectFit

        OpacityAnimator {
            id: animateOpacity
            target: correctOrWrongImage
            from: 1.0
            to: 0
            duration: 300
        }

        function display(url){
            source = url
            animateOpacity.start()
        }

    }

    Timer {
        id: timerToEndGame
        interval: 1000
        repeat: true
        onTriggered: {
            timeRemaining--
            if (timeRemaining === 0)
            {
                timerToEndGame.stop()
                endGame_rectangle.opacity = 1
                scoreText.focus = false
            }
        }
    }

    ScoreAnimationText {
        id: addOne
        anchors.top: scoreText.bottom
        anchors.right: scoreText.right
        color: "green"
        text: "+25"

        //sets nested properties in ScoreAnimationText
        startMargin: 0
        endMargin: -10
    }

    ScoreAnimationText {
        id: minusOne
        anchors.top: scoreText.bottom
        anchors.right: scoreText.right
        color: "red"
        text: "-100"

        //sets nested properties in ScoreAnimationText
        startMargin: -10
        endMargin: 0
    }

    Rectangle {
        id: endGame_rectangle
        width: window1.width
        height: window1.height
        z: 9999

        color: "black"
        opacity: 0.0


        Rectangle {

            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/3
            height: parent.height/5
            color: "green"

            Text {
                text: "Play Again!"
                color: "white"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: parent.height * 0.4
            }

            MouseArea {
                anchors.fill : parent
                onClicked:
                {
                    restartGame()
                }
            }
        }

        ColumnLayout {
            width: 100
            height: 100
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                text: "Score: " + score
                color: "white"
                font.pointSize:  10
            }

            Text {
                text: "Correct: " + numberOfCorrect + "/" + (numberOfCorrect + numberOfWrong)
                color: "white"
                font.pointSize:  10
            }

            Text{
                text: "Percentage Correct: " + Math.round((numberOfCorrect/(numberOfCorrect + numberOfWrong))*100) + "%"
                color: "white"
                font.pointSize:  10
            }

            Text{
                text: "Average response time: " + (((initialTimeRemaining)/(numberOfCorrect + numberOfWrong))*1000).toFixed(0) + "ms"
                color: "white"
                font.pointSize:  10
            }
        }
    }

    Text {
        text: "Time remaining: " + timeRemaining
        anchors.left: parent.left
        anchors.top: scoreText.top
        anchors.leftMargin : window1.width/10
        font.pointSize: scoreText.font.pointSize

    }

    Image {
        id: currentImage
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: window1.height/2
        fillMode: Image.PreserveAspectFit
        source: pictureUrl.select_picture_URL()
    }

    Image {
        id: currentImage_copy
        x: currentImage.x; y:currentImage.y
        height: currentImage.height
        fillMode: Image.PreserveAspectFit
        source: currentImage.source

        ParallelAnimation
        {
            id:parallelAnimation_currentImage_copy
            OpacityAnimator
            {
                target:currentImage_copy
                to: 0.4
                easing: Easing.OutQuad
                duration: 100
            }

            NumberAnimation {
                target: currentImage_copy
                property: "x"
                to: currentImage_copy.x - currentImage_copy.width/3
                duration: 100
            }

            onRunningChanged:
            {
                if (!parallelAnimation_currentImage_copy.running)
                {
                    currentImage_copy.x = currentImage.x
                }
            }
        }
    }

    Text {
        id: scoreText
        text: "Score: " + score;
        anchors.top: parent.top
        anchors.topMargin: window1.height/10
        anchors.right: parent.right
        anchors.rightMargin: window1.width/10
        font.pointSize: 20
        focus: true

        Keys.onPressed:
        {
            parallelAnimation_currentImage_copy.start()

            //if pressing the arrow keys checks current image with previous image
            //if true, the game has yet to begin
            if (startGame === true)
            {
                if(isCorrect(event)===true) {correctResponse()}
                else { wrongResponse() }
            }
            else {
                startGame = true
                pressKeyToStart.opacity =0
                timerToEndGame.running = true
                timerToEndGame.start()
            }

            if ((event.key === Qt.Key_Left) || event.key === Qt.Key_Right)
            {
                updateImages();
            }
        }
    }

    Rectangle {
        id: pressKeyToStart
        color: "black"
        opacity: 0.7
        width: window1.width
        height: window1.height/5
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        Text {

            text : "Press the left or right key to start"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 15
            color: "white"
        }
    }

    Arrow{
        id: leftArrow
        anchors.left: currentImage.left
        startColor: "red"
        transitionColor:  "darkred"
        textInArrow.text: "Different image"
        }

    Arrow {
        id: rightArrow
        anchors.right: currentImage.right
        startColor: "green"
        transitionColor: "darkgreen"
        textInArrow.text: "Same image"
    }


    function correctResponse() {
        score = score + 25
        numberOfCorrect++
        correctOrWrongImage.display("///checkmark.png")
        addOne.startAnimation()
    }

    function wrongResponse() {
        score = score - 100
        numberOfWrong++
        correctOrWrongImage.display("///error.png")
        minusOne.startAnimation()

    }

    function updateImages() {
        currentImage.source = pictureUrl.select_picture_URL();
    }

    function restartGame() {
        scoreText.focus = true
        score = 0
        numberOfCorrect = 0
        numberOfWrong = 0
        timeRemaining = initialTimeRemaining
        endGame_rectangle.opacity = 0
        startGame = false
        pressKeyToStart.opacity = 0.7
        timerToEndGame.running = false
    }

    function isCorrect(event) {
        //left key represents different images
        //right key represents same images
        if (pictureUrl.is_same_pictures())
        {
            if (event.key === Qt.Key_Left)
            {
                leftArrow.startAnimation()
                return false
            }
            else if(event.key === Qt.Key_Right)
            {
                rightArrow.startAnimation()
                return true
            }
        }
        else
        {
            if (event.key === Qt.Key_Left)
            {
                leftArrow.startAnimation()
                return true
            }
            else if(event.key === Qt.Key_Right)
            {
                rightArrow.startAnimation()
                return false
            }
        }
    }
}
