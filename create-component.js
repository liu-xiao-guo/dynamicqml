var component;

function createImageObject(x, y) {
    component = Qt.createComponent("dynamic-image.qml");
    if (component.status === Component.Ready || component.status === Component.Error)
        return finishCreation(x, y);
    else
        component.statusChanged.connect(finishCreation);
}

function finishCreation(x, y) {
    var image = null;
    if (component.status === Component.Ready)
    {
        image = component.createObject(container, {"x": x, "y": y, width: 300, height:200});
        if (image == null) {
            console.log("Error creating image");
        }
    }
    else if (component.status === Component.Error)
        console.log("Error loading component:", component.errorString());

   return image;
}
