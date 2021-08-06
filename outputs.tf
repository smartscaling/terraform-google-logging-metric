output id {
  description = "The identifier for the resource with format {{name}}."
  value       = concat(google_logging_metric.main.*.id, [""])[0]
}

output name {
  description = "The client-assigned metric identifier."
  value       = concat(google_logging_metric.main.*.name, [""])[0]
}

output project {
  description = "The ID of the project in which the resource belongs."
  value       = concat(google_logging_metric.main.*.project, [""])[0]
}

output filter {
  description = "The advanced logs filter used to match log entries."
  value       = concat(google_logging_metric.main.*.filter, [""])[0]
}

output description {
  description = "The description of this metric."
  value       = concat(google_logging_metric.main.*.description, [""])[0]
}

output value_extractor {
  description = "The valueExtractor of this metric."
  value       = concat(google_logging_metric.main.*.value_extractor, [""])[0]
}

output label_extractors {
  description = "The label extractor of this metric."
  value       = concat(google_logging_metric.main.*.label_extractors, [""])[0]
}

output metric_descriptor {
  description = "The metric descriptor associated with the logs-based metric."
  value       = concat(google_logging_metric.main.*.metric_descriptor, [""])[0]
}

output bucket_options {
  description = "The bucketOptions of this metric."
  value       = concat(google_logging_metric.main.*.bucket_options, [""])[0]
}
