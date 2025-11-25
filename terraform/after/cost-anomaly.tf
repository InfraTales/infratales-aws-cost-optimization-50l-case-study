# OPTIMIZED: Cost Anomaly Detection
resource "aws_ce_anomaly_monitor" "monitor" {
  name              = "DailySpendMonitor"
  monitor_type      = "DIMENSIONAL"
  monitor_dimension = "SERVICE"
}

resource "aws_ce_anomaly_subscription" "alert" {
  name      = "DailySpendAlert"
  frequency = "DAILY"
  monitor_arn_list = [aws_ce_anomaly_monitor.monitor.arn]
  
  subscriber {
    type    = "EMAIL"
    address = "finops@infratales.com"
  }
  
  threshold = 100 # Alert if anomaly > $100
}
