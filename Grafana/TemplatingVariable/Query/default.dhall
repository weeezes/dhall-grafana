{ allValue = None Text
, current = None { text : Text, value : Text }
, datasource = "Prometheus"
, hide = 0
, includeAll = True
, label = None Text
, description = None Text
, multi = True
, name = "query"
, options = [] : List { selected : Bool, text : Text, value : Text }
, query = "label_values(hass_temperature_c, entity)"
, refresh = 1
, regex = "/.*/"
, skipUrlSync = False
, sort = 1
, type = (../VariableType/package.dhall).query
, useTags = False
}
