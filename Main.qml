import QtQuick 2.0
import Ubuntu.Components 1.1
import "create-component.js" as ImageCreator

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "dynamicqml.liu-xiao-guo"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(60)
    height: units.gu(85)

    function itemAdded(obj, source) {
        objectsModel.append({"obj": obj, "source": source})
    }

    Page {
        id: root
        title: i18n.tr("dynamicqml")
        property int position: 0

        ListModel {
            id: objectsModel
        }


        Flickable {
            width: parent.width
            height: parent.height
            clip:true
            contentHeight: container.childrenRect.height

            Column {
                id: container
                anchors.centerIn: parent
            }
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: units.gu(1)
            spacing: units.gu(1)

            Button {
                text: "Create New"

                onClicked: {
                    var image = ImageCreator.createImageObject(0, root.position);
                    itemAdded(image, "dynamic-image.qml");
                    root.position += 200;
                }
            }

            Button {
                text: "Create from string"

                onClicked: {
                    var newObject = Qt.createQmlObject('import QtQuick 2.0;
                        Image {source: "images/image3.jpg"; width: 300; height: 200}',
                                                       container, "dynamicSnippet1");
                    newObject.x = 0;
                    newObject.y = root.position;
                }
            }

            Button {
                text: "Clear objects"

                onClicked: {
                    while(objectsModel.count > 0) {
                        objectsModel.get(0).obj.destroy();
                        objectsModel.remove(0);
                    }
                }
            }
        }

        Component.onCompleted: {
            var image = ImageCreator.createImageObject(0, 0);
            itemAdded(image, "dynamic-image.qml");
            root.position += 200
        }
    }
}

