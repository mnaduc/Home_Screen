import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    width: 1920
    height: 1080
    visible: true
    visibility: "FullScreen"
    Image {
        anchors.fill: parent
        source: "qrc:/Img/background.png"
    }
    StatusBar {
        id: statusBarId
        onBackClicked: stackViewId.pop()
        isShowBackBtn: stackViewId.depth == 1 ? false : true
    }
    Rectangle {
        width: 50
        height: 50
        anchors.right: parent.right
        color: "red"
        MouseArea {
            anchors.fill: parent
            onClicked: stackViewId.push("qrc:/Test.qml")
        }
    }
    StackView {
        id: stackViewId
        width: 1920
        height: 978
        anchors.top: statusBarId.bottom
        initialItem: HomeScreen {
            id: homeScreenID
        }
        pushEnter: Transition {
            XAnimator {
                from: 1920
                to: 0
                duration: 800
                easing.type: Easing.OutCubic
            }
        }
        popExit: Transition {
            XAnimator {
                from: 0
                to: 1920
                duration: 800
                easing.type: Easing.OutCubic
            }
        }
        pushExit: Transition {
            XAnimator {
                from: 0
                to: 0
                duration: 800
                easing.type: Easing.OutCubic
            }
        }
        popEnter: pushExit
    }
}
