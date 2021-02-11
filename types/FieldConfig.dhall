let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2

let ColorMode = < fixed | thresholds | absolute | percentage >
let MatcherID = < byName >
let MatcherOption = < status >

let Defaults =
    { color : { fixedColor : Text, mode : ColorMode }
    , custom : {}
    , mappings : List {}
    , thresholds : { mode : ColorMode, steps: List ({ color : Text, value : Optional Double }) }
    }

let Override =
    { matcher: { id: MatcherID, options: MatcherOption }
    , properties: List (Prelude.Map.Type Text Text)
    }

let FieldConfig =
    { defaults: Optional Defaults
    , overrides: List Override
    }

let mkDefaults =
    \(color : { fixedColor : Text, mode : ColorMode }) ->
    \(baseThresholdColor : Text ) ->
    \(thresholdColorMode : ColorMode) ->
    \(steps : List ({ color : Text, value : Double })) ->
        Some { color = color
        , custom = {=}
        , mappings = [] : List {}
        , thresholds =
            { mode = thresholdColorMode
            , steps =
                [ { color = baseThresholdColor, value = None Double } ]
                # (Prelude.List.map { color : Text, value : Double } { color : Text, value : Optional Double } (\(t : { color : Text, value : Double }) -> { color = t.color, value = Some t.value }) steps)
            }
        }

in

{ Type = FieldConfig
, ColorMode = ColorMode
, MatcherID = MatcherID
, MatcherOption = MatcherOption
, Defaults = Defaults
, Override = Override
, mkDefaults
}