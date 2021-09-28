let ColorMode = < value | background >

let GraphMode = < none | area >

let JustifyMode = < auto | center >

let Orientation = < auto | horizontal | vertical >

let TextMode = < auto | value | value_and_name | name | none >

let CalcMode =
      < lastNotNull
      | last
      | firstNotNull
      | first
      | min
      | max
      | mean
      | total
      | count
      | range
      | delta
      | step
      | diff
      | logmin
      | allIsZero
      | allIsNull
      | changeCount
      | distinctCount
      >

in  { ColorMode
    , GraphMode
    , JustifyMode
    , Orientation
    , CalcMode
    , TextMode
    , Type =
        { colorMode : ColorMode
        , graphMode : GraphMode
        , justifyMode : JustifyMode
        , orientation : Orientation
        , reduceOptions :
            { calcs : List CalcMode, fields : Text, values : Bool }
        , textMode : TextMode
        }
    }
