import QtQuick 2.15

Item {
    id: backButton

    // Add a clicked signal here
    signal clicked()

    Rectangle{
        MouseArea {
            id: mouse
            anchors.fill: parent
            onClicked: backButton.clicked()
        }

        id: baseButton
        text: "Back"

        onClicked: {
            // Emit the new clicked signal here:
            backButton.clicked();
        }
    }
}
