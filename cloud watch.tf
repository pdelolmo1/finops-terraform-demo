resource "aws_cloudwatch_event_rule" "daily_forecast" {
  name                = "daily_forecast"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "trigger_lambda" {
  rule      = aws_cloudwatch_event_rule.daily_forecast.name
  target_id = "ForecastLambda"
  arn       = aws_lambda_function.forecast_lambda.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.forecast_lambda.function_name
  principal     = "events.amazonaws.com"
}
