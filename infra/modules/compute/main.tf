data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (Ubuntu's official AWS account)
}

resource "aws_security_group" "ec2_sg" {
  name        = "${var.project}-app-instance"
  description = "Security group for app instance"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow SSH from the load balancer security group"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [var.lb_sg]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Generate SSH key pair locally
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Store the private key locally
resource "local_file" "private_key" {
  filename        = "${path.module}/keys/${var.project}-key.pem"
  content         = tls_private_key.ssh_key.private_key_pem
  file_permission = "0600"
}

# Create the key pair in AWS
resource "aws_key_pair" "key_pair" {
  key_name   = "${var.project}-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  depends_on = [local_file.private_key]
}

resource "aws_instance" "app_instance" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id #aws_subnet.public_subnets[0].id
  security_groups             = [aws_security_group.ec2_sg.id]
  key_name                    = aws_key_pair.key_pair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "${var.project}-app-instance"
  }
}