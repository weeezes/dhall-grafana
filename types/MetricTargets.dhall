let PrometheusTarget = (./PrometheusTarget.dhall).Type
let TestDataDBTarget = (./TestDataDBTarget.dhall).Type
in
< PrometheusTarget : PrometheusTarget
| TestDataDBTarget : TestDataDBTarget
>
