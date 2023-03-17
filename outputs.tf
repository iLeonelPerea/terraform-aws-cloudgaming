output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_id" {
  value = [for s in aws_subnet.subnet_public : s.id]
}

output "project_name" {
  value = var.project_name
}

output "globalacelerator_dns" {
  value = aws_globalaccelerator_accelerator.globalaccelerator.dns_name
}
