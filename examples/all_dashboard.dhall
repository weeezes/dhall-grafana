let Grafana = ../package.dhall

let ScenarioId = Grafana.ScenarioId

let datasourceName = "Datasource"

let panels =
    [ Grafana.Panels.mkSinglestatPanel
        ( Grafana.SinglestatPanel::
            { title = "Singlestat panel"
            , gridPos = { x = 0, y = 0, w = 24, h = 3 }
            , colorBackground = True
            , datasource = Some ("$" ++ datasourceName)
            , targets =
                [ Grafana.MetricsTargets.TestDataDBTarget
                      { refId = "A"
                      , scenarioId = ScenarioId.random_walk
                      }
                ]
            }
        )
    , Grafana.Panels.mkRow
        ( Grafana.Row::
            { title = "This is the $Custom row"
            , gridPos = { x = 0, y = 4, w = 0, h = 0 }
            , repeat = Some "Custom"
            }

        )
    , Grafana.Panels.mkTextPanel
        ( Grafana.TextPanel::
            { title = "Markdown panel"
            , gridPos = { x = 0, y = 5, w = 12, h = 6 }
            , content =
                ''
                # foo

                $Custom
                ''
            , mode = Grafana.TextPanels.Mode.markdown
            }
        )
    , Grafana.Panels.mkTextPanel
        ( Grafana.TextPanel::
            { title = "Html panel"
            , gridPos = { x = 12, y = 5, w = 12, h = 6 }
            , content =
                ''
                <h1>bar</h1>
                <br>
                $Custom
                ''
            , mode = Grafana.TextPanels.Mode.html
            }
        )
    , Grafana.Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { title = "Temperature"
            , gridPos = { x = 0, y = 12, w = 24, h = 6 }
            , datasource = Some ("$" ++ datasourceName)
            , xaxis = Grafana.XAxis::{ name = Some "x-label" }
            , yaxes = [Grafana.YAxis::{ label = Some "temperature" }, Grafana.YAxis.default ]
            , targets =
                [ Grafana.MetricsTargets.TestDataDBTarget
                    { refId = "A"
                    , scenarioId = ScenarioId.random_walk
                    }
                ]
            }
        )
    ]

let templateVariables =
    [ Grafana.TemplatingVariableUtils.mkInterval
        "Interval"
        ["5s", "10s", "15s", "20s", "25s"]
        False
    , Grafana.TemplatingVariableUtils.mkQuery
        "Temperature"
        "label_values(hass_temperature_c, entity)"
        "Prometheus"
        False
    , (Grafana.TemplatingVariable.Types.QueryVariable) (../Grafana/package.dhall).TemplatingVariable.Query::{ name = "foo" }
    , Grafana.TemplatingVariableUtils.mkDatasource
        datasourceName
        "testdata"
        ""
        False
    , Grafana.TemplatingVariableUtils.mkCustom
        "Custom"
        ["1st", "2nd", "3rd"]
        False
    , Grafana.TemplatingVariableUtils.mkConstant
        "Constant"
        "foobarbaz"
        False
    , Grafana.TemplatingVariableUtils.mkTextbox
        "Textbox"
        ''
        some textbox value
        ''
        False
    , Grafana.TemplatingVariableUtils.mkAdHoc
        "Adhoc"
        ([] : List { key : Text, operator : Text, value : Text })
        False
    ]

let links =
    [ Grafana.Link.Type.Dashboards
        ( Grafana.LinkDashboards::
            { tags = [ "prometheus" ]
            , title = "Dashboards"
            }
        )
    , Grafana.Link.Type.Link
        ( Grafana.LinkExternal::
            { title = "Links"
            , url = "https://learnxinyminutes.com/docs/dhall/"
            , tooltip = "Learn Dhall"
            }
        )
    ]

let dashboard : Grafana.Dashboard.Type =
    Grafana.Dashboard::
        { title = "dhall-grafana sample"
        , uid = Some "dhall-grafana-sample"
        , panels =
            (Grafana.Utils.generateIds panels)
        , editable = True
        , templating = { list = templateVariables }
        , links = links
        }

in
    dashboard
