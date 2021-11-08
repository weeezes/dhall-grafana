let PrometheusTarget = (./PrometheusTarget.dhall).Type
let InfluxTarget = (./InfluxTarget.dhall).Type
let TestDataDBTarget = (./TestDataDBTarget.dhall).Type
let RawQueryTarget = (./RawQueryTarget.dhall).Type
in
< PrometheusTarget : PrometheusTarget
| InfluxTarget : InfluxTarget
| TestDataDBTarget : TestDataDBTarget
| RawQueryTarget : RawQueryTarget
>
