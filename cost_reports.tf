resource "aws_cur_report_definition" "finops_report" {
  report_name           = "FinOpsCostReport"
  time_unit            = "HOURLY"
  format               = "Parquet"
  compression          = "Parquet"
  additional_schema_elements = ["RESOURCES"]
  s3_bucket            = aws_s3_bucket.cost_reports.id
  s3_prefix            = "cost-reports/"
  s3_region            = "us-west-2"
  report_versioning    = "CREATE_NEW_REPORT"
  refresh_closed_reports = true
  additional_artifacts  = ["ATHENA"]
}
