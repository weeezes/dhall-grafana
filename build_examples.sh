#! /usr/bin/env nix-shell
#! nix-shell -i bash -p dhall-json

SOURCE="$(dirname $(readlink -f ${BASH_SOURCE[0]}))"

export TEST_DASHBOARD="(./package.dhall).ScenarioId.random_walk"

mkdir -p $SOURCE/out
for f in $SOURCE/examples/*.dhall; do
  fileName=$(basename $f)
  dhall-to-json --file $f >$SOURCE/out/${fileName/.dhall/.json}
done

echo Done