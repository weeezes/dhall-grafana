let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2

let FieldConfig = ../types/FieldConfig.dhall

let NullFieldConfig =
    { defaults = None FieldConfig.Defaults
    , overrides = [] : List FieldConfig.Override
    }


in
{ NullFieldConfig
}