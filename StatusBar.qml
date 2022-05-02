import QtQuick 2.12
import QtQml 2.12

Item {
    width: 1920
    height: 102
    property alias isShowBackBtn: btnBackId.visible
    property var time: new Date
    signal backClicked
    //Back Button
    MouseArea {
        id: btnBackId
        width: 135
        height: 75
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.verticalCenter: parent.verticalCenter
        onClicked: backClicked()
        Image {
            source: "qrc:/Img/statusBar/back_n.png"
        }
        Image {
            source: parent.focus ? "qrc:/Img/statusBar/back_f.png":""
        }
        Image {
            source: parent.pressed ? "qrc:/Img/statusBar/back_p.png":""
        }
    }
    Image {
        id: divider_center
        source: "qrc:/Img/statusBar/status_divider.png"
        anchors.centerIn: parent
    }
    Text {
        id: txtTimeId
        text: "00:00"
        font.pixelSize: 54
        font.family: "Arial"
        color: "#EEEEEE"
        width: 300
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.right: divider_center.left
    }
    Image {
        id: divider_left
        source: "qrc:/Img/statusBar/status_divider.png"
        anchors.right: txtTimeId.left
        anchors.verticalCenter: parent.verticalCenter
    }
    Text {
        id: txtDateId
        text: "Apr. 12"
        font.pixelSize: 54
        font.family: "Arial"
        color: "#EEEEEE"
        width: 300
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.left: divider_center.right
    }
    Image {
        id: divider_right
        source: "qrc:/Img/statusBar/status_divider.png"
        anchors.left: txtDateId.right
        anchors.verticalCenter: parent.verticalCenter
    }
    Timer{
        id: timerId
        function updateTime () {
            var time = new Date()
            txtTimeId.text = time.toLocaleTimeString(Qt.locale(), "hh:mm");
            txtDateId.text = time.toLocaleDateString(Qt.locale(qsTr("STR_locale")), "MMM. dd"); // en_US vi_VN
        }
        repeat: true
        onTriggered: updateTime()
    }

    Connections {
        target: Translator
        onLanguageChanged: timerId.updateTime()
    }

    Component.onCompleted: {
        timerId.start()
        timerId.updateTime()
    }
}
