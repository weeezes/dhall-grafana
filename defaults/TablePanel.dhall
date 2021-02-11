let TablePanel = ../types/TablePanel.dhall
let MetricTargets = ../types/MetricTargets.dhall
in

{ type = TablePanel.PanelType.table
, alert = None (../types/Alert.dhall).Type
, id = 0
, links = [] : List (../types/Link.dhall).Types
, repeat = None Text
, repeatDirection = None ../types/Direction.dhall
, maxPerRow = None Natural
, datasource = None Text
, targets = [] : List MetricTargets
, options = {=}
, thresholds = [] : List (../types/Threshold.dhall).Type
, timeFrom = None Text
, timeShift = None Text
, hideTimeOverride = False
, transparent = False
, transformations = [] : List (../types/Transformations.dhall).Types
, fieldConfig = None (../types/FieldConfig.dhall).Type
}
