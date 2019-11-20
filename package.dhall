{ Utils = ./types/Utils.dhall
, Dashboard =
    { default = ./defaults/Dashboard.dhall
    , Type = (./types/Dashboard.dhall).Type
    }
, SinglestatPanel =
    { default = ./defaults/SinglestatPanel.dhall
    , Type = (./types/SinglestatPanel.dhall).Type
    }
, TextPanel =
    { default = ./defaults/TextPanel.dhall
    , Type = (./types/TextPanel.dhall).Type
    }
, GraphPanel =
    { default = ./defaults/GraphPanel.dhall
    , Type = (./types/GraphPanel.dhall).Type
    }
, PrometheusTarget =
    { default = ./defaults/PrometheusTarget.dhall
    , Type = (./types/PrometheusTarget.dhall).Type
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
, Panels = ./types/Panels.dhall
}