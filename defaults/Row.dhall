let Row = ../types/Row.dhall
in

{ type = Row.PanelType.row
, id = 0
, collapsed = False
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, repeatDirection = None ../types/Direction.dhall
, maxPerRow = None Natural
, transparent = False
}