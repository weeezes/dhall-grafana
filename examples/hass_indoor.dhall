let Grafana = ../package.dhall

let ScenarioId = Grafana.ScenarioId

let test_dashboard
    : Optional ScenarioId
    = Some env:TEST_DASHBOARD ? None ScenarioId

let templateVariables =
      [ Grafana.TemplatingVariableUtils.mkDatasource
          "Datasource"
          "prometheus"
          ""
          False
      , Grafana.TemplatingVariableUtils.mkQuery
          "temperatures"
          "label_values(hass_temperature_c, friendly_name)"
          "\$Datasource"
          True
      , Grafana.TemplatingVariableUtils.mkQuery
          "switches"
          "label_values(hass_switch_state, friendly_name)"
          "\$Datasource"
          True
      ]

let panels =
      [ Grafana.Panels.mkSinglestatPanel
          Grafana.SinglestatPanel::{
          , title = "\$temperatures"
          , repeat = Some "temperatures"
          , maxPerRow = Some 12
          , gridPos = { x = 0, y = 0, w = 3, h = 3 }
          , postfix = "°C"
          , targets =
            [ Grafana.MetricsTargets.PrometheusTarget
                Grafana.PrometheusTarget::{
                , refId = "A"
                , expr =
                    ''
                    sum(hass_temperature_c{friendly_name="$temperatures"})
                    ''
                , scenarioId = test_dashboard
                }
            ]
          }
      , Grafana.Panels.mkGraphPanel
          Grafana.GraphPanel::{
          , title = "Temperature"
          , gridPos = { x = 0, y = 12, w = 24, h = 6 }
          , legend = Grafana.Legend::{ rightSide = True }
          , targets =
            [ Grafana.MetricsTargets.PrometheusTarget
                Grafana.PrometheusTarget::{
                , refId = "A"
                , expr = "sum(hass_temperature_c{}) by (friendly_name)"
                , scenarioId = test_dashboard
                }
            ]
          , fill = 0
          , linewidth = 2
          }
      , Grafana.Panels.mkGraphPanel
          Grafana.GraphPanel::{
          , title = "Humidity"
          , gridPos = { x = 0, y = 12, w = 24, h = 6 }
          , legend = Grafana.Legend::{ rightSide = True }
          , targets =
            [ Grafana.MetricsTargets.PrometheusTarget
                Grafana.PrometheusTarget::{
                , refId = "A"
                , expr = "sum(hass_humidity_percent{}) by (friendly_name)"
                , scenarioId = test_dashboard
                }
            ]
          , fill = 0
          , linewidth = 2
          }
      , Grafana.Panels.mkSinglestatPanel
          Grafana.SinglestatPanel::{
          , repeat = Some "switches"
          , maxPerRow = Some 12
          , title = "\$switches"
          , gridPos = { x = 0, y = 19, w = 3, h = 3 }
          , targets =
            [ Grafana.MetricsTargets.PrometheusTarget
                Grafana.PrometheusTarget::{
                , refId = "A"
                , expr =
                    ''
                    sum(hass_switch_state{friendly_name="$switches"}) by (friendly_name)
                    ''
                , scenarioId = test_dashboard
                }
            ]
          , sparkline =
            { show = True
            , full = True
            , lineColor = "rgb(31, 120, 193)"
            , fillColor = "rgba(31, 118, 189, 0.18)"
            }
          }
      ]

let links =
      [ Grafana.Link.Type.Link
          Grafana.LinkExternal::{
          , title = "Home Assistant"
          , url = "https://www.home-assistant.io/"
          , tooltip = "Home Assistant"
          }
      ]

let dashboard
    : Grafana.Dashboard.Type
    = Grafana.Dashboard::{
      , title = "Hass indoor air"
      , uid = Some "hass-indoor-air"
      , panels = Grafana.Utils.generateIds panels
      , editable = True
      , templating.list = templateVariables
      , links
      }

in  dashboard
