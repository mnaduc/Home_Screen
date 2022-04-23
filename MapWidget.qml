import QtQuick 2.12
import QtLocation 5.12
import QtPositioning 5.12

MouseArea {
    height: 496
    width: 616
    onClicked: focus = true

    Item {
        id: map
        anchors.fill: parent
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
            id: mapView
            anchors.fill: parent
            plugin: mapPlugin
            center: marker.coordinate
            zoomLevel: 14
            copyrightsVisible: false
            enabled: false
            Component.onCompleted: {
                mapView.addMapItem(marker)
            }
        }
    }

    Image {
        source: "qrc:/Img/widget/widget_frame.png"
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
