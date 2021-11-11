let Query = ./Query/package.dhall
let Base = ./Base/package.dhall

in
{ Type = ./Type.dhall
, Query
, Base
, mk = ./mk.dhall
}
