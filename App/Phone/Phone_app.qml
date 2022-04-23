import QtQuick 2.9

Item {
    id: rootId
    width: 1920
    height: 978

    Image {
        source: "qrc:/App/Phone/Phone.jpg"
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
    }
}
