let AxisMode = < time | series | histogram >

let Axis =
      { show : Bool
      , mode : AxisMode
      , name : Optional Text
      , values : List Text
      , buckets : Optional Natural
      , min : Optional Natural
      , max : Optional Natural
      }

in  { Type = Axis, Mode = AxisMode }
