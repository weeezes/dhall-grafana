let GraphPanel = ../types/GraphPanel.dhall
let MetricTargets = ../types/MetricTargets.dhall
in

{ type = GraphPanel.PanelType.graph
, alert = None (../types/Alert.dhall).Type
, id = 0
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, repeatDirection = None ../types/Direction.dhall
, maxPerRow = None Natural
, transparent = False
, datasource = None Text
, targets = [] : List MetricTargets
, options = {=}
, renderer = "flot"
, yaxes =
    [ ./YAxis.dhall
    , ./YAxis.dhall
    ]
, xaxis = ./XAxis.dhall
, yaxis = { align = False, alignLevel = None Natural }
, lines = True
, fill = 1
, linewidth = 1
, dashes = False
, dashLength = 10
, spaceLength = 10
, points = False
, pointradius = 2
, bars = False
, stack = False
, percentage = False
, legend = ./Legend.dhall
, nullPointMode = GraphPanel.NullPointMode.null
, steppedLine = False
, tooltip =
    { value_type = GraphPanel.TooltipStackType.individual
    , shared = True
    , sort = 0
    }
, timeFrom = None Text
, timeShift = None Text
, hideTimeOverride = False
, aliasColors = {=}
, seriesOverrides = [] : List { alias : Text }
, thresholds = [] : List (../types/Threshold.dhall).Type
, timeRegions = [] : List (../types/TimeRegion.dhall).Type
, transformations = [] : List (../types/Transformations.dhall).Types
, fieldConfig = None (../types/FieldConfig.dhall).Type
}