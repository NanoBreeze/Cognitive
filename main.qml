import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1
import QtMultimedia 5.0

Window {
    id: window1
    visible: true

    property int score : 0
    property int totalCorrect: 0
    property int totalWrong: 0
    property int timeRemaining: 5


    //Accessory objects
    Image {
        id: correctOrWrong
        anchors.left: image2.right
        height: image2.height / 5
        anchors.verticalCenter: image2.verticalCenter
        fillMode: Image.PreserveAspectFit

        OpacityAnimator {
            id: animateOpacity
            target: correctOrWrong
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
        id: timer
        interval: 1000
        running:true
        repeat: true
        onTriggered: {
            timeRemaining--
            if (timeRemaining === 0)
            {
                timer.stop()
                endGame_rectangle.opacity = 1
                scoreText.focus = false
            }
        }
    }


    Text {
        id: addOne
        text: "+1"
        font.pointSize: 10
        anchors.top: scoreText.bottom
        anchors.right: scoreText.right
        anchors.topMargin: 0
        color: "green"
        opacity: 0

        //almost identical to minusOne's animation, consider making this a generic animation
        ParallelAnimation{
            id: parallel_addOne

            NumberAnimation {
                target: addOne
                property: "anchors.topMargin"
                to: -5
                duration: 300
            }

            SequentialAnimation{
                id: sequential_addOne
                OpacityAnimator {
                    target: addOne;
                    from: 0;
                    to: 1;
                    duration: 150 }
                OpacityAnimator {
                    target: addOne;
                    from: 1;
                    to: 0;
                    duration: 150 }
            }

            onRunningChanged:
            {
                if (!parallel_addOne.running) { addOne.anchors.topMargin = 0 }
            }


        }
        function startAnimation() {
            parallel_addOne.start()
        }
    }

    Text {
        id: minusOne
        text: "-1"
        font.pointSize: 10
        anchors.top: scoreText.bottom
        anchors.right: scoreText.right
        anchors.topMargin: -5
        color: "red"
        opacity: 0

        //almost identical to minusOne's animation, consider making this a generic animation
        ParallelAnimation{
            id: parallel_minusOne

            NumberAnimation {
                target: minusOne
                property: "anchors.topMargin"
                to: 0
                duration: 300
            }

            SequentialAnimation{
                OpacityAnimator {
                    target: minusOne;
                    from: 0;
                    to: 1;
                    duration: 150 }
                OpacityAnimator {
                    target: minusOne;
                    from: 1;
                    to: 0;
                    duration: 150 }
            }

            onRunningChanged:
            {
                if (!parallel_minusOne.running) { minusOne.anchors.topMargin = -5 }
            }
        }


        function startAnimation() {
            parallel_minusOne.start()
        }
    }

    Rectangle {
        id: endGame_rectangle
        width: window1.width
        height: window1.height
        z: 9999

        color: "grey"
        opacity: 0.0

        Text {
            id:totalCorrect_text
            text: "Total Correct: " + totalCorrect
            anchors.topMargin: window1.height*-0.2
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            id:totalWrong_text
            text: "Total Wrong: " + totalWrong
            anchors.top: totalCorrect_text.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id:total_text
            text: "Total: " + (totalCorrect + totalWrong)
            anchors.top: totalWrong_text.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            id:totalScore_text
            text: "Score: " + score
            anchors.top: total_text.bottom
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: restart
            anchors.top : totalScore_text.bottom
            anchors.topMargin: parent.height/10
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width/3
            height: parent.height/5
            color: "green"

            Text {
                text: "Again!"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: parent.height * 0.8
            }

            MouseArea {
                anchors.fill : parent
                onClicked:
                {
                    restartGame()
                }
            }
        }

    }


    //change the absolute positioning
    Text {
        text: "Time remaining: " + timeRemaining
        x: 50; y: 120
    }

    Image {
        id: image1
        height : window1.height/10
        fillMode: Image.PreserveAspectFit
        source: pictureUrl.select_picture_URL()
    }

    Image {
        id: image2
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: window1.height/2
        fillMode: Image.PreserveAspectFit
        source: pictureUrl.select_picture_URL()
    }

    Image {
        id: image2_copy
        x: image2.x; y:image2.y
        height: image2.height
        fillMode: Image.PreserveAspectFit
        source: image2.source

        ParallelAnimation
        {
            id:parallelAnimation_image2_copy
            OpacityAnimator
            {
                target:image2_copy
                to: 0.4
                duration: 150
            }

            NumberAnimation {
                target: image2_copy
                property: "x"
                to: image2_copy.x - image2_copy.width/3
                duration: 150
            }

            onRunningChanged:
            {
                if (!parallelAnimation_image2_copy.running)
                {
                    image2_copy.x = image2.x
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
            parallelAnimation_image2_copy.start()
            //left key represents different images
            //right key represents same images
            if (pictureUrl.is_same_pictures())
            {
                if (event.key === Qt.Key_Left)
                {
                    wrongResponse()
                }
                else if(event.key === Qt.Key_Right)
                {
                    correctResponse()
                }
            }
            else
            {
                if (event.key === Qt.Key_Left)
                {
                    correctResponse()
                }
                else if(event.key === Qt.Key_Right)
                {
                    wrongResponse()
                }
            }

            if ((event.key === Qt.Key_Left) || event.key === Qt.Key_Right)
            {
                updateImages();
            }
        }
    }

Arrow{
anchors.left: image2.left
color: "red"
textInArrow.text: "Different image"

}

Arrow {
    anchors.right: image2.right
    color: "green"
  textInArrow.text: "Same image"

}


    function correctResponse() {
        score++
        totalCorrect++
        correctOrWrong.display("///checkmark.png")
        addOne.startAnimation()
    }

    function wrongResponse() {
        score--
        totalWrong++
        correctOrWrong.display("///error.png")
        minusOne.startAnimation()

    }

    function updateImages() {
        image1.source = image2.source;
        image2.source = pictureUrl.select_picture_URL();
    }

    function restartGame() {
        scoreText.focus = true
        score = 0
        totalCorrect = 0
        totalWrong = 0
        timeRemaining = 5
        endGame_rectangle.opacity = 0
        timer.start()
    }
}
