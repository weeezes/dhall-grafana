let Base = (../Base/package.dhall).Type
let QueryVariable =
    Base //\\
    { query: Text
    , allValue: Optional Text
    , includeAll: Bool
    , multi: Bool
    , regex: Text
    , sort: Natural
    , refresh : Natural
    , options: List (../Option/package.dhall).Type
    , datasource: Text
    , current: Optional (../Current/package.dhall).Type
    , useTags: Bool
    }

in

QueryVariable