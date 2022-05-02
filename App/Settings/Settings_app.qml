import QtQuick 2.9

Item {
    id: rootId
    width: 1920
    height: 978
    Image {
        source: "qrc:/App/Settings/vn.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 300
        Rectangle {
            color: "transparent"
            border.color: "goldenrod"
            border.width: 10
            width: parent.width + border.width*2
            height: width * 0.6
            anchors.centerIn: parent
            visible: Translator.language === "vn" ? true:false
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: Translator.language = "vn"
        }
    }
    Image {
        source: "qrc:/App/Settings/us.png"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 400
        Rectangle {
            color: "transparent"
            border.color: "goldenrod"
            border.width: 10
            width: parent.width + border.width*2
            height: width * 0.6
            anchors.centerIn: parent
            visible: Translator.language === "us" ? true:false
        }
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: Translator.language = "us"
        }
    }
}
