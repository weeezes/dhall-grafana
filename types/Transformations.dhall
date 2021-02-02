let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2

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