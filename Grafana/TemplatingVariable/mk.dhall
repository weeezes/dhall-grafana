let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let boolFold = Prelude.Bool.fold

let hide = λ(hide : Bool) → boolFold hide Natural 2 0

let Query = ./Query/package.dhall
let Types = ./Type.dhall

let _mkQuery =
      λ(name : Text) →
      λ(query : Text) →
      λ(datasource : Text) →
      λ(_hide : Bool) →
        Query::{ name = name, query = query, datasource = datasource, hide = hide _hide }

in

{ _query = _mkQuery
}
