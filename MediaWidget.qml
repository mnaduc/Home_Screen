import QtQuick 2.12
import QtGraphicalEffects 1.12

MouseArea {
    id: rootId
    property url albumArtUrl: "qrc:/Img/widget/media/albumArt_exm.png"
    width: 616
    height: 496
    anchors {
    }
    //background
    FastBlur {
        anchors.fill: parent
        source: Image {
            source: rootId.albumArtUrl
        }
        opacity: 0.95
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
    }
    Image {
        id: albumArtId
        source: rootId.albumArtUrl
        width: 227
        height: 227
        Image {
            source: "qrc:/Img/widget/media/albumArt_frame.png"
        }
    }
}
