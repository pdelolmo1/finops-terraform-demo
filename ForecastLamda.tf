resource "aws_iam_role" "lambda_forecast_role" {
  name = "lambda_finops_forecast_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "forecast_policy" {
  name        = "forecast_cost_policy"
  description = "Allows Lambda to read Cost Explorer data"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ce:GetCostForecast",
          "dynamodb:PutItem"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_forecast_attach" {
  role       = aws_iam_role.lambda_forecast_role.name
  policy_arn = aws_iam_policy.forecast_policy.arn
}

resource "aws_lambda_function" "finops_forecast_lambda" {
  function_name = "FinOpsForecastLambda"
  role          = aws_iam_role.lambda_forecast_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  
  filename      = "lambda_function.zip" # Make sure this exists in your Terraform directory
  timeout       = 30

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.finops_forecasts.name
    }
  }
}
