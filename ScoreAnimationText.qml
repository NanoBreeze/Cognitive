import QtQuick 2.4

Text {

    property var startMargin
    property var endMargin

    id: textId

    font.pointSize: 10
    anchors.topMargin: 0
    opacity: 0

    ParallelAnimation{
        id:parallel
        NumberAnimation {
            target: textId
            property: "anchors.topMargin"
            to: endMargin
            duration: 300
        }

        SequentialAnimation{
            OpacityAnimator {
                target: textId
                from: 0
                to: 1
                easing: Easing.OutQuad
                duration: 150
            }
            OpacityAnimator {
                target: textId
                from: 1
                to: 0
                easing: Easing.OutQuad
                duration: 150 }
        }

        onRunningChanged:
        {
            if (!parallel.running) { textId.anchors.topMargin = startMargin }
        }
    }
    function startAnimation() { parallel.start() }
}
