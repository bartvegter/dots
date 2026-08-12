pragma Singleton

import Quickshell
import QtQuick

Singleton {
  readonly property color background: "#2D2A2E"
  readonly property color foreground: "#FCFCFA"
  readonly property color red: "#FF6188"
  readonly property color orange: "#FC9867"
  readonly property color yellow: "#FFD866"
  readonly property color green: "#A9DC76"
  readonly property color blue: "#78DCE8"
  readonly property color purple: "#AB9DF2"
  readonly property color fgDimmed1: "#C1C0C0"
  readonly property color fgDimmed2: "#939293"
  readonly property color fgDimmed3: "#727072"
  readonly property color fgDimmed4: "#5B595C"
  readonly property color fgDimmed5: "#403E41"
  readonly property color bgDimmed1: "#221F22"
  readonly property color bgDimmed2: "#19181A"
  readonly property font font: ({
    family: "JetBrainsMono Nerd Font",
    pointSize: 12,
  })
  readonly property font fontBold: ({
    family: "JetBrainsMono Nerd Font",
    pointSize: 12,
    bold: true
  })
  readonly property font fontNFIcon: ({
    family: "JetBrainsMono Nerd Font Propo",
    pointSize: 13,
  })
}
