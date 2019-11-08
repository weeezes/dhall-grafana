let SinglestatPanel = ../types/SinglestatPanel.dhall
let MetricTarget = ../types/MetricTarget.dhall
let Link = ../types/Link.dhall

in

{ type = SinglestatPanel.PanelType.singlestat
, timeFrom = None Text
, timeShift = None Text
, options = {=}
, links = [] : List Link.Types
, colorPostfix = None Bool
, colorPrefix = None Bool
, datasource = "Prometheus"
, decimals = None Natural
, targets = [] : List MetricTarget.Type
, maxDataPoints = 100
, format = "none"
, prefix = ""
, postfix = ""
, nullText = None Text
, valueMaps = 
    [   { value = "null"
        , op = "="
        , text = "N/A"
        }
    ]
, mappingTypes = 
    [   { name = "value to text"
        , value = 1
        }
    ,   { name = "range to text"
        , value = 2
        }
    ]
, rangeMaps = [
    { from = "null"
    , to = "null"
    , text = "N/A"
    }
  ]
, mappingType = 1
, nullPointMode = SinglestatPanel.NullPointMode.connected
, valueName = "avg"
, prefixFontSize = "50%"
, valueFontSize = "80%"
, postfixFontSize = "50%"
, thresholds = ""
, colorBackground = False
, colorValue = False
, colors = 
    [ "#299c46"
    , "rgba(237, 129, 40, 0.89)"
    , "#d44a3a"
    ]
, sparkline = 
    { show = False
    , full = False
    , lineColor = "rgb(31, 120, 193)"
    , fillColor = "rgba(31, 118, 189, 0.18)"
    }
, gauge = 
    { show = False
    , minValue = 0
    , maxValue = 100
    , thresholdMarkers = True
    , thresholdLabels = False
    }
, tableColumn = ""
}