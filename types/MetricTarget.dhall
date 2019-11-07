let FormatType = < table | time_series | heatmap >
let MetricTarget =
    { refId : Text
    , expr : Text
    , intervalFactor : Natural
    , format : FormatType
    , legendFormat : Optional Text
    , interval : Optional Natural
    , instant : Bool
    }

in

{ Type = MetricTarget
, FormatType = FormatType
}