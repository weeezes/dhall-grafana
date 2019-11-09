let PrometheusTarget = (./PrometheusTarget.dhall).Type
let TestDataDBTarget = (./TestDataDBTarget.dhall).Type

let MetricTargets =
    < PrometheusTarget : PrometheusTarget
    | TestDataDBTarget : TestDataDBTarget
    >

in

{ MetricTargets = MetricTargets
}