let BasePanel = ./BasePanel.dhall
let TextPanel = (./TextPanel.dhall).Type
let GraphPanel = (./GraphPanel.dhall).Type
let SinglestatPanel = (./SinglestatPanel.dhall).Type
let Row = (./Row.dhall).Type

let Panels = 
    < TextPanel : TextPanel
    | GraphPanel : GraphPanel
    | SinglestatPanel : SinglestatPanel
    | Row : Row
    >

let panelGenerator
    :   ∀(Panel : Type)
        → (Panel → Panels)
        → (Panel → Natural → Panel)
        → Panel
        → Natural
        → Panels
    =   λ(Panel : Type)
        → λ(const : Panel → Panels)
        → λ(setId : Panel → Natural → Panel)
        → λ(panel : Panel)
        → λ(id : Natural)
        → const (setId panel id)

let mkTextPanel : TextPanel -> Natural -> Panels =
    panelGenerator
        TextPanel
        Panels.TextPanel
        (λ(p : TextPanel) → λ(id : Natural) → p ⫽ { id = id })

let mkGraphPanel : GraphPanel -> Natural -> Panels =
    panelGenerator
        GraphPanel
        Panels.GraphPanel
        (λ(p : GraphPanel) → λ(id : Natural) → p ⫽ { id = id })

let mkSinglestatPanel : SinglestatPanel -> Natural -> Panels =
    panelGenerator
        SinglestatPanel
        Panels.SinglestatPanel
        (λ(p : SinglestatPanel) → λ(id : Natural) → p ⫽ { id = id })

let mkRow : Row -> Natural -> Panels =
    panelGenerator
        Row
        Panels.Row
        (λ(p : Row) → λ(id : Natural) → p ⫽ { id = id })

in

{ Panels = Panels
, mkTextPanel = mkTextPanel
, mkGraphPanel = mkGraphPanel
, mkSinglestatPanel = mkSinglestatPanel
, mkRow = mkRow
}
