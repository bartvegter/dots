import QtQuick
import Quickshell

Text {
  text: Qt.formatDateTime(clock.date, "HH:mm")
  color: Appearance.foreground
  font: Appearance.font

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
