# Logging Metric: Counter

Configuration in this directory creates a labeled logs-based counter metric.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 3.0.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_logging_metric_counter"></a> [logging\_metric\_counter](#module\_logging\_metric\_counter) | smartscaling/logging-metric/google |  |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_filter"></a> [filter](#output\_filter) | The advanced logs filter used to match log entries. |
| <a name="output_id"></a> [id](#output\_id) | The identifier for the resource with format {{name}}. |
| <a name="output_label_extractors"></a> [label\_extractors](#output\_label\_extractors) | The label extractor of this metric. |
| <a name="output_metric_descriptor"></a> [metric\_descriptor](#output\_metric\_descriptor) | The metric descriptor associated with the logs-based metric. |
| <a name="output_name"></a> [name](#output\_name) | The client-assigned metric identifier. |
| <a name="output_project"></a> [project](#output\_project) | The ID of the project in which the resource belongs. |
