let map = https://prelude.dhall-lang.org/List/map
let concatSep = https://prelude.dhall-lang.org/Text/concatSep

let Templating = (../types/TemplatingVariable.dhall).Types
let VariableType = (../types/TemplatingVariable.dhall).VariableType 

let queryValue =
    { allValue = None Text
    , current = None { text : Text, value : Text }
    , datasource = "Prometheus"
    , hide = 0
    , includeAll = True
    , label = None Text
    , multi = True
    , name = "query"
    , options = [] : List { selected : Bool, text : Text, value : Text }
    , query = "label_values(hass_temperature_c, entity)"
    , refresh = 1
    , regex = "/.*/"
    , skipUrlSync = False
    , sort = 1
    , type = VariableType.query
    , useTags = False
    }

let QueryVariable = Templating.QueryVariable queryValue

let mkQuery =
    \(name : Text)
    -> \(query : Text)
    -> \(datasource : Text) 
    -> Templating.QueryVariable
        (queryValue // { name = name, query = query, datasource = datasource })

let intervalValue =
    { auto = None Bool
    , auto_count = None Natural 
    , auto_min = None Text
    , current = None { text : Text, value : Text }
    , hide = 0
    , label = None Text
    , name = "interval"
    , options =
        [ { selected = True, text = "5s", value = "5s" }
        , { selected = False, text = "10s", value = "10s" }
        , { selected = False, text = "15s", value = "15s" }
        , { selected = False, text = "20s", value = "20s" }
        ]
    , query = "5s,10s,15s,20s"
    , skipUrlSync = False
    , type = VariableType.interval
    }

let IntervalVariable = Templating.IntervalVariable intervalValue

let mkInterval =
    \(name : Text)
    -> \(options : List Text)
    ->  let opt = 
            map
                Text
                { selected : Bool, text : Text, value : Text }
                (\(o : Text) -> { selected = False, text = o, value = o })
                options
        in
            Templating.IntervalVariable
                (intervalValue // { name = name, options = opt, query = concatSep "," options })

let datasourceValue =
    { includeAll = False
    , multi = False
    , regex = ""
    , current = None { text : Text, value : Text }
    , options = [] : List { selected : Bool, text : Text, value : Text }
    , query = "prometheus"
    , hide = 0
    , label = None Text
    , name = "datasource"
    , skipUrlSync = False
    , type = VariableType.datasource
    }

let DatasourceVariable = Templating.DatasourceVariable datasourceValue

let  mkDatasource =
    \(name : Text)
    -> \(query : Text)
    -> \(regex : Text)
    -> Templating.DatasourceVariable
        (datasourceValue // ({ name = name, query = query, regex = regex }))

let customValue =
    { allValue = None Text
    , current = None { text : Text, value : Text }
    , hide = 0
    , includeAll = True
    , label = None Text
    , multi = True
    , name = "custom"
    , options =
        [ { selected = True, text = "6", value = "6" }
        , { selected = False, text = "7", value = "7" }
        , { selected = False, text = "8", value = "8" }
        , { selected = False, text = "9", value = "9" }
        , { selected = False, text = "10", value = "10" }
        ]
    , query = "6,7,8,9"
    , skipUrlSync = False
    , type = VariableType.custom
    }

let CustomVariable = Templating.CustomVariable customValue

let mkCustom =
    \(name : Text)
    -> \(options : List Text)
    ->  let opt = 
            map
                Text
                { selected : Bool, text : Text, value : Text }
                (\(o : Text) -> { selected = False, text = o, value = o })
                options
        in
            Templating.CustomVariable (customValue // { name = name, options = opt, query = concatSep "," options })

let constantValue =
    { current = None { text : Text, value : Text }
    , hide = 0
    , label = None Text
    , name = "constant"
    , options =
        [ { selected = True, text = "9999", value = "9999" }]
    , query = "9999"
    , skipUrlSync = False
    , type = VariableType.constant
    }

let ConstantVariable = Templating.ConstantVariable constantValue

let mkConstant =
    \(name : Text)
    -> \(value : Text)
    -> Templating.ConstantVariable (constantValue // { name = name, query = value, options = [{ selected = True, text = value, value = value }]})

let textboxValue =
    { current = None { text : Text, value : Text }
    , hide = 0
    , label = None Text
    , name = "textbox"
    , options = [] : List { selected : Bool, text : Text, value : Text }
    , query =
        ''
        Textbox value,
            multi-line
        ''
    , skipUrlSync = False
    , type = VariableType.textbox
    }

let TextboxVariable = Templating.TextboxVariable textboxValue

let mkTextbox =
    \(name : Text)
    -> \(value : Text)
    -> Templating.TextboxVariable (textboxValue // { name = name, query = value })

let adHocValue =
    { hide = 0
    , label = None Text
    , name = "adhoc"
    , skipUrlSync = False
    , type = VariableType.adhoc
    , datasource = "Prometheus"
    , filters = 
        [   { key = "friendly_name"
            , operator = "="
            , value = "masti"
            }
        ]
    }

let AdHocVariable = Templating.AdHocVariable adHocValue

let mkAdHoc =
    \(name : Text)
    -> \(filters : List { key : Text, operator : Text, value : Text })
    -> Templating.AdHocVariable (adHocValue // { name = name, filters = filters })

in

{ QueryVariable = QueryVariable
, mkQuery = mkQuery
, IntervalVariable = IntervalVariable
, mkInterval = mkInterval
, DatasourceVariable = DatasourceVariable
, mkDatasource = mkDatasource
, CustomVariable = CustomVariable
, mkCustom = mkCustom
, ConstantVariable = ConstantVariable
, mkConstant = mkConstant
, TextboxVariable = TextboxVariable
, mkTextbox = mkTextbox
, AdHocVariable = AdHocVariable
, mkAdHoc = mkAdHoc
}