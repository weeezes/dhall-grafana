let BasePanel = ./BasePanel.dhall

let TextPanel = (./TextPanel.dhall).Type

let GraphPanel = (./GraphPanel.dhall).Type

let SinglestatPanel = (./SinglestatPanel.dhall).Type

let StatPanel = (./StatPanel.dhall).Type

let TablePanel = (./TablePanel.dhall).Type

let Row = (./Row.dhall).Type

let Panels =
      < TextPanel : TextPanel
      | GraphPanel : GraphPanel
      | SinglestatPanel : SinglestatPanel
      | StatPanel : StatPanel
      | TablePanel : TablePanel
      | Row : Row
      >

let panelGenerator
    : ∀(Panel : Type) →
      (Panel → Panels) →
      (Panel → Natural → Panel) →
      Panel →
      Natural →
        Panels
    = λ(Panel : Type) →
      λ(const : Panel → Panels) →
      λ(setId : Panel → Natural → Panel) →
      λ(panel : Panel) →
      λ(id : Natural) →
        const (setId panel id)

let mkTextPanel
    : TextPanel → Natural → Panels
    = panelGenerator
        TextPanel
        Panels.TextPanel
        (λ(p : TextPanel) → λ(id : Natural) → p ⫽ { id })

let mkGraphPanel
    : GraphPanel → Natural → Panels
    = panelGenerator
        GraphPanel
        Panels.GraphPanel
        (λ(p : GraphPanel) → λ(id : Natural) → p ⫽ { id })

let mkSinglestatPanel
    : SinglestatPanel → Natural → Panels
    = panelGenerator
        SinglestatPanel
        Panels.SinglestatPanel
        (λ(p : SinglestatPanel) → λ(id : Natural) → p ⫽ { id })

let mkStatPanel
    : StatPanel → Natural → Panels
    = panelGenerator
        StatPanel
        Panels.StatPanel
        (λ(p : StatPanel) → λ(id : Natural) → p ⫽ { id })

let mkTablePanel
    : TablePanel → Natural → Panels
    = panelGenerator
        TablePanel
        Panels.TablePanel
        (λ(p : TablePanel) → λ(id : Natural) → p ⫽ { id })

let mkRow
    : Row → Natural → Panels
    = panelGenerator Row Panels.Row (λ(p : Row) → λ(id : Natural) → p ⫽ { id })

in  { Panels
    , mkTextPanel
    , mkGraphPanel
    , mkSinglestatPanel
    , mkStatPanel
    , mkTablePanel
    , mkRow
    }
