let Mode = < html | markdown >

let PanelType = < text >

let TextPanel =
      ./BasePanel.dhall //\\ { content : Text, mode : Mode, type : PanelType }

in  { Type = TextPanel, Mode, PanelType }
