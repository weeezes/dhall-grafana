let Link = ../types/Link.dhall
let LinkDashboards : Link.Dashboards =
    { icon = "external link"
    , includeVars = False
    , keepTime = False
    , tags = [ ] : List Text
    , targetBlank = True 
    , title = "Dashboards" 
    , type = Link.LinkType.dashboards
    , asDropdown =  True
    }
let LinkExternal : Link.Link =
    { icon = "external link"
    , includeVars = False
    , keepTime = False
    , tags = [ ] : List Text
    , targetBlank = True 
    , title = "External" 
    , type = Link.LinkType.link
    , url = ""
    , tooltip = "External"
    }

in

{ LinkDashboards = LinkDashboards
, LinkExternal = LinkExternal 
}