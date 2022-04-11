import QtQuick 2.12

MouseArea {
    height: 496
    width: 616
    Image {
        source: "qrc:/Img/widget/map/map_exm.png"
    }
    Image {
        source: "qrc:/Img/widget/widget_frame.png"
    }
    Image {
        source: "qrc:/Img/widget/map/car_icon.png"
        anchors.centerIn: parent
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
