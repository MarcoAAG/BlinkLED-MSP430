import QtQuick 2.15
import QtQuick.Controls 2.15

Button{
    id: customBtn

    // custom properties
    property color color_default: "#FFFFFF"
    property color color_pressed: "#000000"
    property color color_mouseover: "#4E4B4B"

    property string on_text: "ON"
    property string off_text: "OFF"

    property color textColor:"#ffffff"

    QtObject{
        id: internal

        property var dynamic_color: if(customBtn.checked){
                                        customBtn.down ? color_default : color_pressed
                                    }else{
                                        customBtn.hovered ? color_default : color_default
                                    }
    }
    QtObject{
        id: text_Btn

        property var set_text: if(customBtn.checked){
                                   customBtn.down ? on_text : off_text
                               }else{
                                   customBtn.hovered ? on_text : on_text
                               }
    }
    QtObject{
        id: color_txt
        property var set_colorText: if(!customBtn.checked){
                                        customBtn.down ? color_default : color_pressed
                                    }else{
                                        customBtn.hovered ? color_default : color_default
                                    }
    }

    text: text_Btn.set_text
    checkable: true
    checked: true
    implicitHeight: 30
    implicitWidth: 110

    background: Rectangle{
        radius: 10
        color: internal.dynamic_color
    }
    contentItem: Item {
        id: item1
        Text {
            id: textBtn
            text: customBtn.text
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            color: color_txt.set_colorText
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:4;height:40;width:200}
}
##^##*/
