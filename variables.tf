# https://www.terraform.io/docs/configuration/variables.html

# Project Config
variable "project_name" {}
variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}

# AWS Config
variable "aws_profile" {
  default = "default"
}
variable "aws_region" {
  default = "us-west-1"
}

## VPC/Network Config
variable "cidr_block" {
  default = "10.10.10.0/24"
}
variable "azs_public" {
  default = "us-west-1a"
}
variable "azs_private" {
  default = "us-west-1c"
}
variable "azs_publics" {
  default = ["us-west-1a", "us-west-1c"]
}
variable "azs_privates" {
  default = ["us-west-1a", "us-west-1c"]
}
variable "private_subnets" {
  default = ["10.10.10.32/27", "10.10.10.64/27"]
}
variable "public_subnets" {
  default = ["10.10.10.96/27", "10.10.10.128/27"]
}

# A tenancy option for instances launched into the VPC.
# Default is default, which makes your instances shared on the host.
# Using either of the other options (dedicated or host) costs at least $2/hr.
variable "instance_tenancy" {
  default = "default"
}
## Bastian Host Config
## NOTE: If you change the ami it is possible the user will change, i.e make sure to update the default `user` variable to reflect your change.
variable "ami" {
  default = "ami-07e7476233accc856" # Amazon Nice DCV
}
variable "instance_type" {
  default = "g4dn.xlarge"
}
variable "key_name" {
  default = "gaming_key"
}
variable "environment" {
  default = "gaming"
}