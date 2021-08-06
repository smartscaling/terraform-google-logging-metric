module logging_metric_counter {
  source = "smartscaling/logging-metric/google"
  name   = "dummy-metric"
  filter = "resource.type=gae_app AND severity>=ERROR"

  metric_descriptor = {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
