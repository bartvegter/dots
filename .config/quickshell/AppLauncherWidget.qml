import Quickshell
import QtQuick

Text {
  id: appLauncher
  text: "󰣇"
  color: Appearance.foreground
  font: Appearance.fontNFIcon

  MouseArea {
    anchors.fill: parent
    onClicked: {
      Quickshell.execDetached(["sh", "-c", "rofi -show drun -run-command 'uwsm app -- {cmd}'"])
    }
  }
}
