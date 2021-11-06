let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98
let Alert = ../types/Alert.dhall

in

{ alertRuleTags = Prelude.Map.empty Text Text
, conditions =
  [{ evaluator =
        { params = [ 0 ]
        , type = Alert.ConditionEvaluator.gt
        }
    , operator =
        { type = Alert.ConditionOperator.and
        }
    , query =
        { params =
            [ "A"
            , "5m"
            , "now"
            ]
        }
    , reducer =
        { params = [] : List Text
        , type = Alert.ConditionReducer.avg
        }
    , type = Alert.ConditionType.query
    }
  ]
, executionErrorState = Alert.ExecutionErrorState.alerting
, for = "5m"
, frequency = "1m"
, handler = 1
, name = ""
, message = ""
, noDataState = Alert.NoDataState.no_data
, notifications = [] : List Text
}
