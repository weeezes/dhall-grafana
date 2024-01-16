let BucketSettings = (./LuceneBucketSettings.dhall).Type

let BucketAgg =
      { field : Text, id : Text, type : Text, settings : BucketSettings }

let Metric = { field : Text, id : Text, type : Text }

in  { Type =
        { alias : Text
        , bucketAggs : List BucketAgg
        , datasource : { type : Text, uid : Text }
        , format : Text
        , metrics : List Metric
        , queryType : Text
        , query : Text
        , refId : Text
        , timeField : Text
        }
    , default = { queryType = "lucene", query = "", timeField = "@timestamp" }
    }
