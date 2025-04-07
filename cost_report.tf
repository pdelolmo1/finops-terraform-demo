resource "aws_cur_report_definition" "cost_report" {
  report_name                = "finops-cost-report"
  time_unit                  = "DAILY"
  format                     = "textORcsv"
  compression                = "GZIP"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket                  = aws_s3_bucket.cost_reports.bucket
  s3_prefix                  = "cost-reports/"
  s3_region                  = var.region
  report_versioning          = "OVERWRITE_REPORT"
}
