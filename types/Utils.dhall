let Prelude =
      https://prelude.dhall-lang.org/v19.0.0/package.dhall sha256:eb693342eb769f782174157eba9b5924cf8ac6793897fc36a31ccbd6f56dafe2

let indexed = Prelude.List.indexed

let map = Prelude.List.map

let Panels = (./Panels.dhall).Panels

let IndexedType = { index : Natural, value : Natural → Panels }

let generateIds
    : List (Natural → Panels) → List Panels
    = λ(list : List (Natural → Panels)) →
        map
          IndexedType
          Panels
          (λ(p : IndexedType) → p.value p.index)
          (indexed (Natural → Panels) list)

in  { generateIds }
