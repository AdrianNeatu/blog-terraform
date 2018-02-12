provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

resource "aws_sns_topic" "sms_notification" {
  name = "sms-notification-topic"
}

resource "aws_sns_topic_subscription" "billing_sms" {
  topic_arn = "${aws_sns_topic.sms_notification.arn}"
  protocol  = "sms"
  endpoint  = "+40760080301"
}

resource "aws_cloudwatch_metric_alarm" "billingAlert" {
  alarm_name                = "billingAlert"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "EstimatedCharges"
  namespace                 = "AWS/Billing"
  period                    = "3600"                          // 1 hour
  statistic                 = "Maximum"
  threshold                 = "10"
  alarm_description         = "Sends SMS when billing is above 10$"
  dimensions {
    Currency = "USD"
  }
  insufficient_data_actions = []
  alarm_actions = ["${aws_sns_topic.sms_notification.arn}"]
}
