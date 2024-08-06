import QtQuick 2.15

Rectangle {
    id: button    
    signal clicked
    property alias text: text.text
    property color textColor: textColor
    property color defaultBackgroundColor: defaultBackgroundColor
    property color highlitedColor: highlitedColor
    property bool pressed: mouse.pressed

    width: 60
    height: 60
    radius: 30
    border.width: 0
    color: defaultBackgroundColor
    state: "default"

    Text {
        id: text
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        lineHeight: 30
        font.pixelSize: 24
        color: textColor
        font.family: "Open Sans"
        font.weight: Font.DemiBold
    }

    MouseArea {
        id: mouse
        propagateComposedEvents: true
        anchors.fill: parent
        onClicked: button.clicked()
    }

    states: [
        State {
            name: "default"
            PropertyChanges { target: button; color: defaultBackgroundColor }
        },
        State {
            name: "highlited"
            PropertyChanges { target: button; color: highlitedColor }
        }
    ]

    onClicked: {
        parent.togglePaintButton(button);
    }
}
