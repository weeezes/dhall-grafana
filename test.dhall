let Grafana = ./package.dhall

let Panels = ./types/Panels.dhall
let TextPanel = ./types/TextPanel.dhall
let Base = ./types/Base.dhall

let graphPanel = ./defaults/GraphPanel.dhall
let singlestatPanel = ./defaults/SinglestatPanel.dhall

let MetricTarget = ./types/MetricTarget.dhall
let Dashboard = ./defaults/Dashboard.dhall
let Templating = (./types/TemplatingVariable.dhall).Types
let Variable = (./defaults/TemplatingVariable.dhall)
let Link = (./types/Link.dhall)

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
            , title = "This is a row"
            , gridPos = { x = 0, y = 4, w = 0, h = 0 }
            }

        )
    , Panels.mkTextPanel
        ( Grafana.TextPanel::
            { id = 0
            , title = "Markdown panel"
            , gridPos = { x = 0, y = 5, w = 12, h = 6 }
            , content = "# foo"
            , mode = TextPanel.Mode.markdown
            , type = TextPanel.PanelType.text
            }
        )
    , Panels.mkTextPanel
        ( Grafana.TextPanel::
            { id = 0
            , title = "Html panel"
            , gridPos = { x = 12, y = 5, w = 12, h = 6 }
            , content = "<h1>bar</h1>"
            , mode = TextPanel.Mode.html
            , type = TextPanel.PanelType.text
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
    , Variable.mkInterval
        "Interval"
        ["5s", "10s", "15s", "20s", "25s"]
    , Variable.mkDatasource
        "Datasource"
        "prometheus"
        ""
    , Variable.mkCustom
        "Custom"
        ["one", "two", "three", "four"]
    , Variable.mkConstant
        "Constant"
        "foobarbaz"
    , Variable.mkTextbox
        "Textbox"
        ''
        some textbox value
        ''
    , Variable.mkAdHoc
        "Adhoc"
        ([] : List { key : Text, operator : Text, value : Text })
    ]

let links =
    [ Link.Types.Dashboards
        ( Grafana.LinkDashboards::
            { tags = [ "prometheus" ]
            , title = "Dashboards"
            }
        )
    , Link.Types.Link
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
                (Base.generateIds panels)
            , editable = True
            , templating = { list = templateVariables }
            , links = links
            }

in
    dashboard
