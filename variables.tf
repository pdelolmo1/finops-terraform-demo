variable "region" {
  default = "us-west-2"
}

variable "default_tags" {
  type = map(string)
  default = {
    Project      = "FinOps-Demo"
    Owner        = "Pablo"
    CostCenter   = "IT-Cloud"
    Environment  = "Production"
  }
}

variable "budget_email" {
  default = "your-email@example.com"
}
