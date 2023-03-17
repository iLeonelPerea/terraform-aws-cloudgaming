# Generate SSH Key pair for connection to bastian host
# https://www.terraform.io/docs/providers/aws/r/key_pair.html
resource "tls_private_key" "ssh_key" {
  algorithm     = "RSA"
  rsa_bits      = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name      = var.key_name
  public_key    = tls_private_key.ssh_key.public_key_openssh
  tags = {
    Project     = var.project_name
    Environment = var.environment
  }
}