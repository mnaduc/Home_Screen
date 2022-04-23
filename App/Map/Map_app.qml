import QtQuick 2.9
import QtLocation 5.12
import QtPositioning 5.12

Item {
    id: rootId
    width: 1920
    height: 978

    Plugin {
        id: mapPlugin
        name: "mapboxgl" //"osm" // , "esri", ...
    }
    MapQuickItem {
        id: marker
        anchorPoint.x: image.width/2
        anchorPoint.y: image.height
        coordinate: QtPositioning.coordinate(10.8383, 106.83)

        sourceItem: Image {
            id: image
            source: "qrc:/Img/widget/map/car_icon.png"
        }
    }
    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: marker.coordinate
        zoomLevel: 15
        copyrightsVisible: false
        enabled: false
        Component.onCompleted: {
            map.addMapItem(marker)
        }
    }
    Rectangle {
        color: "black"
        width: parent.width
        height: 100
        opacity: 0.6
        anchors.top: parent.top
        Text {
            id: name
            text: qsTr("STR_Map_title")
            anchors.centerIn: parent
            color: "#EEEEEE"
            font.family: "Arial"
            font.pixelSize: 40
        }
    }
}
