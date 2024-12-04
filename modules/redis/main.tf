resource "aws_elasticache_replication_group" "redis" {
  replication_group_id          = "redis-replication-group"
  description                   = "Redis replication group for messaging app"
  node_type                     = var.instance_type
  engine                        = "redis"
  engine_version                = "6.x"
  automatic_failover_enabled    = true
  num_cache_clusters            = 2
  security_group_ids            = var.security_group_ids
  subnet_group_name      = aws_elasticache_subnet_group.redis_subnet_group.name  # Correct argument
  tags = {
    Environment = var.environment
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4  # Adjust length as needed for your use case
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group-${random_id.bucket_id.hex}"  # Adding uniqueness
  subnet_ids = var.subnet_ids

  lifecycle {
    ignore_changes = [name]
  }

  tags = {
    Name = "redis-subnet-group"
  }
}
