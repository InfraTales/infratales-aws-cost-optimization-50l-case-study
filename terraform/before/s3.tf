# WASTEFUL: Standard storage, no lifecycle
resource "aws_s3_bucket" "logs" {
  bucket = "legacy-app-logs-bucket"
}
