variable "region" {
  description = "AWS region to deploy resources in"
  default     = "us-west-2"
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type = map(string)
  default = {
    Project      = "FinOps-Demo"
    Owner        = "Pablo"
    CostCenter   = "IT-Cloud"
    Environment  = "Production"
  }
}

variable "budget_email" {
  description = "Email to receive budget alerts"
  type        = string
  default     = "your-email@example.com"
}
