# Define provider specs
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.aws_region
  profile    = var.aws_profile
}