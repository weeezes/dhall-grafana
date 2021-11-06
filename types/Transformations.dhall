let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let Organize =
    { id : Text
    , options:
        { excludeByName : Prelude.Map.Type Text Bool
        , indexByName : Prelude.Map.Type Text Natural
        , renameByName : Prelude.Map.Type Text Text
        }
    }

let Types = < Organize : Organize >

in

{ Types = Types
, Organize = Organize
}