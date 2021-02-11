let TextPanel = ../types/TextPanel.dhall
in

{ id = 0
, alert = None (../types/Alert.dhall).Type
, content = "# Default"
, mode = TextPanel.Mode.markdown
, type = TextPanel.PanelType.text
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, repeatDirection = None ../types/Direction.dhall
, maxPerRow = None Natural
, transparent = False
, transformations = [] : List (../types/Transformations.dhall).Types
, fieldConfig = None (../types/FieldConfig.dhall).Type
}