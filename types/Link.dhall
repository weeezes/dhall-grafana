let LinkType = < link | dashboards >

let Dashboards =
    { asDropdown : Bool
    , icon : Text
    , includeVars : Bool
    , keepTime : Bool
    , tags : List Text
    , targetBlank : Bool
    , title : Text
    , type : LinkType
    }

let Link =
    { icon : Text
    , includeVars : Bool
    , keepTime : Bool
    , tags : List Text
    , targetBlank : Bool
    , title : Text
    , tooltip : Text
    , type : LinkType
    , url : Text
    }

let Types = < Link : Link | Dashboards : Dashboards >

in

{ Types = Types
, Dashboards = Dashboards
, Link = Link
, LinkType = LinkType
}