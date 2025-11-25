# OPTIMIZED: DynamoDB On-Demand replaces Redis Cluster
resource "aws_dynamodb_table" "cache" {
  name         = "app-cache"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "CacheKey"

  attribute {
    name = "CacheKey"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }
}
