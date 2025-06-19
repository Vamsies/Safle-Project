output "alb_dns_name" {
  value = module.alb.dns_name
}

output "rds_endpoint" {
  value = module.rds.endpoint
}
