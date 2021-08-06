output id {
  description = "The identifier for the resource with format {{name}}."
  value       = module.logging_metric_counter.id
}

output name {
  description = "The client-assigned metric identifier."
  value       = module.logging_metric_counter.name
}

output project {
  description = "The ID of the project in which the resource belongs."
  value       = module.logging_metric_counter.project
}

output filter {
  description = "The advanced logs filter used to match log entries."
  value       = module.logging_metric_counter.filter
}

output label_extractors {
  description = "The label extractor of this metric."
  value       = module.logging_metric_counter.label_extractors
}

output metric_descriptor {
  description = "The metric descriptor associated with the logs-based metric."
  value       = module.logging_metric_counter.metric_descriptor
}
