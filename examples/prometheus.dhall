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

let IndexedChunk = { index : Natural, value : Natural }
let IndexedPanels = { index : Natural, value : Natural -> Grafana.Panels.Panels }
let ChunkSpec = { chunks : Natural, perChunk : Natural }
let PartialGridPos = { y : Natural, w : Natural, h : Natural }

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
    \(chunk : IndexedChunk)
    -> \(index : Natural)
    -> \(expr : List Text)
    -> \(dim : PartialGridPos)
    -> Grafana.Panels.mkSinglestatPanel
            Grafana.SinglestatPanel::
                { title = "expr"
                , gridPos = Grafana.GridPos::{ x = (subtract chunk.value index)*dim.w, y = dim.y, w = dim.w, h = dim.h }
                , sparkline =
                    { show = True
                    , full = True
                    , lineColor = "#5794F2"
                    , fillColor = "rgba(31, 96, 196, 0.35)"
                    }
                , targets = makePrometheusExpressions expr
                }

let makeGraphPanel =
    \(chunk : IndexedChunk)
    -> \(index : Natural)
    -> \(expressions : List Text)
    -> \(dim : PartialGridPos)
    -> Grafana.Panels.mkGraphPanel
            Grafana.GraphPanel::
                { title = "expr"
                , gridPos = Grafana.GridPos::{ x = (subtract chunk.value index)*dim.w, y = dim.y, w = dim.w, h = dim.h }
                , targets = makePrometheusExpressions expressions
                }

let generateChunks =
    \(chunkSpec : ChunkSpec)
    -> indexed
        Natural
        (generate chunkSpec.chunks Natural (\(x : Natural) -> x * chunkSpec.perChunk))

let graphPanels =
    \(chunk : IndexedChunk)
    -> \(dim : PartialGridPos)
    -> map
        { index : Natural, value : List Text }
        (Natural -> Grafana.Panels.Panels)
        (\(expr : { index : Natural, value : List Text })
            -> makeGraphPanel chunk expr.index expr.value dim)
        (indexed (List Text) graphPanels)

let getPartition =
    \(chunkSpec : ChunkSpec)
    -> \(chunk : IndexedChunk)
    -> \(dim : PartialGridPos)
    -> \(panelGenerator : IndexedChunk -> PartialGridPos -> List (Natural -> Grafana.Panels.Panels))
    -> (partition
        IndexedPanels
        (\(panel : IndexedPanels)
            -> and [greaterThanEqual panel.index chunk.value, lessThan panel.index (chunk.value + chunkSpec.perChunk)]
        )
        (indexed (Natural -> Grafana.Panels.Panels) (panelGenerator chunk { y = dim.y + chunk.value, w = dim.w, h = dim.h }))).true

let magic =
    \(chunkSpec : ChunkSpec)
    -> \(dim : PartialGridPos)
    -> \(panelGenerator : IndexedChunk -> PartialGridPos -> List (Natural -> Grafana.Panels.Panels))
    -> concat (Natural -> Grafana.Panels.Panels)
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
                    (getPartition chunkSpec chunk dim panelGenerator)
            )
            (generateChunks chunkSpec)
        )
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
                    -> makeSingleWithSparkLine { index = 0, value = 0 } expr.index expr.value { y = 0, w = 6, h = 4 })
                (indexed (List Text) singlesWithSparkLine)
            , map
                { index : Natural, value : List Text }
                (Natural -> Grafana.Panels.Panels)
                (\(expr : { index : Natural, value : List Text })
                    -> makeSingleWithSparkLine { index = 0, value = 0 } expr.index expr.value { y = 5, w = 6, h = 4 })
                (indexed (List Text) singlesWithSparkLine)
            , magic { chunks = 6, perChunk = 4 } { y = 11, w = 6, h = 4 } graphPanels
            , magic { chunks = 6, perChunk = 2 } { y = 40, w = 12, h = 4 } graphPanels
            ]
        )
    , uid = Some "prometheus-stats"
    }

