output "redis_endpoint" {
  description = "Primary endpoint address for Redis cluster"
  value       = aws_elasticache_replication_group.redis.primary_endpoint_address
}

