let Status = < Stable >
let TimePickerType = < timepicker >
let TimePicker =
    { collapse : Bool
    , enable: Bool
    , notice: Bool
    , now: Bool
    , refresh_intervals: List Text
    , status: Status
    , time_options: List Text
    , type: TimePickerType
    }

in

{ Type = TimePicker
, TimePickerType = TimePickerType
, StatusType = Status
}