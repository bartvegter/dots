import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

RowLayout {
  id: audio
  PwObjectTracker { objects: [audioOut.defaultOutput, audioIn.defaultInput] }

  MouseArea {
    acceptedButtons: Qt.LeftButton
    onClicked: {
      Quickshell.execDetached(["sh", "-c", "pavucontrol"])
    }
  }

  Text {
    id: audioOut
    readonly property PwNode defaultOutput: Pipewire.defaultAudioSink
    readonly property real outputVolume: defaultOutput ? defaultOutput.audio.volume : 1.0
    readonly property string volumePercentage: Math.round(outputVolume * 100) + "%"

    readonly property string outputText: {
      if (defaultOutput) {
        if (defaultOutput.audio.muted) {
          return "󰖁"
        } else {
          if (defaultOutput.audio.volume < 0.34) {
            return volumePercentage + " 󰕿"
          } else if (defaultOutput.audio.volume < 0.67) {
            return volumePercentage + " 󰖀"
          } else {
            return volumePercentage + " 󰕾"
          }
        }
      } else {
        return ""
      }
    }

    color: Appearance.foreground
    font: Appearance.font
    text: outputText

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.RightButton
      onClicked: {
        Quickshell.execDetached(["sh", "-c", "pactl set-sink-mute @DEFAULT_SINK@ toggle"])
      }
    }
  }
  Text {
    id: audioIn
    readonly property PwNode defaultInput: Pipewire.defaultAudioSource
    readonly property string inputIndicator: {
      if (defaultInput) {
        if (defaultInput.audio.muted) {
          return " 󰍭"
        } else {
          return " 󰍬"
        }
      } else {
        return ""
      }
    }

    color: Appearance.foreground
    font: Appearance.font
    text: inputIndicator

    MouseArea {
      anchors.fill: parent
      acceptedButtons: Qt.RightButton
      onClicked: {
        Quickshell.execDetached(["sh", "-c", "pactl set-source-mute @DEFAULT_SOURCE@ toggle"])
      }
    }
  }
}
