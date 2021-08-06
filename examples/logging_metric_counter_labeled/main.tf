module logging_metric_counter {
  source = "../../"
  name   = "dummy-metric"
  filter = "resource.type=gae_app AND severity>=ERROR"

  metric_descriptor = {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}
