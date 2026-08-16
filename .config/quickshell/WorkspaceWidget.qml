import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: workspaces
  spacing: 10

  Repeater {
    model: 9

    Text {
      id: wsNumber
      required property int index
      property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
      property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)

      text: index + 1
      color: isActive ? Appearance.green : (ws ? Appearance.foreground : Appearance.fgDimmed2)
      font: Appearance.fontBold

      Rectangle {
        visible: wsNumber.isActive
        color: Appearance.green
        implicitHeight: 2
        anchors {
          left: parent.left
          right: parent.right
          bottom: parent.bottom
        }
      }

      MouseArea {
        anchors.fill: parent
        onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (wsNumber.index + 1) + " })")
      }
    }
  }
}
