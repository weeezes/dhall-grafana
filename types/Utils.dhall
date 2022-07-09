let Prelude =
      https://prelude.dhall-lang.org/v20.1.0/package.dhall
        sha256:26b0ef498663d269e4dc6a82b0ee289ec565d683ef4c00d0ebdd25333a5a3c98

let map = Prelude.List.map

let zip = Prelude.List.zip

let iterate = Prelude.List.iterate

let length = Prelude.List.length

let Panels = (./Panels.dhall).Panels

let ZippedType = { _1 : Natural → Panels, _2 : Natural }

let generateIds
    : List (Natural → Panels) → List Panels
    = λ(list : List (Natural → Panels)) →
        let len = length (Natural → Panels) list

        let plusOne = λ(x : Natural) → x + 1

        let indexSeq = iterate len Natural plusOne 1

        let zipped = zip (Natural → Panels) list Natural indexSeq

        in  map ZippedType Panels (λ(p : ZippedType) → p._1 p._2) zipped

in  { generateIds }
