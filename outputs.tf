output "cost_report_bucket" {
  value = module.s3_cost_reports.bucket_name
}

output "forecast_lambda_name" {
  value = module.forecast_lambda.lambda_name
}

output "monthly_budget_name" {
  value = module.budget.budget_name
}
