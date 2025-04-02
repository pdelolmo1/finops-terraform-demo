variable "default_tags" {
  type = map(string)
  default = {
    "Project"   = "FinOps-Demo"
    "Owner"     = "Pablo"
    "CostCenter" = "IT-Cloud"
    "Environment" = "Production"
  }
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_s3_bucket" "example" {
  bucket = "finops-demo-bucket"

  tags = var.default_tags
}
