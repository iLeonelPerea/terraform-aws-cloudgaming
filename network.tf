# # Subnet Configuration
# https://www.terraform.io/docs/providers/aws/r/subnet.html
resource "aws_subnet" "subnet_public" {
  count                   = 2
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.public_subnets[count.index]
  map_public_ip_on_launch = "true"
  availability_zone       = var.azs_publics[count.index]
  tags = {
    Name        = "${var.project_name}-public"
    Project     = var.project_name
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_private" {
  count                   = 2
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs_privates[count.index]
  map_public_ip_on_launch = "false"
  tags = {
    Name        = "${var.project_name}-private"
    Project     = var.project_name
    Environment = var.environment
  }
}

# Configure VPC Creation Module
module "vpc" {
  source           = "terraform-aws-modules/vpc/aws"
  name             = "${var.project_name}-vpc"
  cidr             = var.cidr_block
  create_igw       = false
  instance_tenancy = var.instance_tenancy

  azs                  = [var.azs_public, var.azs_private]
  enable_nat_gateway   = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Terraform   = "true"
    Environment = var.environment
    Project     = var.project_name
  }
}

# Create Internet Gateway Config
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}

# Create Default Route
resource "aws_default_route_table" "route_table" {
  default_route_table_id = module.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}
