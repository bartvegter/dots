pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Networking
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

        NetworkWidget { id: networkWidget }

        BatteryWidget {}

        PowerMenuWidget {}
      }

      MenuPopup {
        id: networkPopup
        anchorWindow: barRoot
        anchorItem: networkWidget
        sourceHovered: networkWidget.hovered
        // Anchor a one-pixel point on the bar's lower edge instead of the
        // vertically centered text item.
        useAnchorRectOverride: true
        anchorRectOverride: Qt.rect(networkWidget.x, barRoot.height, 1, 1)
        anchorEdges: Edges.Top | Edges.Left
        popupGravity: Edges.Bottom | Edges.Left
        implicitWidth: 260
        implicitHeight: 112

        Column {
          id: networkDetails
          anchors.fill: parent
          spacing: 6

          Text {
            text: networkWidget.currentNetwork
              ? networkWidget.currentNetwork.name
              : "No active network"
            color: Appearance.foreground
            font: Appearance.fontBold
            elide: Text.ElideRight
            width: networkDetails.width
          }

          Text {
            text: networkWidget.netDev
              ? (networkWidget.netDev.type === DeviceType.Wired
                ? "Wired connection"
                : "Wi-Fi connection")
              : "No network device available"
            color: Appearance.fgDimmed1
            font: Appearance.font
            width: networkDetails.width
            elide: Text.ElideRight
          }

          Text {
            visible: networkWidget.currentNetwork
              && networkWidget.netDev
              && networkWidget.netDev.type === DeviceType.Wifi
            text: "Signal: " + Math.round(networkWidget.currentNetwork.signalStrength * 100) + "%"
            color: Appearance.fgDimmed1
            font: Appearance.font
          }
        }
      }
    }
  }
}
