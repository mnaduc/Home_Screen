import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12

Item {
    id: rootId
    width: 1920
    height: 978
    property var lastFocus : menuId

    function openApplication(url){
        parent.push(url)
    }
    onActiveFocusChanged: {
        console.log("on Active Focus Change")
        lastFocus.forceActiveFocus()
    }

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
            onClicked: openApplication("qrc:/App/Climate/Climate_app.qml")
            onFocusChanged: lastFocus = climateWidgetId
            Keys.onPressed: {
                switch(event.key) {
                case Qt.Key_Return:
                    openApplication("qrc:/App/Climate/Climate_app.qml")
                    break
                case Qt.Key_Down:
                    menuId.forceActiveFocus()
                    break
                case Qt.Key_Right:
                    mediaWidgetId.forceActiveFocus()
                    break
                case Qt.Key_Left:
                    mapWidgetId.forceActiveFocus()
                    break
                }
            }
        }
        MapWidget {
            id: mapWidgetId
            anchors {
                right: climateWidgetId.left
                rightMargin: 26
            }
            onClicked: openApplication("qrc:/App/Map/Map_app.qml")
            onFocusChanged: lastFocus = mapWidgetId
            Keys.onPressed: {
                switch(event.key) {
                case Qt.Key_Return:
                    openApplication("qrc:/App/Map/Map_app.qml")
                    break
                case Qt.Key_Down:
                    menuId.forceActiveFocus()
                    break
                case Qt.Key_Right:
                    climateWidgetId.forceActiveFocus()
                    break
                }
            }

        }
        MediaWidget {
            id: mediaWidgetId
            anchors {
                left: climateWidgetId.right
                leftMargin: 26
            }
            onClicked: openApplication("qrc:/App/Media/Media_app.qml")
            onFocusChanged: lastFocus = mediaWidgetId
            Keys.onPressed: {
               switch(event.key) {
               case Qt.Key_Return:
                   openApplication("qrc:/App/Media/Media_app.qml")
                   break
               case Qt.Key_Down:
                   menuId.forceActiveFocus()
                   break
               case Qt.Key_Left:
                   climateWidgetId.forceActiveFocus()
                   break
               }
            }

        }
    }

    ListView {
        id: menuId
        property int focusIndex: 0
        width: 1900
        height: 450
        spacing: 26
        interactive: menuId.count < 7 ? false : true
        onFocusChanged: lastFocus = menuId
        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad; duration: 500 }
        }
        orientation: ListView.Horizontal
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: 15
        }
        model: DelegateModel {
            id: delegateModelId
            model: appModel
            delegate: DropArea {
                id: delegateId
                property int dropAreaIndex: DelegateModel.itemsIndex
                width: 295
                height: 450
                keys: "dragAppMenu"
                onEntered: {
                    var sourceIndex = drag.source.visualIndex
                    var desIndex = appItemId.visualIndex
                    if (sourceIndex != desIndex){
                        appModel.move(sourceIndex, desIndex);
                        menuId.focusIndex = drag.source.visualIndex
                        if (sourceIndex < desIndex) {
                            menuId.currentIndex = menuId.focusIndex + 1
                        } else if(sourceIndex > desIndex) {
                            menuId.currentIndex = menuId.focusIndex - 1
                        }
                    }
                }
                MouseArea {
                    id: appItemId
                    property bool draggable: false
                    property int visualIndex: delegateId.dropAreaIndex

                    width: 295
                    height: 450
                    drag.target: draggable ? appItemId : null
                    drag.axis: Drag.XAxis
                    Drag.active: appItemId.drag.active
                    Drag.keys: "dragAppMenu"
                    Drag.hotSpot.x: width/2
                    anchors.horizontalCenter: parent.horizontalCenter
                    onPressAndHold: {
                        menuId.focus = true
                        menuId.focusIndex = visualIndex
                        appItemId.draggable = true
                        menuId.currentIndex = menuId.focusIndex
                        console.log("mouse-listapp: press and hold")
                    }
                    onReleased: {
                        menuId.focus = true
                        menuId.focusIndex = visualIndex
                        menuId.currentIndex = menuId.focusIndex
                        if(appItemId.draggable) {
                            appModel.writeXml();
                        }
                        appItemId.draggable = false
                        console.log("mouse-listapp: release")
                    }
                    onClicked: openApplication(model.url)
                    Image {
                        source: "qrc:/Img/appMenu/app_item_bg.png"
                    }
                    Image {
                        height: 135
                        width: 135
                        source: model.iconPath
                        fillMode: Image.PreserveAspectFit
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
                        text: "App Name"
                        anchors {
                            horizontalCenter: parent.horizontalCenter
                            bottom: parent.bottom
                            bottomMargin: 124
                        }
                        Component.onCompleted: {
                            text = Qt.binding(function(){
                                switch (model.title) {
                                case "Phone":
                                    return qsTr("STR_Phone")
                                case "Climate":
                                    return qsTr("STR_Climate")
                                case "Map":
                                    return qsTr("STR_Map")
                                case "Radio":
                                    return qsTr("STR_Radio")
                                case "Settings":
                                    return qsTr("STR_Settings")
                                case "Media":
                                    return qsTr("STR_Media")
                                }
                                return qsTr(model.title)
                            })
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
                    states: [
                        State {
                            when: appItemId.draggable
                            ParentChange {
                                target: appItemId
                                parent: rootId
                            }

                            AnchorChanges {
                                target: appItemId
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                            PropertyChanges {
                                target: scrollBarId
                                active: true
                            }
                        }
                    ]
                }
            }
        }
        ScrollBar.horizontal: ScrollBar {
            id: scrollBarId
            active: true
            height: 12
            anchors.bottom: menuId.top
            anchors.bottomMargin: -10
        }
        highlightMoveDuration: 400
        Keys.onPressed: {
            switch(event.key) {
            case Qt.Key_Return:
                openApplication(appModel.data(appModel.index(menuId.focusIndex,0), Qt.UserRole + 2))
                break;
            case Qt.Key_Right:
                if(menuId.focusIndex < menuId.count - 1) menuId.focusIndex++;
                break;
            case Qt.Key_Left:
                if(menuId.focusIndex > 0) menuId.focusIndex--;
                break
            case Qt.Key_Up:
                climateWidgetId.forceActiveFocus()
                break
            }
        }
        Component.onCompleted: menuId.forceActiveFocus()
    }
}
