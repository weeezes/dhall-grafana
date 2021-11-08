let RawQueryTarget = ../types/RawQueryTarget.dhall

in    { hide = False
      , queryType = RawQueryTarget.RawQueryType.raw
      , rawQuery = ""
      , refId = ""
      }
    : RawQueryTarget.Type
