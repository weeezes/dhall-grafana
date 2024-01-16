{ Utils = ./types/Utils.dhall
, Dashboard =
    { default = ./defaults/Dashboard.dhall
    , Type = (./types/Dashboard.dhall).Type
    }
, TimePicker =
    { default = ./defaults/TimePicker.dhall
    , Type = (./types/TimePicker.dhall).Type
    }
, SinglestatPanel =
    { default = ./defaults/SinglestatPanel.dhall
    , Type = (./types/SinglestatPanel.dhall).Type
    }
, StatPanelOptions =
    ./types/StatPanelOptions.dhall //
    { default = ./defaults/StatPanelOptions.dhall }
, StatPanel =
    { default = (./defaults/StatPanel.dhall).StatPanel
    , Type = (./types/StatPanel.dhall).Type
    , PanelType = (./types/StatPanel.dhall).PanelType
    }
, StatPanels = ./types/StatPanel.dhall
, TextPanel =
    { default = ./defaults/TextPanel.dhall
    , Type = (./types/TextPanel.dhall).Type
    }
, TextPanels = (./types/TextPanel.dhall)
, GraphPanel =
    { default = ./defaults/GraphPanel.dhall
    , Type = (./types/GraphPanel.dhall).Type
    }
, TablePanel =
    { default = ./defaults/TablePanel.dhall
    , Type = (./types/TablePanel.dhall).Type
    }
, PrometheusTarget =
    { default = ./defaults/PrometheusTarget.dhall
    , Type = (./types/PrometheusTarget.dhall).Type
    }
, InfluxTarget =
    { default = ./defaults/InfluxTarget.dhall
    , Type = (./types/InfluxTarget.dhall).Type
    }
, TestDataDBTarget =
    { default = ./defaults/TestDataDBTarget.dhall
    , Type = (./types/TestDataDBTarget.dhall).Type
    }
, Link =
    { default = (./types/Link.dhall).Types.Link
    , Type = (./types/Link.dhall).Types
    }
, LinkExternal =
    { default = (./defaults/Link.dhall).LinkExternal
    , Type = (./types/Link.dhall).Link
    }
, LinkDashboards =
    { default = (./defaults/Link.dhall).LinkDashboards
    , Type = (./types/Link.dhall).Dashboards
    }
, Legend =
    { default = (./defaults/Legend.dhall)
    , Type = ./types/Legend.dhall
    }
, Row =
    { default = ./defaults/Row.dhall
    , Type = (./types/Row.dhall).Type
    }
, GridPos =
    { default = ./defaults/GridPos.dhall
    , Type = ./types/GridPos.dhall
    }
, Timezone = (./types/Dashboard.dhall).Timezone
, Transformations =
    { default = (./types/Transformations.dhall).Types.Organize
    , Type = (./types/Transformations.dhall).Types
    }
, TransformationOrganize =
    { default = (./defaults/Transformations.dhall).Organize
    , Type = (./types/Transformations.dhall).Organize
    }
, Panels = ./types/Panels.dhall
, MetricsTargets = ./types/MetricTargets.dhall
, RawQueryTarget =
    { default = ./defaults/RawQueryTarget.dhall
    , Type = (./types/RawQueryTarget.dhall).Type
    }
, ScenarioId = (./types/TestDataDBTarget.dhall).ScenarioId
, TemplatingVariable = ./types/TemplatingVariable.dhall
, TemplatingVariableUtils = ./defaults/TemplatingVariable.dhall
, PrometheusTargetFormat = (./types/PrometheusTarget.dhall).FormatType
, Alert =
    { default = (./defaults/Alert.dhall)
    , Type = (./types/Alert.dhall).Type
    }
, Alerts = ./types/Alert.dhall
, FieldConfig =
    { default = (./defaults/FieldConfig.dhall).NullFieldConfig
    , Type = (./types/FieldConfig.dhall).Type
    , Override = (./types/FieldConfig.dhall).Override
    }
, FieldConfigs = ./types/FieldConfig.dhall
, XAxis = ./types/XAxis.dhall // { default = ./defaults/XAxis.dhall }
, YAxis = ./types/YAxis.dhall // { default = ./defaults/YAxis.dhall }
}
