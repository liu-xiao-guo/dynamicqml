import QtQuick 2.0

Image {
    width: 400
    height: 225

    source: "images/image1.jpg"

    Image {
        id: overlay

        anchors.fill: parent

        source: "images/image2.jpg"

        opacity: 0;
        Behavior on opacity { NumberAnimation { duration: 300 } }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (overlay.opacity === 0)
                overlay.opacity = 1;
            else
                overlay.opacity = 0;
        }
    }
}
