let ColorMode = < custom | critical | warning | ok >
let YAxis = < left | right >
let Op = < gt | lt >
let Threshold =
    { value : Natural
    , colorMode : ColorMode
    , op : Op
    , fill : Bool
    , line : Bool
    , yaxis : YAxis
    , fillColor : Optional Text
    , lineColor : Optional Text
    }

in

{ Type = Threshold
, ColorMode = ColorMode
, YAxis = YAxis
, Op = Op
}