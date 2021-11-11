let WIP = ../Grafana/package.dhall

let VariableType =
    < query
    | datasource
    | interval
    | custom
    | constant
    | adhoc
    | textbox >

let Option = { selected : Bool, text : Text, value : Text }
let Current = { text : Text, value : Text }

let TemplatingVariableBase = WIP.TemplatingVariable.Base.Type
let QueryVariable = WIP.TemplatingVariable.Query.Type

let IntervalVariable =
    TemplatingVariableBase //\\
    { query: Text
    , auto : Optional Bool
    , auto_count : Optional Natural
    , auto_min : Optional Text
    , options: List Option
    , current: Optional Current
    }

let DatasourceVariable =
    TemplatingVariableBase //\\
    { query : Text
    , includeAll : Bool
    , multi : Bool
    , regex: Text
    , options: List Option
    , current: Optional Current
    }

let CustomVariable =
    TemplatingVariableBase //\\
    { query: Text
    , allValue: Optional Text
    , includeAll: Bool
    , multi: Bool
    , options: List Option
    , current: Optional Current
    }

let ConstantVariable =
    TemplatingVariableBase //\\
    { query : Text
    , options: List Option
    , current: Optional Current
    }

let TextboxVariable =
    TemplatingVariableBase //\\
    { query : Text
    , options: List Option
    , current: Optional Current
    }

let AdHocVariable =
    TemplatingVariableBase //\\
    { filters : List { key : Text, operator : Text, value : Text}
    , datasource : Text
    }

let Types =
    < QueryVariable : QueryVariable
    | IntervalVariable : IntervalVariable
    | DatasourceVariable : DatasourceVariable
    | CustomVariable : CustomVariable
    | ConstantVariable : ConstantVariable
    | TextboxVariable : TextboxVariable
    | AdHocVariable : AdHocVariable
    >

in

{ Types = Types
, VariableType = VariableType
, Current
, Option
}
