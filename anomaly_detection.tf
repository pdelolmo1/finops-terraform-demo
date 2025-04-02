resource "aws_ce_anomaly_detection" "finops_anomaly" {
  name         = "FinOpsCostAnomaly"
  scope        = "LINKED_ACCOUNT"
  threshold    = 20
  metric_name  = "UNBLENDED_COST"
}

resource "aws_ce_anomaly_subscription" "finops_alert" {
  name           = "FinOpsAlert"
  anomaly_detection_arn = aws_ce_anomaly_detection.finops_anomaly.arn
  frequency      = "DAILY"

  subscriber {
    type    = "EMAIL"
    address = "finops-team@example.com"
  }
}
