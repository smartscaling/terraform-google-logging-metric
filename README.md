# Google Cloud Platform - Terraform Module - Logging Metric
This module creates a [Logs-based metric](https://cloud.google.com/logging/docs/logs-based-metrics) and optionally creates a distribution of the values, recording the statistics of the extracted values along with an optional histogram of the values as specified by the bucket options on Google Cloud Platform.

**Note**: For full explanation over dynamic blocks allowed options, please visit the [resource documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric#argument-reference).

## Basic structure

```hcl

module logging_metric {
  source            = "smartscaling/logging-metric/google"
  name              = "<metric-identifier>"
  filter            = "<filter-to-base-metric-on>"
  metric_descriptor = { <map-with-metric-descriptor-options> }
}

```

### Examples

```hcl
# Example of a counter Logging Metric
module logging_metric_counter {
  source = "smartscaling/logging-metric/google"
  name   = "dummy-metric"
  filter = "resource.type=gae_app AND severity>=ERROR"

  metric_descriptor = {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

# Example of a counter Logging Metric with labels
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

# Example of a distribution Logging Metric
module logging_metric_distribution {
  source          = "smartscaling/logging-metric/google"
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

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_logging_metric.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/logging_metric) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_options"></a> [bucket\_options](#input\_bucket\_options) | Map containing bucketOptions. The bucketOptions are required when the logs-based metric is using a DISTRIBUTION value type and it describes the bucket boundaries used to create a histogram of the extracted values. | `any` | `{}` | no |
| <a name="input_create_resource"></a> [create\_resource](#input\_create\_resource) | Specify wheter or not to create the resource. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | A description of this metric, which is used in documentation. The maximum length of the description is 8000 characters. | `string` | `null` | no |
| <a name="input_filter"></a> [filter](#input\_filter) | An advanced logs filter (https://cloud.google.com/logging/docs/view/advanced-filters) which is used to match log entries. | `string` | n/a | yes |
| <a name="input_label_extractors"></a> [label\_extractors](#input\_label\_extractors) | A map from a label key string to an extractor expression which is used to extract data from a log entry field and assign as the label value. Each label key specified in the LabelDescriptor must have an associated extractor expression in this map. The syntax of the extractor expression is the same as for the valueExtractor field. | `map(string)` | `{}` | no |
| <a name="input_metric_descriptor"></a> [metric\_descriptor](#input\_metric\_descriptor) | Map containing the metric descriptor associated with the logs-based metric. | `any` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The identifier of this resource. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| <a name="input_value_extractor"></a> [value\_extractor](#input\_value\_extractor) | A valueExtractor is required when using a distribution logs-based metric to extract the values to record from a log entry. Two functions are supported for value extraction - EXTRACT(field) or REGEXP\_EXTRACT(field, regex). The argument are 1. field - The name of the log entry field from which the value is to be extracted. 2. regex - A regular expression using the Google RE2 syntax (https://github.com/google/re2/wiki/Syntax) with a single capture group to extract data from the specified log entry field. The value of the field is converted to a string before applying the regex. It is an error to specify a regex that does not include exactly one capture group. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_options"></a> [bucket\_options](#output\_bucket\_options) | The bucketOptions of this metric. |
| <a name="output_description"></a> [description](#output\_description) | The description of this metric. |
| <a name="output_filter"></a> [filter](#output\_filter) | The advanced logs filter used to match log entries. |
| <a name="output_id"></a> [id](#output\_id) | The identifier for the resource with format {{name}}. |
| <a name="output_label_extractors"></a> [label\_extractors](#output\_label\_extractors) | The label extractor of this metric. |
| <a name="output_metric_descriptor"></a> [metric\_descriptor](#output\_metric\_descriptor) | The metric descriptor associated with the logs-based metric. |
| <a name="output_name"></a> [name](#output\_name) | The client-assigned metric identifier. |
| <a name="output_project"></a> [project](#output\_project) | The ID of the project in which the resource belongs. |
| <a name="output_value_extractor"></a> [value\_extractor](#output\_value\_extractor) | The valueExtractor of this metric. |
