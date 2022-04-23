import QtQuick 2.9
import QtQuick.Controls 2.5

Item {
    id: rootId
    width: 1920
    height: 978

    Image {
        anchors.fill: parent
        source: "qrc:/App/Media/Img/background.png"
    }

    //Header
    AppHeader {
        id: headerItemId
        width: parent.width
        height: 126
        playlistBtnStatus: playlistId.state == "opened" ? false:true
        onClickedPlayListBtn: playlistId.changeState()
    }
    //Playlist
    PlaylistView {
        id: playlistId
        anchors.top: headerItemId.bottom
    }
    //Media Info
    MediaInfoControl {
        anchors.bottom: parent.bottom
        anchors.top: headerItemId.bottom
        anchors.right: parent.right
        anchors.left: playlistId.right
    }
}
