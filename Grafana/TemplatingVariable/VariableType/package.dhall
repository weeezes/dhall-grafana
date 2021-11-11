let type = ./Type.dhall
in
{ Type = type
, default = ./default.dhall
, query = type.query
, datasource = type.datasource
, interval = type.interval
, custom = type.custom
, constant = type.constant
, adhoc = type.adhoc
, textbox = type.textbox
}