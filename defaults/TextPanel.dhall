let TextPanel = ../types/TextPanel.dhall
in

{ id = 0
, content = "# Default"
, mode = TextPanel.Mode.markdown
, type = TextPanel.PanelType.text
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, repeatDirection = None ../types/Direction.dhall
, maxPerRow = None Natural
, transparent = False
}