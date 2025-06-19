variable "aws_region" {
  default = "us-east-1"
}

variable "app_name" {
  default = "node-app"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"  # Amazon Linux 2 (update as needed)
}

variable "key_name" {
  default = "your-key-pair-name"
}

variable "db_username" {
  default = "postgres"
}

variable "db_password" {
  default = "changeme123"
}
