resource "aws_s3_bucket" "cost_reports" {
  bucket = "finops-demo-cost-reports"

  tags = {
    Name        = "FinOps Cost Reports"
    Environment = "Production"
  }
}

# Set ACL using aws_s3_bucket_acl
resource "aws_s3_bucket_acl" "cost_reports_acl" {
  bucket = aws_s3_bucket.cost_reports.id
  acl    = "private"
}
