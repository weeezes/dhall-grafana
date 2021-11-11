let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let ColorMode = < fixed | thresholds | absolute | percentage >
let MatcherID = < byName >
let MatcherOption = < status >

let CustomFieldConfig
    : Type
    = { axisLabel : Text
      , axisPlacement : Text
      , barAlignment : Text
      , drawStyle : Text
      , fillOpacity : Natural
      , gradientMode : Text
      , hideFrom : { legend : Bool, tooltip : Bool, viz : Bool }
      , lineInterpolation : Text
      , lineWidth : Natural
      , pointSize : Natural
      , scaleDistribution : { type : Text }
      , showPoints : Text
      , spanNulls : Bool
      , stacking : { group : Text, mode : Text }
      , thresholdsStyle : { mode : Text }
      }

let defaultCustomFieldConfig
    : CustomFieldConfig
    = { axisLabel = ""
      , axisPlacement = "auto"
      , barAlignment = "line"
      , drawStyle = "line"
      , fillOpacity = 0
      , gradientMode = "none"
      , hideFrom = { legend = False, tooltip = False, viz = False }
      , lineInterpolation = "linear"
      , lineWidth = 1
      , pointSize = 5
      , scaleDistribution.type = "linear"
      , showPoints = "auto"
      , spanNulls = False
      , stacking = { group = "A", mode = "none" }
      , thresholdsStyle.mode = "off"
      }

let Custom
    : Type
    = < empty : {} | custom : CustomFieldConfig >

let Defaults =
    { color : { fixedColor : Text, mode : ColorMode }
    , custom : Custom
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

let defaultDefaults
    : Defaults
    = { color = { fixedColor = "", mode = ColorMode.fixed }
      , custom = Custom.empty {=}
      , mappings = [] : List {}
      , thresholds =
        { mode = ColorMode.fixed
        , steps = [] : List { color : Text, value : Optional Double }
        }
      }

let mkDefaults =
    \(color : { fixedColor : Text, mode : ColorMode }) ->
    \(baseThresholdColor : Text ) ->
    \(thresholdColorMode : ColorMode) ->
    \(steps : List { color : Text, value : Double }) ->
      Some
        (     defaultDefaults
          //  { color
              , thresholds =
                { mode = thresholdColorMode
                , steps =
                      [ { color = baseThresholdColor, value = None Double } ]
                    # Prelude.List.map
                        { color : Text, value : Double }
                        { color : Text, value : Optional Double }
                        ( \(t : { color : Text, value : Double }) ->
                            { color = t.color, value = Some t.value }
                        )
                        steps
                }
              }
        )

in

{ Type = FieldConfig
, ColorMode = ColorMode
, MatcherID = MatcherID
, MatcherOption = MatcherOption
, Defaults = Defaults
, Override = Override
, mkDefaults
, defaultDefaults
, Custom
, CustomFieldConfig =
  { Type = CustomFieldConfig, default = defaultCustomFieldConfig }
, defaultCustomFieldConfig
}
