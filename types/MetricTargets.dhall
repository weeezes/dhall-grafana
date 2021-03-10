let PrometheusTarget = (./PrometheusTarget.dhall).Type
let InfluxTarget = (./InfluxTarget.dhall).Type
let TestDataDBTarget = (./TestDataDBTarget.dhall).Type
in
< PrometheusTarget : PrometheusTarget
| InfluxTarget : InfluxTarget
| TestDataDBTarget : TestDataDBTarget
>
