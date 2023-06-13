variable "name" {
  description = "Parameter name"
}

variable "parameters" {
  description = "Parameters expressed as a map of maps. Each map's key is its intended SSM parameter name, and the value stored under that key is another map that may contain the following keys: description, type, and value."
  type        = map(map(string))
}

variable "prefix" {
  description = "Prefix prepended to parameter name if not using default"
  default     = "/service"
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}

variable "bucket" {
  description = "(Required) Name of the S3 Bucket"
  type        = string
}

variable "key" {
  description = "(Required) Path to the state file inside the S3 Bucket. When using a non-default workspace, the state path will be /workspace_key_prefix/workspace_name/key (see also the workspace_key_prefix configuration)"
  type        = string
}

variable "region" {
  description = "(Required) AWS Region of the S3 Bucket and DynamoDB Table (if used). This can also be sourced from the AWS_DEFAULT_REGION and AWS_REGION environment variables"
  type        = string
  default     = "eu-central-1"
}

variable "encrypt" {
  description = "(Optional) Enable server side encryption of the state file"
  type        = string
  default     = "true"
}
