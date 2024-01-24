let Style = < dark | light >

let TimeZoneOption = < utc | browser >

let Dashboard =
      { id : Natural
      , uid : Optional Text
      , title : Text
      , tags : List Text
      , style : Style
      , timezone : Optional TimeZoneOption
      , editable : Bool
      , hideControls : Bool
      , graphTooltip : Natural
      , panels : List (./Panels.dhall).Panels
      , time : ./Time.dhall
      , timepicker : (./TimePicker.dhall).Type
      , templating : { list : List (./TemplatingVariable.dhall).Types }
      , refresh : Text
      , schemaVersion : Natural
      , version : Natural
      , links : List (./Link.dhall).Types
      }

in  { Type = Dashboard, Style, Timezone = TimeZoneOption }
