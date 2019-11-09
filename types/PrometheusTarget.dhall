let FormatType = < table | time_series | heatmap >
let PrometheusTarget =
    { refId : Text
    , expr : Text
    , intervalFactor : Natural
    , format : FormatType
    , legendFormat : Optional Text
    , interval : Optional Natural
    , instant : Bool
    }

in

{ Type = PrometheusTarget
, FormatType = FormatType
}