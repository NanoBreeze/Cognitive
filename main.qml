import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Layouts 1.1

Window {
    id: window1
    visible: true

    property int k : 0

    GridLayout {
        id: gridLayout1
        anchors.fill: parent
        columns: 6
        rows: 5


        Image {
            id: image1
            Layout.row: 3
            Layout.column: 3
            Layout.maximumHeight: gridLayout1.height/5
            Layout.maximumWidth: gridLayout1.width/6
            source: pictureUrl.select_picture_URL()
        }

        Image {
            id: image2
            Layout.row: 3
            Layout.column: 4
        Layout.maximumHeight: gridLayout1.height/5
        Layout.maximumWidth: gridLayout1.width/6
            source: pictureUrl.select_picture_URL()
        }

        Text {
            id: sdoifosdifj
            Layout.row: 2
            Layout.column: 5
            text: "Three";
            font.bold: true;

//            Keys.onPressed:
//            {
//                //left key represents different
//                //right key represents same

//                if (pictureUrl.is_same_pictures())
//                {
//                    if (event.key === Qt.Key_Left)
//                    {
//                        k--
//                        console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                    "and the left key is pressed")
//                    }
//                    else if(event.key === Qt.Key_Right)
//                    {
//                        k++
//                        console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                    "and the right key is pressed");
//                    }
//                }
//                else
//                {
//                    if (event.key === Qt.Key_Left)
//                    {
//                        k++
//                        console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                    "and the left key is pressed");
//                    }
//                    else if(event.key === Qt.Key_Right)
//                    {
//                        k--
//                        console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.is_Same_pictures() +
//                                    "and the right key is pressed");
//                    }
//                }

//                updateImages();

//            }

        }
    }

    function updateImages() {
        image1.source = image2.source;
        image2.source = pictureUrl.select_picture_URL();
    }


}




//   MainForm {
//     id: mainForm1
//   anchors.fill: parent.anchors





//        Row {
//            id: row1

//            anchors.left: parent.left
//            anchors.right: parent.right
//            anchors.verticalCenter: parent.verticalCenter
//            height: 200


//        }
//}
//}

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

