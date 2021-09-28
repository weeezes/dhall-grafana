let StatPanelOptions = ../types/StatPanelOptions.dhall

in  { colorMode = StatPanelOptions.ColorMode.background
    , graphMode = StatPanelOptions.GraphMode.area
    , justifyMode = StatPanelOptions.JustifyMode.auto
    , orientation = StatPanelOptions.Orientation.auto
    , reduceOptions =
      { calcs = [ StatPanelOptions.CalcMode.mean ]
      , fields = ""
      , values = False
      }
    , textMode = StatPanelOptions.TextMode.auto
    }
