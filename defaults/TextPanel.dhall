let TextPanel = ../types/TextPanel.dhall
in

{ content = "# Default"
, mode = TextPanel.Mode.markdown
, type = TextPanel.PanelType.text
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, transparent = False
}