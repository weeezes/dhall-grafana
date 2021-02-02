let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2

let Transformations = ../types/Transformations.dhall
let Organize =
    { id  = "organize"
    , options =
        { excludeByName = Prelude.Map.empty Text Bool
        , indexByName = Prelude.Map.empty Text Bool
        , renameByName = Prelude.Map.empty Text Bool
        }
    }

in

{ Organize = Organize }