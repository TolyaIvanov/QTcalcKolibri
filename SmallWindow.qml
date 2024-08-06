import QtQuick 2.15

Window {
    id: childWindow
    minimumWidth: 260
    minimumHeight: 200



    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 200
        color: "#46a2da"

        Text {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 44
            anchors.rightMargin: 40
            anchors.leftMargin: 40

            id: historyText
            text: qsTr("Секретное меню.")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 20
            font.letterSpacing: 0.5

            font.family: "Open Sans"
        }


        Rectangle {
            id: backButton
            signal clicked

            anchors.right: parent.right
            anchors.left: parent.left
            anchors.bottom: parent.bottom

            width: 90
            height: 60

            Text {
                id: text
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: "Назад."
                lineHeight: 30
                font.pixelSize: 24
                color: "black"
                font.family: "Open Sans"
                font.weight: Font.DemiBold
            }

            MouseArea {
                id: mouse
                anchors.fill: parent
                onClicked: backButton.clicked()
            }

            onClicked: {
                onClicked: childWindow.close()
            }
        }
    }
}
