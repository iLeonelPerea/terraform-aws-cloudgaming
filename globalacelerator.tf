resource "aws_globalaccelerator_accelerator" "globalaccelerator" {
  name            = "${var.environment}-globalaccelerator"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "globalaccelerator_listener_1" {
  accelerator_arn = aws_globalaccelerator_accelerator.globalaccelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 8443
    to_port   = 8443
  }
}

resource "aws_globalaccelerator_listener" "globalaccelerator_listener_2" {
  accelerator_arn = aws_globalaccelerator_accelerator.globalaccelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "UDP"

  port_range {
    from_port = 8443
    to_port   = 8443
  }
}

resource "aws_globalaccelerator_listener" "globalaccelerator_listener_3" {
  accelerator_arn = aws_globalaccelerator_accelerator.globalaccelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 3389
    to_port   = 3389
  }
}

resource "aws_globalaccelerator_listener" "globalaccelerator_listener_4" {
  accelerator_arn = aws_globalaccelerator_accelerator.globalaccelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "UDP"

  port_range {
    from_port = 27031
    to_port   = 27036
  }
}

resource "aws_globalaccelerator_listener" "globalaccelerator_listener_5" {
  accelerator_arn = aws_globalaccelerator_accelerator.globalaccelerator.id
  client_affinity = "SOURCE_IP"
  protocol        = "TCP"

  port_range {
    from_port = 27036
    to_port   = 27037
  }
}

resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_1" {
  listener_arn = aws_globalaccelerator_listener.globalaccelerator_listener_1.id

  endpoint_configuration {
    endpoint_id = aws_instance.ec2-g4-instance.arn
    client_ip_preservation_enabled = true
    weight      = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_2" {
  listener_arn = aws_globalaccelerator_listener.globalaccelerator_listener_2.id

  endpoint_configuration {
    endpoint_id = aws_instance.ec2-g4-instance.arn
    client_ip_preservation_enabled = true
    weight      = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_3" {
  listener_arn = aws_globalaccelerator_listener.globalaccelerator_listener_3.id

  endpoint_configuration {
    endpoint_id = aws_instance.ec2-g4-instance.arn
    client_ip_preservation_enabled = true
    weight      = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_4" {
  listener_arn = aws_globalaccelerator_listener.globalaccelerator_listener_4.id

  endpoint_configuration {
    endpoint_id = aws_instance.ec2-g4-instance.arn
    client_ip_preservation_enabled = true
    weight      = 100
  }
}

resource "aws_globalaccelerator_endpoint_group" "globalaccelerator_endpoint_5" {
  listener_arn = aws_globalaccelerator_listener.globalaccelerator_listener_5.id

  endpoint_configuration {
    endpoint_id = aws_instance.ec2-g4-instance.arn
    client_ip_preservation_enabled = true
    weight      = 100
  }
}