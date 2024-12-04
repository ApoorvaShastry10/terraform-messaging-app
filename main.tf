provider "aws" {
  region = "us-west-1"
}

resource "aws_security_group" "app" {
  vpc_id = module.network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Network Module
module "network" {
  source = "./modules/network"

  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Compute Module
module "compute" {
  source             = "./modules/compute"
  subnet_ids         = module.network.public_subnet_ids
  security_group_ids  = [aws_security_group.app.id]
  vpc_id             = module.network.vpc_id

  instance_type      = var.instance_type
  key_name           = module.compute.key
  desired_capacity   = var.desired_capacity
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
}

# Database Module
module "database" {
  source             = "./modules/database"
  vpc_id             = module.network.vpc_id
  # security_group_id =  module.security_group.id
  security_group_ids = [aws_security_group.app.id]
  subnet_ids = module.network.public_subnet_ids
}

# Redis Module
module "redis" {
  source             = "./modules/redis"
  # vpc_id             = module.network.vpc_id
  instance_type       = "cache.t3.micro"
  environment         = var.environment
  subnet_ids         = module.network.public_subnet_ids
  security_group_ids = [module.network.app_sg_id]
  node_count          = 1
  cache_subnet_group_name = aws_elasticache_subnet_group.redis_subnet_group.name  # Pass subnet group name
}

# Storage Module
module "storage" {
  source = "./modules/storage"

  bucket_name                     = "app-media-storage"
  noncurrent_version_retention_days = 30
  object_retention_days           = 365
  allowed_referer                 = "https://myapp.com"
  environment = var.environment
  static_page_path                = "index.html" # Path to the static HTML file
}

module "security_group" {
  source = "./modules/security_group"

  name   = "messaging-app-sg"
  vpc_id = module.network.vpc_id
  tags   = {
    Environment = var.environment
    Application = "MessagingApp"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4  # Adjust length as needed for your use case
}

resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group-${random_id.bucket_id.hex}"  # Adding uniqueness
  subnet_ids = module.network.public_subnet_ids

  lifecycle {
    ignore_changes = [name]
  }

  tags = {
    Name = "redis-subnet-group"
  }
}
