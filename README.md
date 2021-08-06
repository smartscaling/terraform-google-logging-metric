# Google Cloud Platform - Terraform Module - Logging Metric
This module creates a [Logs-based metric](https://cloud.google.com/logging/docs/logs-based-metrics) and optionally creates a distribution of the values, recording the statistics of the extracted values along with an optional histogram of the values as specified by the bucket options on Google Cloud Platform.

**Note**: For full explanation over dynamic blocks allowed options, please visit the [resource documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric#argument-reference).

## Basic structure

```hcl

module logging_metric {
  source            = "git@github.com:smartscaling/terraform-google-logging-metric"
  name              = "<metric-identifier>"
  filter            = "<filter-to-base-metric-on>"
  metric_descriptor = { <map-with-metric-descriptor-options> }
}

```

### Examples

```hcl
# Example of a counter Logging Metric
module logging_metric_counter {
  source = "git@github.com:smartscaling/terraform-google-logging-metric"
  name   = "dummy-metric"
  filter = "resource.type=gae_app AND severity>=ERROR"

  metric_descriptor = {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

# Example of a counter Logging Metric with labels
module logging_metric_counter_labeled {
  source = "git@github.com:smartscaling/terraform-google-logging-metric"
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

# Example of a distribution Logging Metric
module logging_metric_distribution {
  source          = "git@github.com:smartscaling/terraform-google-logging-metric"
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

```
