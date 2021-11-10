let RawQueryType
    : Type
    = < raw >

let RawQueryTarget
    : Type
    = { hide : Bool, queryType : RawQueryType, rawQuery : Text, refId : Text }

in  { Type = RawQueryTarget, RawQueryType }
