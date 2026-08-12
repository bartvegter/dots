import Quickshell.Services.UPower
import QtQuick

Text {
  id: battery
  property UPowerDevice powerDevice: UPower.displayDevice
  visible: powerDevice ? powerDevice.ready && powerDevice.isLaptopBattery : false

  property string batteryIcon: {
    if (powerDevice.state === UPowerDeviceState.FullyCharged)
      return "󰁹"
    else if (powerDevice.state === UPowerDeviceState.Empty)
      return "󱃍"
    else if (powerDevice.state === UPowerDeviceState.Charging || powerDevice.state === UPowerDeviceState.PendingCharge)
      if (powerDevice.percentage < 0.1)
        return "󰢜"
      else if (powerDevice.percentage < 0.2)
        return "󰂆"
      else if (powerDevice.percentage < 0.3)
        return "󰂇"
      else if (powerDevice.percentage < 0.4)
        return "󰂈"
      else if (powerDevice.percentage < 0.5)
        return "󰢝"
      else if (powerDevice.percentage < 0.6)
        return "󰂉"
      else if (powerDevice.percentage < 0.7)
        return "󰢞"
      else if (powerDevice.percentage < 0.8)
        return "󰂊"
      else if (powerDevice.percentage < 0.9)
        return "󰂋"
      else
        return "󰂅"
    else if (powerDevice.state === UPowerDeviceState.Discharging || powerDevice.state === UPowerDeviceState.PendingDischarge)
      if (powerDevice.percentage < 0.1)
        return "󰁺"
      else if (powerDevice.percentage < 0.2)
        return "󰁻"
      else if (powerDevice.percentage < 0.3)
        return "󰁼"
      else if (powerDevice.percentage < 0.4)
        return "󰁽"
      else if (powerDevice.percentage < 0.5)
        return "󰁾"
      else if (powerDevice.percentage < 0.6)
        return "󰁿"
      else if (powerDevice.percentage < 0.7)
        return "󰂀"
      else if (powerDevice.percentage < 0.8)
        return "󰂁"
      else if (powerDevice.percentage < 0.9)
        return "󰂂"
      else
        return "󰁹"
    else
      return "󰂑"
  }

  text: Math.round(powerDevice.percentage * 100) + "% " + batteryIcon
  color: powerDevice.percentage < 0.2 ? Appearance.red : Appearance.foreground
  font: Appearance.font
}
