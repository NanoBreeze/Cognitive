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

        NumberAnimation {
            id: animateOpacity
            target: correctOrWrong
            properties: "opacity"
            from: 1.0
            to: 0
            duration: 300
        }


        signal display(string url);

        onDisplay: {
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
                endGame_Animation.start()
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
                if (!parallel_addOne.running)
                {
                    addOne.anchors.topMargin = 0
                }
            }


        }
        signal startAnimation()


        onStartAnimation: {
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
                if (!parallel_minusOne.running)
                {
                    minusOne.anchors.topMargin = -5
                }
            }
        }


        signal startAnimation()


        onStartAnimation: {
            parallel_minusOne.start()
        }
    }

Rectangle {
    id: endGame
    width: window1.width * 0.8
    height: window1.height * 0.8

    y: window1.height
    color: "grey"
    opacity: 0.8

    NumberAnimation {
        id:endGame_Animation
        target: endGame
        property: "y"
        to:window1.height*0.2
        duration: 300
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
            //left key represents different
            //right key represents same
            if (pictureUrl.is_same_pictures())
            {
                if (event.key === Qt.Key_Left)
                {
                    wrongResponse()

                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_same_pictures()+
                                "and the left key is pressed")
                }
                else if(event.key === Qt.Key_Right)
                {
                    correctResponse()

                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_same_pictures() +
                                "and the right key is pressed");
                }
            }
            else
            {
                if (event.key === Qt.Key_Left)
                {
                    correctResponse()

                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_same_pictures() +
                                "and the left key is pressed");
                }
                else if(event.key === Qt.Key_Right)
                {
                    wrongResponse()

                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_same_pictures() +
                                "and the right key is pressed");
                }
            }

            updateImages();

        }

    }

    Rectangle {
        id: leftArrow
        width: image2.width/3
        height: window1.height/10
        color: "red"
        anchors.topMargin: window1.width/15
        anchors.left: image2.left
        anchors.top: image2.bottom

        Text {
            text: "Different image"
            width: parent.width
            height: parent.height
            font.pixelSize: parent.height * 0.4
            wrapMode: Text.WordWrap
            anchors.horizontalCenter:  parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

    }


    Rectangle {
        id: rightArrow
        width: image2.width/3
        height: window1.height/10
        color: "red"
        anchors.topMargin: window1.width/15
        anchors.right: image2.right
        anchors.top: image2.bottom

        Text {
            text: "Same image"
            width: parent.width
            height: parent.height
            font.pixelSize: parent.height * 0.4
            wrapMode: Text.WordWrap
            anchors.horizontalCenter:  parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

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
}
