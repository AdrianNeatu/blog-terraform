provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_cloudwatch_metric_alarm" "billingAlert" {
  alarm_name                = "billingAlert"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "EstimatedCharges"
  namespace                 = "AWS/Billing"
  period                    = "3600" // 1 hour
  statistic                 = "Maximum"
  threshold                 = "10"
  alarm_description         = "This metric monitors charges"
  insufficient_data_actions = []
}