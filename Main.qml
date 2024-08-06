import QtQuick 2.15
import QtQuick.Window 2.2

import Calculator 1.0


Window {
    id: mainWindow
    visible: true
    minimumWidth: 360
    minimumHeight: 616
    width: 360
    height: 616


    // Title
    title: qsTr("Calculator libri")

    Item {

        id: keyboardInputArea
        width: mainWindow.width
        height: mainWindow.height
        focus: true


        // Key-Input
        Keys.onReleased:
        {

            // Deubg-log
            console.log( "Key pressed #" + event.text );

            // Logic
            if ( event.key === Qt.Key_Enter )
                resultText.text = logic.doMath( );
            else if ( event.key === Qt.Key_Plus )
                resultText.text = logic.setOperationType( "+" )
            else if ( event.key === Qt.Key_Minus )
                resultText.text = logic.setOperationType( "-" )
            else if ( event.text === "/" ) // Can be replaced with key-code.
                resultText.text = logic.setOperationType( "/" )
            else if ( event.text === "*" ) /// Numpad multiply-key not respond.
                resultText.text = logic.setOperationType( "*" )
            else if ( event.text === "." )
                resultText.text = logic.onDot( );
            else if ( event.text === "," )
                resultText.text = logic.onDot( );
            else
                resultText.text = logic.onKeyboardInput( event.text );

            // Mark Event as handled.
            event.accepted = true;

        }

    }

    // Logic
    Calculator {
        id: logic
    }

    //grid for numbers
    Rectangle {
        id: buttonsPanel
        // Anchors
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        // Color
        color: "#024873"

        //Main pud
        Grid {
            property var currentActiveButtonID
            function togglePaintButton(button) {
                if (grid.currentActiveButtonID) {
                    grid.currentActiveButtonID.state = "default";
                    grid.currentActiveButtonID = button;
                    grid.currentActiveButtonID.state = "highlited";
                } else {
                    grid.currentActiveButtonID = button;
                    grid.currentActiveButtonID.state = "highlited";
                }
            }


            property int timerForEqualCounter: 4
            property int timerForChildWindowCounter: 5

            Timer {
                id: timerForEqual
                interval: 1000
                running: false
                repeat: true
                onTriggered: {
                    grid.timerForEqualCounter--;

                    if (grid.timerForEqualCounter === 0) {
                        stop();
                        timerForChildWindow.start();
                        grid.timerForEqualCounter = 4;
                    }
                }
            }

            Timer {
                id: timerForChildWindow
                interval: 1000
                running: false
                repeat: true
                onTriggered: {
                    --grid.timerForChildWindowCounter;
                    console.log("waiting for 123")

                    if (grid.timerForChildWindowCounter === 0) {
                        stop();
                        grid.timerForChildWindowCounter = 5;
                    }

                    if (resultText.text === "123"){
                        stop();
                        grid.timerForChildWindowCounter = 5;

                        var component = Qt.createComponent("SmallWindow.qml")
                        var window    = component.createObject("root")
                        window.show()
                    }
                }
            }


            id: grid
            columns: 4
            rows: 5
            spacing: 24
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottomMargin: 40

            Button {
                id: btn_brackets
                text: "()"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"

                onClicked: {
                    resultText.text = logic.onBrackeys();
                }
            }
            Button {
                id: btn_plsub
                text: "+/-"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"

                onClicked: {
                    resultText.text = logic.onChangeOperand();
                }
            }
            Button {
                id: btn_part
                text: "%"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.setOperationType( "%" );
                    historyText.text = logic.updateHistoryValue();
                }
            }
            Button {
                id: btn_div
                text: "÷"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.setOperationType( "/" );
                    historyText.text = logic.updateHistoryValue();
                }
            }
            Button {
                id: btn_7
                text: "7"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"

                onClicked: {
                    resultText.text = logic.onNumberInput( "7" );
                }
            }
            Button {
                id: btn_8
                text: "8"
                state: "default"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"

                onClicked: {
                    resultText.text = logic.onNumberInput( "8" );
                }

            }
            Button {
                id: btn_9
                text: "9"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "9" );
                }
            }
            Button {
                id: btn_mult
                text: "×"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.setOperationType( "*" );
                    historyText.text = logic.updateHistoryValue();
                }
            }
            Button {
                id: btn_4
                text: "4"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "4" );
                }
            }
            Button {
                id: btn_5
                text: "5"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "5" );
                }
            }
            Button {
                id: btn_6
                text: "6"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "6" );
                }
            }
            Button {
                id: btn_sub
                text: "-"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.setOperationType( "-" );
                    historyText.text = logic.updateHistoryValue();
                }
            }
            Button {
                id: btn_1
                text: "1"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "1" );
                }
            }
            Button {
                id: btn_2
                text: "2"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "2" );
                }
            }
            Button {
                id: btn_3
                text: "3"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "3" );
                }
            }
            Button {
                id: plus_Btn
                text: "+"

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.setOperationType( "+" );
                    historyText.text = logic.updateHistoryValue();
                }
            }
            Button {
                id: mc_Btn
                text: "C"

                defaultBackgroundColor: "#F25E5E"
                highlitedColor: "#F25E5E"
                textColor: "#FFFFFF"

                onClicked: {
                    logic.resetMemory( );
                    resultText.text = "0";
                    historyText.text = "";
                }
            }
            Button {
                id: btn_0
                text: "0"

                defaultBackgroundColor: "#B0D1D8"
                highlitedColor: "#04BFAD"
                textColor: "#024873"
                onClicked: {
                    resultText.text = logic.onNumberInput( "0" );
                }
            }
            Button {
                id: dot_Btn
                text: "."

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"
                onClicked: {
                    resultText.text = logic.onDot( );
                }
            }
            Button {
                id: doMath_Btn
                text: "="

                defaultBackgroundColor: "#0889A6"
                highlitedColor: "#F7E425"
                textColor: "#FFFFFF"

                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    propagateComposedEvents: true

                    onPressed: {
                        timerForEqual.start();
                    }
                    onReleased: {
                        timerForEqual.stop()
                    }
                }

                onClicked: {
                    resultText.text = logic.doMath( );
                    historyText.text = logic.updateHistoryValue();
                }
            }
        }
    }

    //working with operand and operators (text)
    Rectangle {
        // ID
        id: resultBox
        // Anchors
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        height: 156
        // Border
        radius: 24

        // Color
        color: "#46a2da"


        //for radius
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 24
            color: "#46a2da"
        }

        //history of operations(full string)
        Text {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 44
            anchors.rightMargin: 40
            anchors.leftMargin: 40

            id: historyText
            text: qsTr("")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 20
            font.letterSpacing: 0.5

            font.family: "Open Sans"
            fontSizeMode: Text.Fit
        }

        //current input text
        Text {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 14
            anchors.rightMargin: 40
            anchors.leftMargin: 40

            id: resultText
            text: qsTr("0")
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 50
            font.letterSpacing: 0.5


            font.family: "Open Sans"
            fontSizeMode: Text.Fit
        }
    }
}
