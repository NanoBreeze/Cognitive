import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

Window {
    id: window1
    visible: true

    //increments when user answers correctly and decrements more when user answers incorrectly
    property int score : 0

    //stores the number of correct responses the user has put
    property int numberOfCorrect: 0

    //stores the number of wrong responses the user has put
    property int numberOfWrong: 0

    //time remaining until end of game
    property int timeRemaining: 5



    //displays an image for a brief while to affirm if user's input was correct or wrong
    Image {
        id: correctOrWrongImage
        anchors.left: currentImage.right
        height: currentImage.height / 5
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
        running:true
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

        color: "grey"
        opacity: 0.0


        Rectangle {

            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.height/10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/3
            height: parent.height/5
            color: "green"

            Text {
                text: "Again!"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: parent.height * 0.6
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
            }

            Text {
                text: "Correct: " + numberOfCorrect + "/" + (numberOfCorrect + numberOfWrong)
            }

            Text{
                text: "Percentage Correct: " + (numberOfCorrect/(numberOfCorrect + numberOfWrong))*100 + "%"
            }

            Text{
                text: "Average response time: " + (numberOfCorrect + numberOfWrong)/60 * 100 + "ms"
            }
        }
    }


    Text {
        text: "Time remaining: " + timeRemaining
        anchors.left: window1.width/10
        anchors.top: scoreText.top
        font.pointSize: scoreText.font.pointSize
    }

        Image {
            id: image1
            height : window1.height/10
            fillMode: Image.PreserveAspectFit
            source: pictureUrl.select_picture_URL()
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
                duration: 150
            }

            NumberAnimation {
                target: currentImage_copy
                property: "x"
                to: currentImage_copy.x - currentImage_copy.width/3
                duration: 150
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

            if(isCorrect(event)===true) {correctResponse()}
            else { wrongResponse() }

            if ((event.key === Qt.Key_Left) || event.key === Qt.Key_Right)
            {
                updateImages();
            }
        }
    }

    Arrow{
        anchors.left: currentImage.left
        color: "red"
        textInArrow.text: "Different image"

    }

    Arrow {
        anchors.right: currentImage.right
        color: "green"
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
       image1.source = currentImage.source;
        currentImage.source = pictureUrl.select_picture_URL();
    }

    function restartGame() {
        scoreText.focus = true
        score = 0
        numberOfCorrect = 0
        numberOfWrong = 0
        timeRemaining = 5
        endGame_rectangle.opacity = 0
        timerToEndGame.start()
    }

function isCorrect(event) {
    //left key represents different images
    //right key represents same images
    if (pictureUrl.is_same_pictures())
    {
        if (event.key === Qt.Key_Left)
        {
            return false
        }
        else if(event.key === Qt.Key_Right)
        {
            return true
        }
    }
    else
    {
        if (event.key === Qt.Key_Left)
        {
            return true
        }
        else if(event.key === Qt.Key_Right)
        {
            return false
        }
    }
}
}
