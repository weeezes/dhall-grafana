let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let boolFold = Prelude.Bool.fold

let map = Prelude.List.map

let concatSep = Prelude.Text.concatSep

let TemplatingVariable = (../types/TemplatingVariable.dhall)
let Templating = (../types/TemplatingVariable.dhall).Types

let VariableType = (../types/TemplatingVariable.dhall).VariableType

let hide = λ(hide : Bool) → boolFold hide Natural 2 0

let queryValue =
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
      , type = VariableType.query
      , useTags = False
      }

let QueryVariable = Templating.QueryVariable queryValue

let mkQuery =
      λ(name : Text) →
      λ(query : Text) →
      λ(datasource : Text) →
      λ(_hide : Bool) →
        Templating.QueryVariable
          (queryValue ⫽ { name, query, datasource, hide = hide _hide })

let intervalValue =
      { auto = None Bool
      , auto_count = None Natural
      , auto_min = None Text
      , current = None { text : Text, value : Text }
      , hide = 0
      , label = None Text
      , description = None Text
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
      λ(name : Text) →
      λ(options : List Text) →
      λ(_hide : Bool) →
        let opt =
              map
                Text
                { selected : Bool, text : Text, value : Text }
                (λ(o : Text) → { selected = False, text = o, value = o })
                options

        in  Templating.IntervalVariable
              (   intervalValue
                ⫽ { name
                  , options = opt
                  , query = concatSep "," options
                  , hide = hide _hide
                  }
              )

let datasourceValue =
      { includeAll = False
      , multi = False
      , regex = ""
      , current = None { text : Text, value : Text }
      , options = [] : List { selected : Bool, text : Text, value : Text }
      , query = "prometheus"
      , hide = 0
      , label = None Text
      , description = None Text
      , name = "datasource"
      , skipUrlSync = False
      , type = VariableType.datasource
      }

let DatasourceVariable = Templating.DatasourceVariable datasourceValue

let mkDatasource =
      λ(name : Text) →
      λ(query : Text) →
      λ(regex : Text) →
      λ(_hide : Bool) →
        Templating.DatasourceVariable
          (datasourceValue ⫽ { name, query, regex, hide = hide _hide })

let customValue =
      { allValue = None Text
      , current = None { text : Text, value : Text }
      , hide = 0
      , includeAll = True
      , label = None Text
      , description = None Text
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
      λ(name : Text) →
      λ(options : List Text) →
      λ(_hide : Bool) →
        let opt =
              map
                Text
                { selected : Bool, text : Text, value : Text }
                (λ(o : Text) → { selected = False, text = o, value = o })
                options

        in  Templating.CustomVariable
              (   customValue
                ⫽ { name
                  , options = opt
                  , query = concatSep "," options
                  , hide = hide _hide
                  }
              )

let constantValue =
      { current = None { text : Text, value : Text }
      , hide = 0
      , label = None Text
      , description = None Text
      , name = "constant"
      , options = [ { selected = True, text = "9999", value = "9999" } ]
      , query = "9999"
      , skipUrlSync = False
      , type = VariableType.constant
      }

let ConstantVariable = Templating.ConstantVariable constantValue

let mkConstant =
      λ(name : Text) →
      λ(value : Text) →
      λ(_hide : Bool) →
        Templating.ConstantVariable
          (   constantValue
            ⫽ { name
              , query = value
              , options = [ { selected = True, text = value, value } ]
              , hide = hide _hide
              }
          )

let textboxValue =
      { current = None { text : Text, value : Text }
      , hide = 0
      , label = None Text
      , description = None Text
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
      λ(name : Text) →
      λ(value : Text) →
      λ(_hide : Bool) →
        Templating.TextboxVariable
          (   textboxValue
            ⫽ { name
              , query = value
              , current = Some { text = name, value }
              , hide = hide _hide
              }
          )

let adHocValue =
      { hide = 0
      , label = None Text
      , description = None Text
      , name = "adhoc"
      , skipUrlSync = False
      , type = VariableType.adhoc
      , datasource = "Prometheus"
      , filters = [ { key = "friendly_name", operator = "=", value = "masti" } ]
      }

let AdHocVariable = Templating.AdHocVariable adHocValue

let mkAdHoc =
      λ(name : Text) →
      λ(filters : List { key : Text, operator : Text, value : Text }) →
      λ(_hide : Bool) →
        Templating.AdHocVariable
          (adHocValue ⫽ { name, filters, hide = hide _hide })

in
{ QueryVariable =
      { Type = TemplatingVariable.QueryVariable
      , default = queryValue
      }
, mkQuery
, IntervalVariable =
      { Type = TemplatingVariable.IntervalVariable
      , default = intervalValue
      }
, mkInterval
, DatasourceVariable =
      { Type = TemplatingVariable.DatasourceVariable
      , default = datasourceValue
      }
, mkDatasource
, CustomVariable =
      { Type = TemplatingVariable.CustomVariable
      , default = customValue
      }
, mkCustom
, ConstantVariable =
      { Type = TemplatingVariable.ConstantVariable
      , default = constantValue
      }
, mkConstant
, TextboxVariable =
      { Type = TemplatingVariable.TextboxVariable
      , default = textboxValue
      }
, mkTextbox
, AdHocVariable =
      { Type = TemplatingVariable.AdHocVariable
      , default = adHocValue
      }
, mkAdHoc
, hide
}
