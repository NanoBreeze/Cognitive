import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    visible: true


    MainForm {
        id: mainForm1

            property int k : 0

        Row {
            id: row1

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            height: 200


            Image {
                id: image1
                height: parent.height
                fillMode: Image.PreserveAspectFit
                source: pictureUrl.select_picture_URL()
            }

            Image {
                id: image2
                height: parent.height
                fillMode: Image.PreserveAspectFit
                source: pictureUrl.select_picture_URL()
            }
        }
    }
}

//                Text {
//                    id: scoreText
//                    x: 400; y:50
//                    text: "Score: " + k
//                    focus: true
//                    Keys.onPressed:
//                    {
//                        //left key represents different
//                        //right key represents same

//                        if (pictureUrl.is_Same_pictures())
//                        {
//                           if (event.key === Qt.Key_Left)
//                            {
//                               k--
//                                console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                            "and the left key is pressed")
//                            }
//                            else if(event.key === Qt.Key_Right)
//                            {
//                                k++
//                                console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                            "and the right key is pressed");
//                            }
//                        }
//                        else
//                        {
//                            if (event.key === Qt.Key_Left)
//                            {
//                                k++
//                                console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                            "and the left key is pressed");
//                            }
//                            else if(event.key === Qt.Key_Right)
//                            {
//                                k--
//                                console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                            "and the right key is pressed");
//                            }
//                        }

//                        updateImages();

//                    }
//                }
//                }

//    function updateImages() {
//        image1.source = image2.source;
//        image2.source = pictureUrl.select_picture_URL();
//    }
//}

