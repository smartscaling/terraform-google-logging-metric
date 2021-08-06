module logging_metric_counter_labeled {
  source = "smartscaling/logging-metric/google"
  name   = "dummy-metric"
  filter = "resource.type=gae_app AND severity>=ERROR"

  metric_descriptor = {
    metric_kind = "DELTA"
    value_type  = "INT64"
    labels = [
      {
        key         = "mass"
        value_type  = "STRING"
        description = "amount of matter"
      }
    ]
  }

  label_extractors = {
    "mass" = "EXTRACT(jsonPayload.request)"
  }
}
