import Quickshell
import Quickshell.Bluetooth
import QtQuick

Text {
  id: bluetooth
  readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
  readonly property bool connected: adapter ? adapter.devices.values.length > 0 : false
  readonly property var connectedBattery: adapter ? adapter.devices.values.find((dev) => dev.batteryAvailable === "") : null
  readonly property string batteryPercentage: connectedBattery ? Math.round(connectedBattery.batteryPercentage * 100) + "% " : ""

  property string btIcon: {
    if (adapter && adapter.enabled) {
      return "󰂯"
    } else {
      return "󰂲"
    }
  }

  color: Appearance.foreground
  font: Appearance.font
  text: batteryPercentage + btIcon

  MouseArea {
    anchors.fill: parent
    onClicked: {
      Quickshell.execDetached(["sh", "-c", "ghostty -e bluetui"])
    }
  }
}
