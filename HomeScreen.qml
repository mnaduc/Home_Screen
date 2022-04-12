﻿import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
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

    ListView {
        id: menuId
        property int focusIndex : 2
        width: 1900
        height: 450
        spacing: 26
        orientation: ListView.Horizontal
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 15
        }
        model: DelegateModel {
            model: ListModel {
                ListElement {name: "Climate"; icon: "qrc:/Img/appMenu/icon/icon_climate.png"}
                ListElement {name: "Media"; icon: "qrc:/Img/appMenu/icon/icon_media.png"}
                ListElement {name: "Navigation"; icon: "qrc:/Img/appMenu/icon/icon_navigation.png"}
                ListElement {name: "Phone"; icon: "qrc:/Img/appMenu/icon/icon_phone.png"}
                ListElement {name: "Radio"; icon: "qrc:/Img/appMenu/icon/icon_radio.png"}
                ListElement {name: "Settings"; icon: "qrc:/Img/appMenu/icon/icon_settings.png"}
                ListElement {name: "Climate"; icon: "qrc:/Img/appMenu/icon/icon_climate.png"}
                ListElement {name: "Media"; icon: "qrc:/Img/appMenu/icon/icon_media.png"}
                ListElement {name: "Navigation"; icon: "qrc:/Img/appMenu/icon/icon_navigation.png"}
                ListElement {name: "Phone"; icon: "qrc:/Img/appMenu/icon/icon_phone.png"}
                ListElement {name: "Radio"; icon: "qrc:/Img/appMenu/icon/icon_radio.png"}
                ListElement {name: "Settings"; icon: "qrc:/Img/appMenu/icon/icon_settings.png"}

            }
            delegate: DropArea {
                property int dropAreaIndex: DelegateModel.itemsIndex
                Binding { target: appItemId; property: "visualIndex"; value: dropAreaIndex }
                width: 295
                height: 450
                keys: "dragAppMenu"
                onEntered: console.log(dropAreaIndex + " - enter")
                onExited: console.log(dropAreaIndex + " - exit")
                onDropped: console.log(dropAreaIndex + " - drop")
                MouseArea {
                    id: appItemId
                    property bool draggable: false
                    property int visualIndex: 0
                    width: 295
                    height: 450
                    drag.target: draggable ? appItemId : null
                    drag.axis: Drag.XAxis
                    Drag.active: appItemId.drag.active
                    Drag.keys: "dragAppMenu"
                    Image {
                        source: "qrc:/Img/appMenu/app_item_bg.png"
                    }
                    Image {
                        height: 135
                        width: 135
                        source: model.icon
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            top: parent.top
                            topMargin: 135
                        }
                    }
                    Text {
                        color: "#ABABAB"
                        font.family: "Arial"
                        font.pixelSize: 34
                        text: qsTr(model.name)
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 124
                        }
                    }
                    //focus state
                    Image {
                        source: menuId.focus & menuId.focusIndex == parent.visualIndex ? "qrc:/Img/appMenu/app_item_f.png":""
                    }
                    // press state
                    Image {
                        source: parent.pressed & !parent.draggable ? "qrc:/Img/appMenu/app_item_p.png":""
                    }
                    onPressAndHold: {
                        appItemId.draggable = true
                        menuId.focus = true
                        menuId.focusIndex = visualIndex
                    }
                }
            }
        }
        ScrollBar.horizontal: ScrollBar {
            active: true
            height: 12
            anchors.bottom: menuId.top
            anchors.bottomMargin: -10
        }
   }
}
