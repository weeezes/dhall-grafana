let Panels = ./types/Panels.dhall
let TextPanel = ./types/TextPanel.dhall
let Base = ./types/Base.dhall

let graphPanel = ./defaults/GraphPanel.dhall
let singlestatPanel = ./defaults/SinglestatPanel.dhall

let MetricTarget = ./types/MetricTarget.dhall
let Dashboard = ./defaults/Dashboard.dhall
let Templating = (./types/TemplatingVariable.dhall).Types
let TemplatingDefaults = (./defaults/TemplatingVariable.dhall)
let Link = (./types/Link.dhall)

let panels =
    [ Panels.mkSinglestatPanel
        ( singlestatPanel //
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
    , Panels.mkTextPanel
        { id = 0
        , title = "Markdown panel"
        , gridPos = { x = 0, y = 3, w = 12, h = 6 }
        , content = "# foo"
        , mode = TextPanel.Mode.markdown
        , type = TextPanel.PanelType.text
        }
    , Panels.mkTextPanel
        { id = 0
        , title = "Html panel"
        , gridPos = { x = 12, y = 3, w = 12, h = 6 }
        , content = "<h1>bar</h1>"
        , mode = TextPanel.Mode.html
        , type = TextPanel.PanelType.text
        }
    , Panels.mkGraphPanel
        ( graphPanel //
            { id = 0
            , title = "Graphy"
            , gridPos = { x = 0, y = 10, w = 24, h = 6 }
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

    let dashboard  : (./types/Dashboard.dhall).Type = 
        Dashboard // 
        { panels = 
            (Base.generateIds panels)
        , editable = True
        , templating = 
            { list = 
                [ TemplatingDefaults.mkQueryVariable "Temperature" "label_values(hass_temperature_c, entity)" "Prometheus"
                , TemplatingDefaults.mkIntervalVariable "Interval" ["5s", "10s", "15s", "20s", "25s"]
                , TemplatingDefaults.mkDatasourceVariable "Datasource" "prometheus" ""
                , TemplatingDefaults.mkCustomVariable "Custom" ["one", "two", "three", "four"]
                , TemplatingDefaults.mkConstantVariable "Constant" "foobarbaz"
                , TemplatingDefaults.mkTextboxVariable "Textbox"
                    ''
                    some textbox value
                    ''
                , TemplatingDefaults.mkAdHocVariable "Adhoc" ([] : List { key : Text, operator : Text, value : Text })
                ]
            }
        , links = 
            [ Link.Types.Dashboards
                { icon = "external link"
                , includeVars = False
                , keepTime = False
                , tags = [ "prometheus" ]
                , targetBlank = True 
                , title = "Dashboards" 
                , type = Link.LinkType.dashboards
                , asDropdown =  True
                }
            , Link.Types.Link
                { icon = "external link"
                , includeVars = False
                , keepTime = False
                , tags = [ ] : List Text
                , targetBlank = True 
                , title = "Links" 
                , type = Link.LinkType.link
                , url = "https://learnxinyminutes.com/docs/dhall/"
                , tooltip = "Learn Dhall"
                }
            ]
        }
in
    dashboard
