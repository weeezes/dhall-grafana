let Grafana = ../package.dhall

let gauge =
      \(measurement : Text) ->
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
            [ [ { type = "field", params = [ "value" ] }
              , { type = "distinct", params = [] : List Text }
              ]
            ]
          , tags = [ { key = "metric_type", operator = "=", value = "gauge" } ]
          }

let resource-panel =
      \(title : Text) ->
      \(measurement : Text) ->
        Grafana.Panels.mkGraphPanel
          Grafana.GraphPanel::{
          , title
          , gridPos = { x = 0, y = 1, w = 24, h = 8 }
          , targets = [ gauge measurement ]
          }

let dashboard =
      Grafana.Dashboard::{
      , title = "InfluxDB metrics"
      , uid = Some "influxdb_metrics"
      , panels =
          Grafana.Utils.generateIds [ resource-panel "CPU" "zuul.local.cores" ]
      }

in  dashboard
