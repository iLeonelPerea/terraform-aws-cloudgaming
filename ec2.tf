# Create the EC2 Instance
resource "aws_instance" "ec2-g4-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.instance_policy.name
  
  subnet_id              = aws_subnet.subnet_public[0].id
  availability_zone      = var.azs_public
  vpc_security_group_ids = [aws_security_group.ec2-g4-sg.id]

  root_block_device {
    volume_size           = "120"
    volume_type           = "gp2"
    delete_on_termination = true
  }

  tags = {
    Name        = "${var.environment}-server"
    Environment = var.environment
  }
}

# Define the security group for the instance
resource "aws_security_group" "ec2-g4-sg" {
  name        = "${var.environment}-sg"
  description = "Allow incoming traffic to EC2 Instance"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming DCV connections"
  }

  ingress {
    from_port   = 8443
    to_port     = 8443
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming DCV connections"
  }

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming RDP connections"
  }

  ingress {
    from_port   = 27031
    to_port     = 27036
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming Steam UDP connections"
  }

  ingress {
    from_port   = 27036
    to_port     = 27037
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming Steam TCP connections"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-sg"
    Environment = var.environment
  }
}

resource "aws_iam_instance_profile" "instance_policy" {
  name = "instance_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "instance_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
