# WASTEFUL: Large Redis Cluster for simple caching
resource "aws_elasticache_cluster" "legacy" {
  cluster_id           = "legacy-redis"
  engine               = "redis"
  node_type            = "cache.r6g.large"
  num_cache_nodes      = 2
  parameter_group_name = "default.redis5.0"
  engine_version       = "5.0.6"
  port                 = 6379
}
