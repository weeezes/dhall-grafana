let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2
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
