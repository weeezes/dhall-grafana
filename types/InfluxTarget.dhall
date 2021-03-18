let InfluxGroup = { params : List Text, type : Text }

let InfluxTag = { key : Text, operator : Text, value : Text }

let InfluxTarget =
      { groupBy : List InfluxGroup
      , select : List (List InfluxGroup)
      , measurement : Text
      , orderByTime : Text
      , policy : Text
      , resultFormat : Text
      , refId : Text
      , query : Text
      , rawQuery : Bool
      , tags : List InfluxTag
      }

in  { Type = InfluxTarget, InfluxGroup, InfluxTag }
