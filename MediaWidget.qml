import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

MouseArea {
    id: rootId
    property url albumArtUrl: mediaModel.data(mediaModel.index(player.playlist.currentIndex,0), Qt.UserRole + 4)
    width: 616
    height: 496
    onClicked: focus = true
    //background
    FastBlur {
        anchors.fill: parent
        source: Image {
            source: rootId.albumArtUrl
            visible: false
        }
        opacity: 0.8
        radius: 18
        Image {
            source: "qrc:/Img/widget/widget_frame.png"
        }
    }
    Image {
        source: "qrc:/Img/widget/media/source_bg.png"
        anchors {
            top: parent.top
            topMargin: 34
        }
        Text {
            id: musicSourceId
            text: qsTr("STR_USB_Source")
            color: "#EEEEEE"
            font.family: "Arial"
            font.pixelSize: 30
            anchors.centerIn: parent

        }
    }
    Image {
        id: albumArtId
        source: rootId.albumArtUrl
        width: 227
        height: 227
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 98
        }
        Image {
            source: "qrc:/Img/widget/media/albumArt_frame.png"
        }
    }
    Slider {
        id: progressBarId
        from: 0
        to: player.duration
        value: player.position
        width: 510
        height: 6
        enabled: false
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 35
        }
        background: Image {
            source: "qrc:/Img/widget/media/progressBar_bg.png"
            width: progressBarId.width
            height: progressBarId.height
            Image {
                source: "qrc:/Img/widget/media/progressBar.png"
                height: parent.height
                width: progressBarId.visualPosition * parent.width
            }
        }
        handle: null
    }
    Text {
        id: songNameId
        text: mediaModel.data(mediaModel.index(player.playlist.currentIndex,0), Qt.UserRole + 1)
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 44
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: progressBarId.top
            bottomMargin: 18
        }
    }
    Text {
        id: singerId
        text: mediaModel.data(mediaModel.index(player.playlist.currentIndex,0), Qt.UserRole + 2)
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 26
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: songNameId.top
            bottomMargin: 14
        }
    }

    //focus status
    Image {
        source: parent.focus ? "qrc:/Img/widget/widget_f.png":""
    }
    // press status
    Image {
        source: pressed ? "qrc:/Img/widget/widget_p.png":""
    }
}
