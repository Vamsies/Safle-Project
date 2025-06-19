module "vpc" {
  source    = "./modules/vpc"
  app_name  = var.app_name
}

module "ecr" {
  source    = "./modules/ecr"
  app_name  = var.app_name
}

module "iam" {
  source = "./modules/iam"
}

module "rds" {
  source              = "./modules/rds"
  app_name            = var.app_name
  db_username         = var.db_username
  db_password         = var.db_password
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.private_subnet_ids
  security_group_ids  = [module.vpc.db_sg_id]
}

module "ec2" {
  source                = "./modules/ec2"
  app_name              = var.app_name
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  subnet_ids            = module.vpc.public_subnet_ids
  security_group_ids    = [module.vpc.ec2_sg_id]
  iam_instance_profile  = module.iam.instance_profile
  key_name              = var.key_name
  user_data             = file("${path.module}/../user_data.sh")
}

module "alb" {
  source             = "./modules/alb"
  app_name           = var.app_name
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  target_ids         = module.ec2.instance_ids
  security_group_ids = [module.vpc.alb_sg_id]
}
