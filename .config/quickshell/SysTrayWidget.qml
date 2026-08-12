pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick

Repeater {
  id: sysTray
  model: SystemTray.items

  Item {
    id: sysTrayItem
    required property SystemTrayItem modelData
    implicitWidth: 16
    implicitHeight: 16

    QsMenuAnchor {
      id: menuAnchor
      menu: sysTrayItem.modelData.menu
      anchor.window: barRoot
    }

    Image {
      anchors.fill: parent
      source: sysTrayItem.modelData.icon

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        onClicked: {
          if (sysTrayItem.modelData.hasMenu) {
            menuAnchor.open()
          }
        }
      }
    }

  }
}
