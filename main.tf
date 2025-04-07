module "tagging" {
  source       = "./modules/tagging"
  default_tags = var.default_tags
}

module "s3_cost_reports" {
  source       = "./modules/s3_cost_reports"
  default_tags = var.default_tags
}

module "budget" {
  source        = "./modules/budget"
  email_address = var.budget_email
  default_tags  = var.default_tags
}

module "forecast_lambda" {
  source       = "./modules/forecast_lambda"
  default_tags = var.default_tags
}

module "cloudwatch_trigger" {
  source               = "./modules/cloudwatch_trigger"
  lambda_function_name = module.forecast_lambda.lambda_name
  lambda_function_arn  = module.forecast_lambda.lambda_arn
}

module "cost_report" {
  source       = "./modules/cost_report"
  bucket_name  = module.s3_cost_reports.bucket_name
  default_tags = var.default_tags
}
