let PanelType = < row >

let Row = ./BasePanel.dhall //\\ { collapsed : Bool, type : PanelType }

in  { Type = Row, PanelType }
