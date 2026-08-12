pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: barRoot

      required property var modelData
      screen: modelData

      implicitHeight: 40
      color: Appearance.background

      anchors {
        top: true
        left: true
        right: true
      }

      RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 14
        anchors.rightMargin: 14
        spacing: 20

        AppLauncherWidget {}

        ClockWidget {}

        WorkspaceWidget {}

        Item { Layout.fillWidth: true }

        SysTrayWidget {}

        AudioWidget {}

        BluetoothWidget {}

        NetworkWidget {}

        BatteryWidget {}

        PowerMenuWidget {}
      }
    }
  }
}
