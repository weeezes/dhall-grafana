let PrometheusTarget = ../types/PrometheusTarget.dhall

let ScenarioId = (../types/TestDataDBTarget.dhall).ScenarioId

in  { intervalFactor = 1
    , format = PrometheusTarget.FormatType.time_series
    , legendFormat = None Text
    , interval = None Natural
    , instant = False
    , scenarioId = None ScenarioId
    }
