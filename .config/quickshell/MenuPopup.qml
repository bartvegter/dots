import QtQuick
import Quickshell

PopupWindow {
  id: root

  // The PanelWindow and Item that this popup is attached to. PopupWindow is a
  // window rather than an Item, so declare it beside the panel, not inside the
  // widget that triggers it.
  required property var anchorWindow
  required property Item anchorItem
  property bool sourceHovered: false

  // Popup placement. The defaults make a top bar dropdown open below its
  // trigger, aligned to its left edge.
  property Edges anchorEdges: Edges.Bottom | Edges.Left
  property Edges popupGravity: Edges.Bottom | Edges.Left
  property PopupAdjustment popupAdjustment: PopupAdjustment.Flip | PopupAdjustment.Slide
  // Adjusts the anchor rectangle without each caller needing to duplicate the
  // item-to-window coordinate conversion. Positive y moves the popup down.
  property point anchorOffset: Qt.point(0, 0)
  // Use an explicit rectangle when the popup should attach to a point other
  // than the trigger item's bounds (for example, the bottom edge of a bar).
  property bool useAnchorRectOverride: false
  property rect anchorRectOverride: Qt.rect(0, 0, 1, 1)

  // Set this from a click handler for click-open menus. Hover popups maintain
  // it themselves through sourceHovered and popupHovered.
  property bool open: false
  property bool closeOnHoverLeave: true
  property int closeDelay: 180

  property color backgroundColor: Appearance.bgDimmed1
  property color borderColor: Appearance.background
  property real borderWidth: 1
  property real radius: 8
  property real padding: 10

  readonly property bool popupHovered: popupHover.hovered

  // Children declared in MenuPopup are placed above the background. Give the
  // popup an implicit size and use anchors/margins on its content as needed.
  default property alias content: contentItem.data

  property bool expanded: false

  implicitWidth: 200
  implicitHeight: 100
  // PopupWindow defaults to an opaque window background. The animated frame is
  // the only intended visible surface, so keep the rest transparent.
  color: "transparent"
  visible: false
  grabFocus: false

  anchor {
    window: root.anchorWindow
    rect: root.anchorRect()
    edges: root.anchorEdges
    gravity: root.popupGravity
    adjustment: root.popupAdjustment
  }

  function anchorRect() {
    if (useAnchorRectOverride)
      return anchorRectOverride

    if (!anchorWindow || !anchorItem)
      return Qt.rect(0, 0, 0, 0)

    const itemRect = anchorWindow.itemRect(anchorItem)
    return Qt.rect(
      itemRect.x + anchorOffset.x,
      itemRect.y + anchorOffset.y,
      itemRect.width,
      itemRect.height
    )
  }

  // Call this after moving an anchor while the popup is visible. Layout-driven
  // bar widgets normally refresh when hover opens the popup.
  function updateAnchor() {
    anchor.rect = anchorRect()
    // PopupAnchor.updateAnchor() is for item-based anchors. The explicit
    // window-relative rectangle above is already in the correct coordinates.
    if (!useAnchorRectOverride)
      anchor.updateAnchor()
  }

  onVisibleChanged: {
    // A focus-grabbing click menu is hidden by Quickshell on outside click.
    if (!visible && open)
      open = false
  }

  onOpenChanged: {
    if (open) {
      hideAnimation.stop()
      visible = true
      expanded = false
      showAnimation.restart()
    } else {
      expanded = false
      hideAnimation.restart()
    }
  }

  function updateOpenState() {
    if (!closeOnHoverLeave)
      return

    if (sourceHovered || popupHovered) {
      closeTimer.stop()
      updateAnchor()
      open = true
    } else {
      closeTimer.restart()
    }
  }

  onSourceHoveredChanged: updateOpenState()
  onPopupHoveredChanged: updateOpenState()

  Timer {
    id: closeTimer
    interval: root.closeDelay
    repeat: false
    onTriggered: {
      if (!root.sourceHovered && !root.popupHovered)
        root.open = false
    }
  }

  Timer {
    id: showAnimation
    interval: 0
    repeat: false
    onTriggered: root.expanded = true
  }

  Timer {
    id: hideAnimation
    interval: 180
    repeat: false
    onTriggered: {
      if (!root.open)
        root.visible = false
    }
  }

  Item {
    anchors.fill: parent

    HoverHandler {
      id: popupHover
    }
  }

  Rectangle {
    id: frame
    anchors.left: parent.left
    anchors.top: parent.top
    width: parent.width
    height: root.expanded ? parent.height : 0
    clip: true
    color: root.backgroundColor
    border.color: root.borderColor
    border.width: root.borderWidth
    radius: root.radius

    Behavior on height {
      NumberAnimation { duration: 180; easing.type: Easing.OutCubic }
    }

    Item {
      id: contentItem
      anchors.fill: parent
      anchors.margins: root.padding
      opacity: root.expanded ? 1 : 0

      Behavior on opacity {
        NumberAnimation { duration: 140; easing.type: Easing.OutCubic }
      }
    }
  }
}
