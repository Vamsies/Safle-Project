# AWS Region to deploy into
aws_region     = "us-east-1"

# Name of the application (used for resource naming)
app_name       = "node-app"

# EC2 instance type
instance_type  = "t3.micro"

# Database credentials (you should store these in AWS Secrets Manager or SSM in production)
db_username    = "postgres"
db_password    = "SuperSecurePassword123!"  # Use Terraform Vault or SSM for secrets in production

# Optional: Override default CIDR blocks or AZs if used in VPC module
# vpc_cidr = "10.0.0.0/16"
# public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
# private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
# availability_zones = ["us-east-1a", "us-east-1b"]
