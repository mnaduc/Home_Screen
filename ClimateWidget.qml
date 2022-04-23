import QtQuick 2.12

MouseArea {
    width: 616
    height: 496
    onClicked: focus = true
    // background
    Image {
        source: "qrc:/Img/widget/widget_bg.png"
        anchors.fill: parent
    }
    Text {
        id: name
        text: qsTr("STR_Climate")
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 30
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.top
            bottomMargin: -68
        }
    }
    Image {
        id: fanLevelId
        property int level: climateModel.fan_level
        source: "qrc:/Img/widget/climate/widget_climate_wind_level_bg.png"
        anchors.centerIn: parent
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_wind_level_05.png"
            anchors.fill: parent
            Component.onCompleted: {
                source = Qt.binding(function(){
                    if(parent.level < 1)
                        return ""
                    else if(parent.level > 9)
                        return "qrc:/Img/widget/climate/widget_climate_wind_level_10.png"
                    else
                        return "qrc:/Img/widget/climate/widget_climate_wind_level_0"+parent.level+".png"
                })
            }
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_ico_wind.png"
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: fanLevelId.bottom
                topMargin: 11
            }
        }
    }
    Text {
        id: temOutsideid
        text: "27.5°C"
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 32
        anchors {
            bottom: parent.bottom
            bottomMargin: 29
            horizontalCenter: parent.horizontalCenter
        }
        Text {
            text: qsTr("STR_OUTSIDE")
            color: "#EEEEEE"
            font.family: "Arial"
            font.pixelSize: 22
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.top
                bottomMargin: 3
            }
        }
    }
    Text {
        id: autoModeId
        property bool state: climateModel.auto_mode
        text: qsTr("AUTO")
        font.family: "Arial"
        font.pixelSize: 40
        color: state ? "#EEEEEE" : "#555555"
        anchors {
            left: parent.left
            leftMargin: 50
            bottom: parent.bottom
            bottomMargin: 49
        }
    }
    Text {
        id: syncModeId
        property bool state: climateModel.sync_mode
        text: qsTr("SYNC")
        font.family: "Arial"
        font.pixelSize: 40
        color: state ? "#EEEEEE" : "#555555"
        anchors {
            right: parent.right
            rightMargin: 50
            bottom: parent.bottom
            bottomMargin: 49
        }
    }
    // Driver
    Item {
        id: windDirectionDriverId
        property bool faceDirectionstate: climateModel.driver_wind_mode != 1
        property bool footDirectionstate: climateModel.driver_wind_mode != 0
        width: 160
        height: 120
        anchors {
            top: parent.top
            topMargin: 167
            left: parent.left
            leftMargin: 52
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_seat.png"
            anchors.right: parent.right
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_01_"+ (parent.faceDirectionstate ? "on":"off") +".png"
            anchors {
                top: parent.top
                topMargin: 34
                left: parent.left
                leftMargin: 25
            }
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_02_"+ (parent.footDirectionstate ? "on":"off") +".png"
            anchors {
                bottom: parent.bottom
                bottomMargin: 16
            }
        }
    }
    Image {
        source: "qrc:/Img/widget/climate/widget_climate_line.png"
        anchors {
            horizontalCenter: windDirectionDriverId.horizontalCenter
            bottom: windDirectionDriverId.top
            bottomMargin: 21
        }
    }
    Text {
        text: qsTr("STR_DRIVER")
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 28
        anchors {
            horizontalCenter: windDirectionDriverId.horizontalCenter
            bottom: windDirectionDriverId.top
            bottomMargin: 24
        }
    }
    Text {
        id: temDriverId
        property double temp: climateModel.driver_temp
        text: "##.#°C"
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 36
        anchors {
            horizontalCenter: windDirectionDriverId.horizontalCenter
            bottom: windDirectionDriverId.bottom
            bottomMargin: -58
        }

        Component.onCompleted: {
            text = Qt.binding(function(){
                if(temp <= 16.5)
                    return qsTr("STR_Low")
                else if(temp >= 31.5)
                    return qsTr("STR_High")
                else
                    return temp + "°C"
            })
        }
    }
    // Passenger
    Item {
        id: windDirectionPassengerId
        property bool faceDirectionstate: climateModel.passenger_wind_mode != 1
        property bool footDirectionstate: climateModel.passenger_wind_mode != 0
        width: 160
        height: 120
        anchors {
            top: parent.top
            topMargin: 167
            right: parent.right
            rightMargin: 52
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_seat.png"
            anchors.right: parent.right
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_01_"+ (parent.faceDirectionstate ? "on":"off") +".png"
            anchors {
                top: parent.top
                topMargin: 34
                left: parent.left
                leftMargin: 25
            }
        }
        Image {
            source: "qrc:/Img/widget/climate/widget_climate_arrow_02_"+ (parent.footDirectionstate ? "on":"off") +".png"
            anchors {
                bottom: parent.bottom
                bottomMargin: 16
            }
        }
    }
    Image {
        source: "qrc:/Img/widget/climate/widget_climate_line.png"
        anchors {
            horizontalCenter: windDirectionPassengerId.horizontalCenter
            bottom: windDirectionPassengerId.top
            bottomMargin: 21
        }

    }
    Text {
        text: qsTr("STR_PASSENGER")
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 28
        anchors {
            horizontalCenter: windDirectionPassengerId.horizontalCenter
            bottom: windDirectionPassengerId.top
            bottomMargin: 24
        }
    }
    Text {
        id: temPassengerId
        property double temp: climateModel.passenger_temp
        text: "##.#°C"
        color: "#EEEEEE"
        font.family: "Arial"
        font.pixelSize: 36
        anchors {
            horizontalCenter: windDirectionPassengerId.horizontalCenter
            bottom: windDirectionPassengerId.bottom
            bottomMargin: -58
        }

        Component.onCompleted: {
            text = Qt.binding(function(){
                if(temp <= 16.5)
                    return qsTr("STR_Low")
                else if(temp >= 31.5)
                    return qsTr("STR_High")
                else
                    return temp + "°C"
            })
        }
    }

    //focus state
    Image {
        source: parent.focus ? "qrc:/Img/widget/widget_f.png":""
    }
    // press state
    Image {
        source: pressed ? "qrc:/Img/widget/widget_p.png":""
    }
}
