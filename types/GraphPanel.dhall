let MetricTargets = (./MetricTargets.dhall).MetricTargets

let PanelType = < graph >
let NullPointMode = < null | connected | `null as zero` >
let TooltipStackType = < individual | cumulative >

let GraphPanel =
    ./BasePanel.dhall //\\
    { type : PanelType 
    , datasource : Text 
    , targets : List MetricTargets
    , options : {} 
    , renderer : Text 
    , yaxes : List (./YAxis.dhall).Type
    , xaxis : (./XAxis.dhall).Type
    , yaxis : { align : Bool, alignLevel : Optional Natural }
    , lines : Bool 
    , fill : Natural 
    , linewidth : Natural 
    , dashes : Bool 
    , dashLength : Natural 
    , spaceLength : Natural 
    , points : Bool 
    , pointradius : Natural 
    , bars : Bool 
    , stack : Bool 
    , percentage : Bool 
    , legend : ./Legend.dhall
    , nullPointMode : NullPointMode
    , steppedLine : Bool 
    , tooltip : { value_type : TooltipStackType, shared : Bool, sort : Natural } 
    , timeFrom : Optional Text 
    , timeShift : Optional Text
    , hideTimeOverride : Bool
    , aliasColors : {} 
    , seriesOverrides : List { alias : Text }
    , thresholds : List (./Threshold.dhall).Type
    , timeRegions : List (./TimeRegion.dhall).Type
    }

in

{ Type = GraphPanel
, PanelType = PanelType
, NullPointMode = NullPointMode
, TooltipStackType = TooltipStackType
}