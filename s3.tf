resource "aws_s3_bucket" "cost_reports" {
  bucket = "finops-demo-cost-reports"

  tags = var.default_tags
}

resource "aws_s3_bucket" "tagged_example" {
  bucket = "finops-demo-bucket-tagging"

  tags = var.default_tags
}
