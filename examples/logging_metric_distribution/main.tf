module logging_metric_distribution {
  source          = "../../"
  name            = "dummy-metric"
  filter          = "resource.type=gae_app AND severity>=ERROR"
  value_extractor = "EXTRACT(jsonPayload.request)"

  metric_descriptor = {
    display_name = "Dummy Metric"
    metric_kind  = "DELTA"
    value_type   = "DISTRIBUTION"
    unit         = "1"
    labels = [
      {
        key         = "mass"
        value_type  = "STRING"
        description = "amount of matter"
      },
      {
        key         = "sku"
        value_type  = "INT64"
        description = "Identifying number for item"
      }
    ]
  }

  label_extractors = {
    "mass" = "EXTRACT(jsonPayload.request)"
    "sku"  = "EXTRACT(jsonPayload.id)"
  }

  bucket_options = {
    linear_buckets = {
      num_finite_buckets = 3
      width              = 1
      offset             = 1
    }
  }
}
