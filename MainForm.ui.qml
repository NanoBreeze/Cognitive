import QtQuick 2.4

Rectangle {
    property alias mouseArea: mouseArea

    width: 360
    height: 360

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        Text {
            id: text1
            x: 88
            y: 68
            text: qsTr("Text")
            font.pixelSize: 12
        }
    }

    Text {
        anchors.centerIn: parent
        text: "Hello World"
    }
}
