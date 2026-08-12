import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
  id: powerMenu
  property bool hovered: false

  readonly property real iconSize: 24
  readonly property real buttonSpacing: 4

  readonly property real expandedWidth: (iconSize * 4) + (buttonSpacing * 3)
  readonly property real collapsedWidth: iconSize

  implicitHeight: 40
  Layout.preferredHeight: 40
  Layout.minimumWidth: collapsedWidth
  Layout.preferredWidth: hovered ? expandedWidth : collapsedWidth

  MouseArea {
    hoverEnabled: true
    onEntered: powerMenu.hovered = true
    onExited: powerMenu.hovered = false

    width: powerMenu.hovered ? powerMenu.expandedWidth : powerMenu.collapsedWidth
    height: parent.implicitHeight
    anchors.right: parent.right
  }

  Item {
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.bottom: parent.bottom
    width: powerMenu.hovered ? powerMenu.expandedWidth : powerMenu.collapsedWidth

    Behavior on width {
      PropertyAnimation {
        duration: 150
        easing.type: Easing.OutCubic
      }
    }

    RowLayout {
      anchors.fill: parent
      spacing: powerMenu.buttonSpacing

      Text {
        id: btnLogoff
        text: "󰿅"
        color: Appearance.foreground
        font: Appearance.fontNFIcon
        visible: powerMenu.hovered

        MouseArea {
          anchors.fill: parent
          onClicked: {
            Quickshell.execDetached(["sh", "-c", "hyprshutdown --vt 2"])
          }
        }
      }
      Text {
        id: btnLock
        text: "󰌾"
        color: Appearance.foreground
        font: Appearance.fontNFIcon
        visible: powerMenu.hovered

        MouseArea {
          anchors.fill: parent
          onClicked: {
            Quickshell.execDetached(["sh", "-c", "hyprlock"])
          }
        }
      }
      Text {
        id: btnReboot
        text: "󰜉"
        color: Appearance.foreground
        font: Appearance.fontNFIcon
        visible: powerMenu.hovered

        MouseArea {
          anchors.fill: parent
          onClicked: {
            Quickshell.execDetached(["sh", "-c", "systemctl reboot"])
          }
        }
      }
      Text {
        id: btnPoweroff
        text: "󰐥"
        color: Appearance.foreground
        font: Appearance.fontNFIcon

        MouseArea {
          onClicked: {
            Quickshell.execDetached(["sh", "-c", "systemctl poweroff"])
          }
        }
      }
    }
  }
}
