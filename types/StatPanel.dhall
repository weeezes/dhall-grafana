let PanelType = < stat >
let NullPointMode = < null | connected | `null as zero` >

let StatPanel =
    ./BasePanel.dhall //\\
    { type : PanelType
    , datasource : Optional Text
    , targets : List ./MetricTargets.dhall
    , timeFrom : Optional Text
    , timeShift : Optional Text
    , options : (./StatPanelOptions.dhall).Type
    , maxDataPoints : Natural
    -- , interval : Optional Text
    -- , cacheTimeout : Optional Text
    , format : Text
    , prefix : Text
    , postfix : Text
    , nullText : Optional Text
    , valueMaps : List { value : Text, op : Text, text : Text }
    , mappingTypes : List { name : Text, value : Natural }
    , rangeMaps : List { from : Text, to : Text, text : Text }
    , mappingType : Natural
    , nullPointMode : NullPointMode
    , valueName : Text
    , prefixFontSize : Text
    , valueFontSize : Text
    , postfixFontSize : Text
    , thresholds : Text
    , colorBackground : Bool
    , colorValue : Bool
    , colors : List Text
    , sparkline :
        { show : Bool
        , full : Bool
        , lineColor : Text
        , fillColor : Text
        }
    , gauge :
        { show : Bool
        , minValue : Natural
        , maxValue : Natural
        , thresholdMarkers : Bool
        , thresholdLabels : Bool
        }
    , tableColumn : Text
    , decimals : Optional Natural
    , colorPrefix : Optional Bool
    , colorPostfix : Optional Bool
    }

in

{ Type = StatPanel
, PanelType
, NullPointMode
}
