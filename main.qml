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
        onBackClicked: stackViewId.pop(null)
        isShowBackBtn: stackViewId.depth == 1 ? false : true
    }
    StackView {
        id: stackViewId
        property int animationSpeed: 600
        width: 1920
        height: 978
        anchors.top: statusBarId.bottom
        Keys.onPressed: {
            switch(event.key){
            case Qt.Key_N:
                console.log("Key shortcut: Navigation")
                push("qrc:/App/Map/Map_app.qml")
                break;
            case Qt.Key_C:
                console.log("Key shortcut: Climate")
                push("qrc:/App/Climate/Climate_app.qml")
                break;
            case Qt.Key_M:
                console.log("Key shortcut: Media")
                push("qrc:/App/Media/Media_app.qml")
                break;
            case Qt.Key_Backspace:
                pop(null)
                break;
            }
        }
        initialItem: HomeScreen {
            id: homeScreenId
        }
        onCurrentItemChanged: {
            currentItem.forceActiveFocus()
        }
        pushEnter: Transition {
            XAnimator {
                from: 1920
                to: 0
                duration: stackViewId.animationSpeed
                easing.type: Easing.OutCubic
            }
        }
        pushExit: Transition {
            OpacityAnimator {
                from: 1
                to: 0
                duration: stackViewId.animationSpeed
                easing.type: Easing.OutCubic
            }
        }
        popEnter: Transition {
            OpacityAnimator {
                from: 0
                to: 1
                duration: stackViewId.animationSpeed
                easing.type: Easing.OutCubic
            }
        }
        popExit: Transition {
            XAnimator {
                from: 0
                to: 1920
                duration: stackViewId.animationSpeed
                easing.type: Easing.OutCubic
            }
        }
    }
}
