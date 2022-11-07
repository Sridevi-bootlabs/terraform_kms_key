variable "description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
  default = "value"
}
variable "deletion_window_in_days" {
  description = "The waiting period, specified in number of days"
  type        = number
}
variable "oauth_config_description" {
  description = "The description of the key as viewed in AWS console"
  type        = string
}
variable "is_enabled" {
  description = "Specifies whether the key is enabled"
  type        = bool
}
variable "name" {
  description = "Friendly name of the role"
  type        = string
}
# variable "a_name" {
#   description = "A friendly name for identifying the grant"
#   type        = string
# }
variable "operations" {
  description = "A list of operations that the grant permits"
  type        = list(string)
}
variable "primary_description" {
  description = "A description of the KMS key"
  type        = string
}
variable "primary_deletion_window_in_days" {
  description = "The waiting period, specified in number of days"
  type        = number
}
# variable "multi_region" {
#   description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key"
#   type        = boolean
# }
variable "replica_description" {
  description = "A description of the KMS key"
  type        = string
}
variable "kms_deletion_window_in_days" {
  description = "The waiting period, specified in number of days"
  type        = number
}