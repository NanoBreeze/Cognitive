import QtQuick 2.0

Rectangle {

    property alias textInArrow : arrowText

    width: currentImage.width/3
    height: window1.height/10
    anchors.topMargin: window1.width/15

    anchors.top: currentImage.bottom

    Text {
        id: arrowText
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
