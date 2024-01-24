let TimePicker = ../types/TimePicker.dhall

in  { collapse = False
    , enable = True
    , notice = False
    , now = True
    , refresh_intervals =
      [ "5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d" ]
    , status = TimePicker.StatusType.Stable
    , time_options =
      [ "5m"
      , "15m"
      , "1h"
      , "3h"
      , "6h"
      , "12h"
      , "24h"
      , "2d"
      , "3d"
      , "4d"
      , "7d"
      , "30d"
      ]
    , type = TimePicker.TimePickerType.timepicker
    }
