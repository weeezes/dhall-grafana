{ pkgs ? import <nixpkgs> {}
}:

with pkgs;

let
  dataPath = "${toString ./.}/data";
  runGrafana = pkgs.writeShellScriptBin "run-grafana-server" ''
    set -eu

    export DATA_PATH=${dataPath}/grafana
    export CONFIG_PATH=${toString ./.}/grafana

    exec ${pkgs.grafana}/bin/grafana-server -homepath ${pkgs.grafana}/share/grafana -config $CONFIG_PATH/grafana.ini
  '';

  influxConfig = pkgs.writeTextFile {
    name = "influx.conf";
    text = ''
      [meta]
      dir = "${dataPath}/influx/meta"
      [data]
      dir = "${dataPath}/influx/data"
      wal-dir = "${dataPath}/influx/wal"
      '';
  };

  runInflux = pkgs.writeShellScriptBin "run-influx-server" ''
    set -eu

    export INFLUXDB_CONFIG_PATH=${influxConfig}

    # Start influx in the background
    ${pkgs.influxdb}/bin/influxd run &

    # Init the database with sample data
    ${initInfluxData}/bin/init-influx-data
 
    # Wait for influx process
    wait
  '';

  
  initInfluxData = pkgs.writeShellScriptBin "init-influx-data" ''
  ${pkgs.influxdb}/bin/influx -execute 'CREATE DATABASE NOAA_water_database'
  ${pkgs.curl}/bin/curl https://s3.amazonaws.com/noaa.water-database/NOAA_data.txt -o ${dataPath}/NOAA_data.txt
  ${pkgs.influxdb}/bin/influx -import -path=${dataPath}/NOAA_data.txt -precision=s -database=NOAA_water_database
  '';

  prometheusConfig = pkgs.writeTextFile {
    name = "prometheus.conf";
    text = ''
scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
      '';
  };

  runPrometheus = pkgs.writeShellScriptBin "run-prometheus-server" ''
    set -eu

    # Start influx in the background
    ${pkgs.prometheus}/bin/prometheus --config.file=${prometheusConfig} --storage.tsdb.path="${dataPath}/prometheus"
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
    foreman
    runGrafana
    runInflux
    runPrometheus
  ];
}
