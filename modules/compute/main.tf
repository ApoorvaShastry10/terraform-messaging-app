resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "key"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ${path.module}/key.pem && chmod 0700 ${path.module}/key.pem"
  }
}

resource "aws_launch_template" "app" {
  name          = "app-launch-config"
  image_id      = "ami-0d53d72369335a9d6" # Replace with your AMI ID
  instance_type = "t2.micro"
  key_name              = aws_key_pair.key_pair.key_name
  # vpc_security_group_ids  = var.security_group_ids
 

  network_interfaces {
    security_groups = var.security_group_ids
    associate_public_ip_address = true
  }


  user_data = base64encode(<<-EOT
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y httpd
              sudo systemctl start httpd
              sudo systemctl enable httpd
              EOT
  )
}

resource "aws_autoscaling_group" "app" {
  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
  min_size             = 2
  max_size             = 5
  desired_capacity     = 2
  vpc_zone_identifier  = var.subnet_ids
}
