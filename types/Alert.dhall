let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2
let Map = Prelude.Map.Type

let ExecutionErrorState = < alerting | keep_state >
let NoDataState = < alerting | no_data | keep_state | ok >

let ConditionEvaluator = < gt | lt | outside_range | within_range | no_value >
let ConditionOperator = < and | or >
let ConditionReducer =
      < avg
      | min
      | max
      | sum
      | count
      | last
      | median
      | diff
      | diff_abs
      | percent_diff
      | percent_diff_abs
      | count_non_null
      >
let ConditionType = < query >

let Condition =
    {
      evaluator: {
        params: List Natural,
        type: ConditionEvaluator
      },
      operator: {
        type: ConditionOperator
      },
      query: {
        params: List Text
      },
      reducer: {
        params: List Text,
        type: ConditionReducer
      },
      type: ConditionType
    }

let Alert =
  { alertRuleTags: Map Text Text
  , conditions: List Condition
  , executionErrorState: ExecutionErrorState
  , for: Text
  , frequency: Text
  , handler: Natural
  , name: Text
  , message: Text
  , noDataState: NoDataState
  , notifications: List Text
  }

let mkSimpleAlert
    : Text -> Optional Text -> Natural -> Optional ConditionEvaluator -> Optional ExecutionErrorState -> Optional NoDataState -> Alert
    = \(name : Text) ->
      \(msg : Optional Text) ->
      \(threshold : Natural) ->
      \(evaluator : Optional ConditionEvaluator) ->
      \(executionErrorState : Optional ExecutionErrorState) ->
      \(noDataState : Optional NoDataState) ->
        { alertRuleTags = Prelude.Map.empty Text Text
        , conditions =
          [{ evaluator =
                { params = [ threshold ]
                , type = Prelude.Optional.default ConditionEvaluator ConditionEvaluator.gt evaluator
                }
            , operator =
                { type = ConditionOperator.and
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
                , type = ConditionReducer.avg
                }
            , type = ConditionType.query
            }
          ]
        , executionErrorState = Prelude.Optional.default ExecutionErrorState ExecutionErrorState.alerting executionErrorState
        , for = "5m"
        , frequency = "1m"
        , handler = 1
        , name = name
        , message = Prelude.Optional.default Text "" msg
        , noDataState =  Prelude.Optional.default NoDataState NoDataState.no_data noDataState
        , notifications = [] : List Text
        }

in

{ Type = Alert
, NoDataState = NoDataState
, ExecutionErrorState = ExecutionErrorState
, ConditionEvaluator = ConditionEvaluator
, ConditionOperator = ConditionOperator
, ConditionReducer = ConditionReducer
, ConditionType = ConditionType
, Condition = Condition
, mkSimpleAlert
}