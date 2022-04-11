import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    width: 1920
    height: 978
    //Widget Area
    Item {
        id: widgetAreaId
        width: 1900
        height: 496
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        //Climate widget
        ClimateWidget {
            id: climateWidgetId
            anchors.centerIn: parent
        }
        MapWidget {
            id: mapWidgetId
            anchors {
                right: climateWidgetId.left
                rightMargin: 26
            }
        }
        MediaWidget {
            id: mediaWidgetId
            anchors {
                left: climateWidgetId.right
                leftMargin: 26
            }
        }
    }

    /*
    ListView {
        id: widgetAreaId


        spacing: 26
        orientation: ListView.Horizontal
        interactive: false
        model: DelegateModel {
            model: ListModel {
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }
            delegate: DropArea {
                width: 616
                height: 496

                Loader {
                    anchors.fill: parent
                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidgetId
                        case "climate": return climateWidgetId
                        case "media": return mediaWidgetId
                        }
                    }
                }
            }
        }
        Component {
            id: mapWidgetId
            Rectangle {
                anchors.fill: parent
                color: "red"
                opacity: 0.6
            }
        }
        Component {
            id: climateWidgetId
            Rectangle {
                anchors.fill: parent
                color: "green"
                opacity: 0.6
            }
        }
        Component {
            id: mediaWidgetId
            Rectangle {
                anchors.fill: parent
                color: "yellow"
                opacity: 0.6
            }
        }
    }

    */
}
