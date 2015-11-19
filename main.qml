import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window1
    visible: true

    property int score : 0
    property int timeRemaining: 60

 //Accessory objects
    Image {id: correctOrWrongLoader
    anchors.left: image2.right
    anchors.top: image2.horizontalCenter
    height: image2.height / 5
    fillMode: Image.PreserveAspectFit

    }

    Timer {
        interval: 1000
        running:true
        repeat: true
        onTriggered: {
            timeRemaining--
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
        scoreText.color = "green"
        correctOrWrongLoader.source = "///checkmark.png"
    }

    function wrongResponse() {
        score--
        scoreText.color = "red"
        correctOrWrongLoader.source = "///cross.png"

    }

    function updateImages() {
        image1.source = image2.source;
        image2.source = pictureUrl.select_picture_URL();
    }


}
