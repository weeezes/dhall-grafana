let Row = ../types/Row.dhall
in

{ collapsed = False
, type = Row.PanelType.row
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, transparent = False
}