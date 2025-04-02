resource "aws_dynamodb_table" "finops_forecasts" {
  name           = "FinOpsForecasts"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "month"

  attribute {
    name = "month"
    type = "S"
  }

  attribute {
    name = "forecasted_cost"
    type = "N"
  }

  attribute {
    name = "actual_cost"
    type = "N"
  }

  tags = {
    Project     = "FinOps-Demo"
    Owner       = "Pablo"
    Environment = "Demo"
  }
}
