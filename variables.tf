variable "product_domain" {
  description = "Product domain own this lambda function"
  type        = "string"
  default     = "tsi"
}

variable "environment" {
  description = "environment where this service reside"
  default     = "staging"
  type        = "string"
}

variable "description" {
  description = "description of this service"
  type        = "string"
  default     = "Automatic Volume Backup Script"
}

variable "lambda_timeout" {
  description = "timeout for lambda function"
  default     = "300"
  type        = "string"
}

variable "lambda_memory_size" {
  description = "size of memory reserved for lambda function"
  default     = "512"
  type        = "string"
}
