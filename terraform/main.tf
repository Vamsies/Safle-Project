module "vpc" {
  source = "./modules/vpc"
  vpc_name = "${var.app_name}-vpc"
}

module "ecr" {
  source = "./modules/ecr"
  app_name = var.app_name
}

module "iam" {
  source = "./modules/iam"
}

module "rds" {
  source = "./modules/rds"
  db_username = "postgres"
  db_password = "securepassword"
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.vpc.db_sg_id]
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  ami_id = data.aws_ami.amazon_linux.id
  subnet_ids = module.vpc.public_subnet_ids
  security_group_ids = [module.vpc.ec2_sg_id]
  iam_instance_profile = module.iam.instance_profile
  user_data = file("user_data.sh")
}

module "alb" {
  source = "./modules/alb"
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  ec2_target_ids = module.ec2.instance_ids
}
