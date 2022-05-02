import QtQuick 2.9

Item {
    property alias playlistBtnStatus: playlistBtnId.status
    signal clickedPlayListBtn
    Image {
        id: headerBgId
        source: "qrc:/App/Media/Img/title.png"
        anchors.fill: parent
    }
    Text {
        id: headerTitleTxtId
        text: qsTr("STR_Media_title")
        color: "white"
        font.pixelSize: 100
        fontSizeMode: Text.VerticalFit
        anchors.centerIn: parent
        height: parent.height/2
        width: contentWidth
    }
    SwitchButton {
        id: playlistBtnId
        height: parent.height/3
        width: height
        anchors.left: parent.left
        anchors.leftMargin: width/2
        anchors.verticalCenter: parent.verticalCenter
        icon_off: 'qrc:/App/Media/Img/back.png'
        icon_on: 'qrc:/App/Media/Img/drawer.png'
        onClicked: {
            console.log("Playlist Button onClicked")
            clickedPlayListBtn()
        }
    }
    Text {
        text: qsTr("STR_PLAYLIST")
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: playlistBtnId.right
        anchors.leftMargin: playlistBtnId.width/3
        color: "white"
        font.pixelSize: headerTitleTxtId.fontInfo.pixelSize * 0.7
        MouseArea {
            anchors.fill: parent
            onClicked: playlistBtnId.clicked(mouse)
            cursorShape: Qt.PointingHandCursor
        }
    }
}
