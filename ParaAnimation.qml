import QtQuick 2.4

ParallelAnimation{

    property var targetId
    property var startMargin
    property var endMargin

    NumberAnimation {
        id: numberAnimation
        target: targetId
        property: "anchors.topMargin"
        to: endMargin
        duration: 300
    }

    SequentialAnimation{
        OpacityAnimator {
            target: targetId
            from: 0
            to: 1
            duration: 150
        }
        OpacityAnimator {
            target: targetId
            from: 1
            to: 0
            duration: 150 }
    }

    onRunningChanged:
    {
        if (!parallel_minusOne.running) { minusOne.anchors.topMargin = startMargin }
    }

}
