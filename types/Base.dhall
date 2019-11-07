let indexed =
    https://prelude.dhall-lang.org/List/indexed sha256:58bb44457fa81adf26f5123c1b2e8bef0c5aa22dac5fa5ebdfb7da84563b027f
let map =
    https://prelude.dhall-lang.org/List/map sha256:dd845ffb4568d40327f2a817eb42d1c6138b929ca758d50bc33112ef3c885680

let Panels = (./Panels.dhall).Panels
let IndexedType = { index : Natural, value : Natural -> Panels }

let generateIds : List (Natural -> Panels) -> List Panels = 
    \(list : List (Natural -> Panels))
    -> map
        IndexedType
        Panels
        (\(p : IndexedType) -> p.value p.index)
        (indexed (Natural -> Panels) list)

in
{ generateIds = generateIds
}