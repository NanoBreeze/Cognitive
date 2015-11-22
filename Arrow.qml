import QtQuick 2.0

Rectangle {
id: arrow
    property alias textInArrow : arrowText
    property var transitionColor
property var startColor

    width: currentImage.width/3
    height: window1.height/10
    anchors.topMargin: window1.width/15
    color: startColor
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

    SequentialAnimation{
        id: animateArrow

        PropertyAnimation{
            target: arrow
            property: "color"
            from: startColor
            to: transitionColor
            duration: 150
            easing: Easing.OutQuad
        }
        PropertyAnimation {
            target: arrow
            property: "color"
            from: transitionColor
            to: startColor
            duration: 150
        easing: Easing.OutQuad
        }
    }

    function startAnimation() { animateArrow.start() }

}
