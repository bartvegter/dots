pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Networking
import QtQuick

Text {
  id: networking
  readonly property var netDev: Networking.devices.values[0]
  readonly property var currentNetwork: netDev ? netDev.networks.values[0] : null
  // Consumed by a MenuPopup declared beside the PanelWindow in Bar.qml.
  readonly property bool hovered: networkMouse.containsMouse

  property string networkIcon: {
    if (netDev && currentNetwork) {
      if (netDev.type === DeviceType.Wired) {
        return "󰈀"
      } else if (netDev.type === DeviceType.Wifi) {
        if (netDev.state === ConnectionState.Disconnecting) {
          return "󰤭"
        } else if (netDev.state === ConnectionState.Disconnected) {
          return "󰤮"
        } else if (netDev.state === ConnectionState.Connecting) {
          if (currentNetwork.signalStrength < 0.20) {
            return "󰤫"
          } else if (currentNetwork.signalStrength < 0.40) {
            return "󰤠"
          } else if (currentNetwork.signalStrength < 0.60) {
            return "󰤣"
          } else if (currentNetwork.signalStrength < 0.80) {
            return "󰤦"
          } else {
            return "󰤩"
          }
        } else if (netDev.state === ConnectionState.Connected) {
          if (currentNetwork.signalStrength < 0.20) {
            return "󰤯"
          } else if (currentNetwork.signalStrength < 0.40) {
            return "󰤟"
          } else if (currentNetwork.signalStrength < 0.60) {
            return "󰤢"
          } else if (currentNetwork.signalStrength < 0.80) {
            return "󰤥"
          } else {
            return "󰤨"
          }
        } else {
          return "󰤫"
        }
      } else {
        return "󰈂"
      }
    } else {
      return ""
    }
  }

  text: netDev ? currentNetwork ? currentNetwork.name + " " + networkIcon : "󰈂" : "󰈂"
  color: Appearance.foreground
  font: Appearance.font

  MouseArea {
    id: networkMouse
    anchors.fill: parent
    hoverEnabled: true
    onClicked: Quickshell.execDetached(["sh", "-c", "ghostty -e impala"])
  }
}
