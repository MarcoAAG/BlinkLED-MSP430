import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import "qml/controls"

Window {
    id: blinkLed
    width: 240
    height: 320
    visible: true
    title: qsTr("BlinkLED")


    Item {
        id: vars
        property var data: 0
        function toogle(){
            return data ^= 1
        }

    }


    Rectangle {
        id: bg
        color: "#1b1919"
        anchors.fill: parent
    }

    Rectangle {
        id: statusBar
        y: 167
        height: 20
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        Rectangle {
            id: statusBarColor
            color: "#1f1f1f"
            anchors.fill: parent
        }

        Label {
            id: version
            x: 178
            y: 0
            color: "#ffffff"
            text: qsTr("Version:1.0")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignBottom
            font.pointSize: 8
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 0
        }

        Label {
            id: developer
            color: "#ffffff"
            text: qsTr("MarcoAAG")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            font.pointSize: 8
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
        }
    }

    Rectangle {
        id: topBar
        height: 40
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: topBarColor
            color: "#0e0202"
            anchors.fill: parent

            Text {
                id: title
                color: "#ffffff"
                text: qsTr("Blink LED")
                anchors.fill: parent
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Black
            }
        }
    }

    Rectangle {
        id: content
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topBar.bottom
        anchors.bottom: statusBar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

        /*Button {
            id: clkBtn
            x: 70
            y: 201
            //property var data: 1
            opacity: 1
            text: "ON"
            anchors.verticalCenter: parent.verticalCenter
            autoExclusive: false
            highlighted: false
            flat: false
            checkable: true
            onClicked: backEnd.readBtn(vars.toogle())
            //onToggled: btnClick.test_slot(onToggled)
            autoRepeat: false
            anchors.horizontalCenter: parent.horizontalCenter
        }*/
        BlinkGUI{
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: backEnd.readBtn(vars.toogle())

        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}D{i:6}
}
##^##*/
