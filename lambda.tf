resource "aws_dynamodb_table" "forecast_data" {
  name         = "finops_forecast_data"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.default_tags
}

resource "aws_iam_role" "lambda_forecast_role" {
  name = "lambda_forecast_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}

resource "aws_iam_policy" "forecast_lambda_policy" {
  name = "forecast_lambda_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ce:GetCostForecast", "dynamodb:PutItem"],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_forecast_attach" {
  role       = aws_iam_role.lambda_forecast_role.name
  policy_arn = aws_iam_policy.forecast_lambda_policy.arn
}

resource "aws_lambda_function" "forecast_lambda" {
  function_name = "FinOpsForecastLambda"
  role          = aws_iam_role.lambda_forecast_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  filename      = "lambda_function.zip"
  timeout       = 30

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.forecast_data.name
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_forecast_attach
  ]
}
