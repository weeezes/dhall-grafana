{ pkgs ? import <nixpkgs> {}
}:

with pkgs;

let
  runGrafana = pkgs.writeShellScriptBin "run-grafana-server" ''
    set -eu

    export DATA_PATH=${toString ./.}/data
    export CONFIG_PATH=${toString ./.}/grafana

    exec ${pkgs.grafana}/bin/grafana-server -homepath ${pkgs.grafana}/share/grafana -config $CONFIG_PATH/grafana.ini
  '';

in

mkShell {
  name = "local-dev";
  buildInputs = [
    bash
    fswatch
    xdotool
    dhall-json
    jq
    curl
    runGrafana
  ];
}
