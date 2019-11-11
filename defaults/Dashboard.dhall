let Dashboard = ../types/Dashboard.dhall
let TimePicker = ./TimePicker.dhall

in

{ id = 0
, uid = None Text
, title = "Title"
, tags = [] : List Text
, style = Dashboard.Style.dark
, timezone = Some Dashboard.TimeZone.utc
, editable = False
, hideControls = False
, graphTooltip = 0
, panels = [] : List (../types/Panels.dhall).Panels
, time = { from = "now-6h", to = "now" }
, timepicker = TimePicker
, templating = { list = [] : List (../types/TemplatingVariable.dhall).Types }
-- , annotations: {
-- ,   list: []
-- , }
, refresh = "5s"
, schemaVersion = 17
, version = 0
, links = [] : List (../types/Link.dhall).Types
}
