/*
  Meta variables
*/

variable "create_resource" {
  description = "Specify wheter or not to create the resource."
  type        = bool
  default     = true
}

variable "project" {
  description = "The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "name" {
  description = "The identifier of this resource."
  type        = string
}

/*
  Resource variables
*/

variable "filter" {
  description = "An advanced logs filter (https://cloud.google.com/logging/docs/view/advanced-filters) which is used to match log entries."
  type        = string
}

variable "description" {
  description = "A description of this metric, which is used in documentation. The maximum length of the description is 8000 characters."
  type        = string
  default     = null
}

variable "value_extractor" {
  description = "A valueExtractor is required when using a distribution logs-based metric to extract the values to record from a log entry. Two functions are supported for value extraction - EXTRACT(field) or REGEXP_EXTRACT(field, regex). The argument are 1. field - The name of the log entry field from which the value is to be extracted. 2. regex - A regular expression using the Google RE2 syntax (https://github.com/google/re2/wiki/Syntax) with a single capture group to extract data from the specified log entry field. The value of the field is converted to a string before applying the regex. It is an error to specify a regex that does not include exactly one capture group."
  type        = string
  default     = null
}

variable "label_extractors" {
  description = "A map from a label key string to an extractor expression which is used to extract data from a log entry field and assign as the label value. Each label key specified in the LabelDescriptor must have an associated extractor expression in this map. The syntax of the extractor expression is the same as for the valueExtractor field."
  type        = map(string)
  default     = {}
}

variable "metric_descriptor" {
  description = "Map containing the metric descriptor associated with the logs-based metric."
  type        = any
  default     = {}
}

variable "bucket_options" {
  description = "Map containing bucketOptions. The bucketOptions are required when the logs-based metric is using a DISTRIBUTION value type and it describes the bucket boundaries used to create a histogram of the extracted values."
  type        = any
  default     = {}
}
