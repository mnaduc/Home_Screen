import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: rootId
    width: 672
    height: 852
    state: "closed"
    function changeState(){
        if(state == "opened"){
            state = "closed"
        }else{
            state = "opened"
        }
    }

    Image {
        id: playlistBgId
        source: 'qrc:/App/Media/Img/playlist.png'
        anchors.fill: parent
    }
    ListView {
        id: mediaPlaylistId
        anchors.fill: parent
        model: mediaModel
        clip: true
        spacing: 2
        currentIndex: player.playlist.currentIndex
        delegate: MouseArea {
            width: mediaPlaylistId.width
            height: mediaPlaylistId.height / 5
            Image {
                id: playlistItemId
                source: ''
                opacity: 0.5
                anchors.fill: parent
            }
            Text {
                text: title
                color: 'white'
                font.pixelSize: 100
                fontSizeMode: Text.VerticalFit
                height: parent.height/4
                anchors.verticalCenter: parent.verticalCenter
                leftPadding:  2*parent.width / 17
            }
            onClicked: {
                player.playlist.currentIndex = index
            }
            onContainsPressChanged: {
                playlistItemId.source = containsPress ? 'qrc:/App/Media/Img/hold.png':''
            }
        }
        highlight: Image {
            source: 'qrc:/App/Media/Img/playlist_item.png'
            width: mediaPlaylistId.width
            height: mediaPlaylistId.height/5
            Image {
                source: 'qrc:/App/Media/Img/playing.png'
                width: parent.width / 17
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: width/2
            }
        }
        highlightMoveDuration : 500
        ScrollBar.vertical: ScrollBar {
            parent: parent
        }
    }
    Item {
        width: mediaPlaylistId.width
        height: mediaPlaylistId.height / 5
        visible: mediaPlaylistId.count ? false : true
        Text {
            text: qsTr("STR_EMPTY_PLAYLIST")
            color: 'gray'
            font.pixelSize: 100
            fontSizeMode: Text.VerticalFit
            height: parent.height/4
            width: contentWidth
            anchors.centerIn: parent
        }
    }
    states: [
        State {
            name: "opened"
            PropertyChanges {
                target: rootId
                x: 0
                opacity: 1
            }
        },
        State {
            name: "closed"
            PropertyChanges {
                target: rootId
                x: -672
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "opened"
            to: "closed"
            PropertyAnimation {
                target: rootId
                property: "x"
                duration: 300
            }
            PropertyAnimation {
                target: rootId
                property: "opacity"
                duration: 300
            }
        },
        Transition {
            from: "closed"
            to: "opened"
            PropertyAnimation {
                target: rootId
                property: "x"
                duration: 300
            }
            PropertyAnimation {
                target: rootId
                property: "opacity"
                duration: 300
            }
        }
    ]
}
