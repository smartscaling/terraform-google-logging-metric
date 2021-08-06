resource "google_logging_metric" "main" {
  count            = var.create_resource ? 1 : 0
  name             = var.name
  project          = var.project
  filter           = var.filter
  description      = var.description
  value_extractor  = var.value_extractor
  label_extractors = var.label_extractors

  // Dynamic blocks configurations

  # Metric Descriptor capped to 1 block
  dynamic "metric_descriptor" {
    for_each = length(keys(var.metric_descriptor)) == 0 ? [] : [var.metric_descriptor]

    content {
      unit         = lookup(metric_descriptor.value, "unit", null)
      value_type   = metric_descriptor.value.value_type
      metric_kind  = metric_descriptor.value.metric_kind
      display_name = lookup(metric_descriptor.value, "display_name", null)

      # Labels allowing several blocks
      dynamic "labels" {
        for_each = lookup(metric_descriptor.value, "labels", [])

        content {
          key         = labels.value.key
          description = lookup(labels.value, "description", null)
          value_type  = lookup(labels.value, "value_type", null)
        }
      }
    }
  }

  # Bucket Options capped to 1 block
  dynamic "bucket_options" {
    for_each = length(keys(var.bucket_options)) == 0 ? [] : [var.bucket_options]

    content {

      # Linear Buckets allowing several blocks
      dynamic "linear_buckets" {
        for_each = length(keys(lookup(bucket_options.value, "linear_buckets", {}))) == 0 ? [] : [lookup(bucket_options.value, "linear_buckets", {})]

        content {
          num_finite_buckets = lookup(linear_buckets.value, "num_finite_buckets", null)
          width              = lookup(linear_buckets.value, "width", null)
          offset             = lookup(linear_buckets.value, "offset", null)
        }
      }

      # Exponential Buckets allowing several blocks
      dynamic "exponential_buckets" {
        for_each = length(keys(lookup(bucket_options.value, "exponential_buckets", {}))) == 0 ? [] : [lookup(bucket_options.value, "exponential_buckets", {})]

        content {
          num_finite_buckets = lookup(exponential_buckets.value, "num_finite_buckets", null)
          growth_factor      = lookup(exponential_buckets.value, "growth_factor", null)
          scale              = lookup(exponential_buckets.value, "scale", null)
        }
      }

      # Explicit Buckets allowing several blocks
      dynamic "explicit_buckets" {
        for_each = length(keys(lookup(bucket_options.value, "explicit_buckets", {}))) == 0 ? [] : [lookup(bucket_options.value, "explicit_buckets", {})]

        content {
          bounds = explicit_buckets.value.bounds
        }
      }
    }
  }
}
