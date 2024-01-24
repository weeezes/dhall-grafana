let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall
        sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

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
          (λ(p : IndexedType) → p.value (p.index + 1))
          (indexed (Natural → Panels) list)

in  { generateIds }
