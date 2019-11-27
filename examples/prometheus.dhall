let Grafana = ../package.dhall

let map = https://prelude.dhall-lang.org/List/map
let indexed = https://prelude.dhall-lang.org/List/indexed
let length = https://prelude.dhall-lang.org/List/length
let generate = https://prelude.dhall-lang.org/List/generate
let concat = https://prelude.dhall-lang.org/List/concat
let partition = https://prelude.dhall-lang.org/List/partition
let naturalShow = https://prelude.dhall-lang.org/Natural/show
let lessThan = https://prelude.dhall-lang.org/Natural/lessThan
let greaterThanEqual = https://prelude.dhall-lang.org/Natural/greaterThanEqual
let subtract = https://prelude.dhall-lang.org/Natural/subtract
let and = https://prelude.dhall-lang.org/Bool/and

let singlesWithSparkLine =
    [ [ "sum(irate(prometheus_tsdb_head_samples_appended_total{job=\"prometheus\"}[5m]))" ]
    , [ "prometheus_tsdb_blocks_loaded{job=\"prometheus\"}" ]
    , [ "prometheus_tsdb_head_chunks{job=\"prometheus\"}" ]
    , [ "irate(prometheus_tsdb_head_gc_duration_seconds_count{job=\"prometheus\"}[5m])" ]
    ]

let graphPanels = 
    [ [ "topk(5, max(scrape_duration_seconds) by (job))" ]
    , [ "sum(process_resident_memory_bytes{job=\"prometheus\"})"
    , "process_virtual_memory_bytes{job=\"prometheus\"}" ]
    , [ "sum(prometheus_tsdb_head_active_appenders{job=\"prometheus\"})"
    , "sum(process_open_fds{job=\"prometheus\"})" ]
    , [ "histogram_quantile(0.99, sum(rate(prometheus_tsdb_compaction_duration_bucket{job=\"prometheus\"}[5m])) by (le))"
    , "irate(prometheus_tsdb_compactions_total{job=\"prometheus\"}[5m])"
    , "irate(prometheus_tsdb_compactions_failed_total{job=\"prometheus\"}[5m])"
    , "irate(prometheus_tsdb_compactions_triggered_total{job=\"prometheus\"}[5m])" ]
    , [ "rate(prometheus_tsdb_reloads_total{job=\"prometheus\"}[5m])"
    , "rate(prometheus_tsdb_reloads_failures_total{job=\"prometheus\"}[5m])" ]
    , [ "prometheus_engine_query_duration_seconds{job=\"prometheus\", quantile=\"0.99\"}" ]
    , [ "max(prometheus_rule_group_duration_seconds{job=\"prometheus\"}) by (quantile)" ]
    , [ "rate(prometheus_rule_group_iterations_missed_total{job=\"prometheus\"}[5m])" ]
    , [ "rate(prometheus_rule_group_iterations_total{job=\"prometheus\"}[5m])" ]
    ]

let makePrometheusExpressions =
    \(expressions : List Text)
    -> map
        { index : Natural, value : Text }
        Grafana.MetricsTargets
        (\(expr : { index : Natural, value : Text })
            -> Grafana.MetricsTargets.PrometheusTarget
                Grafana.PrometheusTarget::
                    { refId = "Expr " ++ (naturalShow expr.index)
                    , expr = expr.value
                    })
        (indexed Text expressions)

let makeSingleWithSparkLine =
    \(index : Natural)
    -> \(expr : List Text)
    -> \(dim : { y : Natural, w : Natural })
    -> Grafana.Panels.mkSinglestatPanel
            Grafana.SinglestatPanel::
                { title = "expr"
                , gridPos = Grafana.GridPos::{ x = index*dim.w, y = dim.y, w = dim.w, h = 4 }
                , sparkline =
                    { show = True
                    , full = True
                    , lineColor = "#5794F2"
                    , fillColor = "rgba(31, 96, 196, 0.35)"
                    }
                , targets = makePrometheusExpressions expr
                }

let IndexedChunk = { index : Natural, value : Natural }
let IndexedPanels = { index : Natural, value : Natural -> Grafana.Panels.Panels }

let makeGraphPanel =
    \(chunk : IndexedChunk)
    -> \(index : Natural)
    -> \(expressions : List Text)
    -> \(dim : { y : Natural, w : Natural })
    -> Grafana.Panels.mkGraphPanel
            Grafana.GraphPanel::
                { title = "expr"
                , gridPos = Grafana.GridPos::{ x = (subtract chunk.value index)*dim.w, y = dim.y, w = dim.w, h = 4 }
                , targets = makePrometheusExpressions expressions
                }

let panelChunks =
    \(l : Natural)
    -> \(n : Natural)
    -> indexed
        Natural
        (generate l Natural (\(x : Natural) -> x * n))

let graphPanels =
    \(chunk : IndexedChunk)
    -> \(dim : { y : Natural, w : Natural })
    -> map
        { index : Natural, value : List Text }
        (Natural -> Grafana.Panels.Panels)
        (\(expr : { index : Natural, value : List Text })
            -> makeGraphPanel chunk expr.index expr.value dim)
        (indexed (List Text) graphPanels)

let getPartition =
    \(chunk : IndexedChunk)
    -> (partition 
        IndexedPanels
        (\(panel : IndexedPanels)
            -> and [greaterThanEqual panel.index chunk.value, lessThan panel.index (chunk.value + 2)]
        )
        (indexed (Natural -> Grafana.Panels.Panels) (graphPanels chunk { y = 11 + chunk.value, w = 12 }))).true

in 

Grafana.Dashboard::{
    , title = "Prometheus Stats"
    , editable = True
    , panels = Grafana.Utils.generateIds
        ( concat (Natural -> Grafana.Panels.Panels)
            [ map
                { index : Natural, value : List Text }
                (Natural -> Grafana.Panels.Panels)
                (\(expr : { index : Natural, value : List Text })
                    -> makeSingleWithSparkLine expr.index expr.value { y = 0, w = 6 })
                (indexed (List Text) singlesWithSparkLine)
            , map
                { index : Natural, value : List Text }
                (Natural -> Grafana.Panels.Panels)
                (\(expr : { index : Natural, value : List Text })
                    -> makeSingleWithSparkLine expr.index expr.value { y = 5, w = 6 })
                (indexed (List Text) singlesWithSparkLine)
            , concat (Natural -> Grafana.Panels.Panels)
                (map
                    IndexedChunk
                    (List (Natural -> Grafana.Panels.Panels))
                    (\(chunk : IndexedChunk) -> 
                        map 
                            IndexedPanels
                            (Natural -> Grafana.Panels.Panels)
                            (\(panel : IndexedPanels)
                                -> panel.value
                            )
                            (getPartition chunk)
                    )
                    (panelChunks 6 2)
                )
            ]
        )
    , uid = Some "prometheus-stats"
    }

