let Op = < time >

let ColorMode = < gray | red | green | blue | yellow | custom >

let TimeRegion =
      { op : Op
      , fromDayOfWeek : Natural
      , from : Text
      , toDayOfWeek : Natural
      , to : Text
      , colorMode : ColorMode
      , fill : Bool
      , line : Bool
      , fillColor : Optional Text
      , lineColor : Optional Text
      }

in  { Type = TimeRegion, Op, ColorMode }
