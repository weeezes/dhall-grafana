let Grafana = ./package.dhall

let Panels = ./types/Panels.dhall
let TextPanelMode = (./types/TextPanel.dhall).Mode

let MetricTarget = ./types/MetricTarget.dhall
let Variable = (./defaults/TemplatingVariable.dhall)

let panels =
    [ Panels.mkSinglestatPanel
        ( Grafana.SinglestatPanel::
            { id = 0
            , title = "Singlestat panel"
            , gridPos = { x = 0, y = 0, w = 24, h = 3 }
            , colorBackground = True
            , targets =
                [   { refId = "A"
                    , expr = "sum(hass_temperature_c)"
                    , intervalFactor = 1
                    , format = MetricTarget.FormatType.time_series
                    , legendFormat = None Text
                    , interval = None Natural
                    , instant = False
                    }
                ]
            }
        )
    , Panels.mkRow
        ( Grafana.Row::
            { id = 0
            , title = "This is a row $Temperature"
            , gridPos = { x = 0, y = 4, w = 0, h = 0 }
            , repeat = Some "Temperature"
            }

        )
    , Panels.mkTextPanel
        ( Grafana.TextPanel::
            { id = 0
            , title = "Markdown panel"
            , gridPos = { x = 0, y = 5, w = 12, h = 6 }
            , content = "# foo"
            , mode = TextPanelMode.markdown
            }
        )
    , Panels.mkTextPanel
        ( Grafana.TextPanel::
            { id = 0
            , title = "Html panel"
            , gridPos = { x = 12, y = 5, w = 12, h = 6 }
            , content = "<h1>bar</h1>"
            , mode = TextPanelMode.html
            }
        )
    , Panels.mkGraphPanel
        ( Grafana.GraphPanel::
            { id = 0
            , title = "Temperature"
            , gridPos = { x = 0, y = 12, w = 24, h = 6 }
            , targets =
                [ { refId = "A"
                  , expr = "hass_temperature_c"
                  , intervalFactor = 1
                  , format = MetricTarget.FormatType.time_series
                  , legendFormat = Some "{{ friendly_name }}"
                  , interval = None Natural
                  , instant = False
                  }
                ]
            }
        )
    ]

let templateVariables =
    [ Variable.mkQuery
        "Temperature"
        "label_values(hass_temperature_c, entity)"
        "Prometheus"
        False
    , Variable.mkInterval
        "Interval"
        ["5s", "10s", "15s", "20s", "25s"]
        False
    , Variable.mkDatasource
        "Datasource"
        "prometheus"
        ""
        False
    , Variable.mkCustom
        "Custom"
        ["one", "two", "three", "four"]
        False
    , Variable.mkConstant
        "Constant"
        "foobarbaz"
        False
    , Variable.mkTextbox
        "Textbox"
        ''
        some textbox value
        ''
        False
    , Variable.mkAdHoc
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
            { panels =
                (Grafana.Base.generateIds panels)
            , editable = True
            , templating = { list = templateVariables }
            , links = links
            }

in
    dashboard
