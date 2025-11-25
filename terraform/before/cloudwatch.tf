# WASTEFUL: 900 Custom Metrics (Simulated)
resource "aws_cloudwatch_metric_alarm" "custom" {
  count               = 5 # Simulating just a few in code
  alarm_name          = "custom-metric-${count.index}"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "CustomMetric${count.index}"
  namespace           = "Custom/App"
  period              = "60"
  statistic           = "Average"
  threshold           = "80"
}
