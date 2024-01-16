let Grafana = ../package.dhall

let noaa-target =
      \(measurement : Text) ->
      \(field : Text) ->
        Grafana.MetricsTargets.InfluxTarget
          { groupBy =
            [ { type = "time", params = [ "\$__interval" ] }
            , { type = "fill", params = [ "previous" ] }
            ]
          , measurement
          , orderByTime = "ASC"
          , policy = "default"
          , refId = "A"
          , alias = measurement
          , resultFormat = "time_series"
          , select =
            [ [ { type = "field", params = [ field ] }
              , { type = "distinct", params = [] : List Text }
              ]
            ]
          , tags = [] : List { key : Text, operator : Text, value : Text }
          }

let noaa-panel =
      \(title : Text) ->
      \(measurement : Text) ->
      \(field : Text) ->
        Grafana.Panels.mkGraphPanel
          Grafana.GraphPanel::{
          , title
          , datasource = Some "InfluxDB"
          , gridPos = { x = 0, y = 1, w = 24, h = 8 }
          , targets = [ noaa-target measurement field ]
          }

let dashboard =
      Grafana.Dashboard::{
      , title = "InfluxDB metrics"
      , uid = Some "influxdb_metrics"
      , editable = True
      , time = { from = "2019-09-16T21:00:00Z", to = "2019-09-17T20:00:00Z" }
      , panels =
          Grafana.Utils.generateIds
            [ noaa-panel "H2O (feet)" "h2o_feet" "water_level" ]
      }

in  dashboard
