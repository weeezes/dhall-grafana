let ScenarioId =
      < csv_metric_values
      | datapoints_outside_range
      | exponential_heatmap_bucket_data
      | linear_heatmap_bucket_data
      | logs
      | manual_entry
      | no_data_points
      | predictable_csv_wave
      | predictable_pulse
      | random_walk
      | random_walk_table
      | slow_query
      | streaming_client
      | table_static
      >

let Target = { refId : Text, scenarioId : ScenarioId }

in  { Type = Target, ScenarioId }
