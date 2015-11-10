import QtQuick 2.4
import QtQuick.Window 2.2

Window {
    visible: true

    property int k : 0

    Image {
        id: image1
        x: 50; y:50
        width: 50; height: 50
        fillMode: Image.PreserveAspectFit
        source: pictureUrl.Select_picture_URL()
    }

    Image {
        id: image2
        x: 100; y:50
        width: 50; height: 50
        fillMode: Image.PreserveAspectFit
        source: pictureUrl.Select_picture_URL()
    }

    Text {
        id: scoreText
        x: 400; y:50
        text: "Score: " + k
        focus: true
        Keys.onPressed:
        {
            //left key represents different
            //right key represents same

            if (pictureUrl.Is_Same_pictures())
            {
               if (event.key === Qt.Key_Left)
                {
                   k--
                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.Is_Same_pictures() +
                                "and the left key is pressed")
                }
                else if(event.key === Qt.Key_Right)
                {
                    k++
                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.Is_Same_pictures() +
                                "and the right key is pressed");
                }
            }
            else
            {
                if (event.key === Qt.Key_Left)
                {
                    k++
                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.Is_Same_pictures() +
                                "and the left key is pressed");
                }
                else if(event.key === Qt.Key_Right)
                {
                    k--
                    console.log("The value of pictureUrl.Is_Same_pictures() is " + pictureUrl.Is_Same_pictures() +
                                "and the right key is pressed");
                }
            }

            updateImages();


        }
    }

    function updateImages() {
        image1.source = image2.source;
        image2.source = pictureUrl.Select_picture_URL();
    }
}
