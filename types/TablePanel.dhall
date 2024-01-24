let MetricTargets = ./MetricTargets.dhall

let PanelType = < table >

let TablePanel =
          ./BasePanel.dhall
      //\\  { type : PanelType
            , datasource : Optional Text
            , targets : List MetricTargets
            , options : {}
            , timeFrom : Optional Text
            , timeShift : Optional Text
            , hideTimeOverride : Bool
            , thresholds : List (./Threshold.dhall).Type
            }

in  { Type = TablePanel, PanelType }
