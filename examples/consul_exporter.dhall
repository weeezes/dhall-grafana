let Grafana = ../package.dhall

let ScenarioId = Grafana.ScenarioId

let test_dashboard : Optional ScenarioId = Some env:TEST_DASHBOARD ? None ScenarioId

let templateVariables =
    [ Grafana.TemplatingVariableUtils.mkDatasource
        "Datasource"
        "prometheus"
        ""
        False
    ]

let panels =
    [ Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Total Services"
            , gridPos = { x = 0, y = 0, w = 6, h = 6 }
            , legend = Grafana.Legend::{ show = False }
            , targets =
                [ Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "consul_catalog_services"
                        , scenarioId = test_dashboard
                        }
                ]
            , fill = 0
            , linewidth = 2
            }
        )
    , Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Peers and Leaders"
            , gridPos = { x = 6, y = 0, w = 6, h = 6 }
            , legend = Grafana.Legend::{ show = False }
            , targets =
                [ Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "consul_raft_peers"
                        , scenarioId = test_dashboard
                        }
                , Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "consul_raft_leader"
                        , scenarioId = test_dashboard
                        }
                , Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "consul_serf_lan_members"
                        , scenarioId = test_dashboard
                        }

                ]
            , fill = 0
            , linewidth = 2
            }
        )
    , Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Unhealthy Nodes"
            , gridPos = { x = 0, y = 6, w = 12, h = 6 }
            , legend = Grafana.Legend::{ rightSide = True }
            , targets =
                [ Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "consul_health_node_status{status!='passing'}"
                        , scenarioId = test_dashboard
                        , legendFormat = Some "{{ node }} - {{ status }}"
                        }
                ]
            , fill = 0
            , linewidth = 2
            , alert = Some (Grafana.Alerts.mkSimpleAlert
                "Unhealthy nodes"
                (None Text)
                0
                (None Grafana.Alerts.ConditionEvaluator)
                (None Grafana.Alerts.ExecutionErrorState)
                (Some Grafana.Alerts.NoDataState.alerting)
                )
            }
        )

    , Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Unhealthy Services"
            , gridPos = { x = 12, y = 0, w = 12, h = 12 }
            , legend = Grafana.Legend::{ rightSide = True }
            , targets =
                [ Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "sum by (service_name, status) (consul_health_service_status{status!=\"passing\"})"
                        , scenarioId = test_dashboard
                        , legendFormat = Some "{{ service_name }} - {{ status }}"
                        }
                ]
            , fill = 0
            , linewidth = 2
            , alert = Some (Grafana.Alerts.mkSimpleAlert
                "Unhealthy Services"
                (None Text)
                0
                (None Grafana.Alerts.ConditionEvaluator)
                (None Grafana.Alerts.ExecutionErrorState)
                (Some Grafana.Alerts.NoDataState.alerting)
                )
            }
        )

    , Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Services and checks"
            , gridPos = { x = 0, y = 12, w = 24, h = 12 }
            , legend = Grafana.Legend::{ rightSide = True }
            , targets =
                [ Grafana.MetricsTargets.PrometheusTarget
                    Grafana.PrometheusTarget::
                        { refId = "A"
                        , expr = "sum by (node,service_id,status) (consul_health_service_status)"
                        , scenarioId = test_dashboard
                        , legendFormat = Some "{{node}} - {{service_id}} - {{status}}"
                        }
                ]
            , fill = 0
            , linewidth = 2
            }
        )
    ]

let links =
    [ Grafana.Link.Type.Link
        ( Grafana.LinkExternal::
            { title = "consul_exporter in Github"
            , url = "https://github.com/prometheus/consul_exporter"
            , tooltip = "consul_exporter in Github"
            }
        )
    ]

let dashboard : Grafana.Dashboard.Type =
    Grafana.Dashboard::
        { title = "Consul exporter"
        , uid = Some "consul_exporter"
        , panels =
            (Grafana.Utils.generateIds panels)
        , editable = True
        , templating = { list = templateVariables }
        , links = links
        }

in
    dashboard
