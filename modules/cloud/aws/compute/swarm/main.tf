terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.5"
    }
    local = {
      source = "hashicorp/local"
      version = "2.5.1"
    }
    github = {
      source = "integrations/github"
      version = "6.2.1"
    }
  }
}

data "aws_vpc" "main" { 
  filter {
    name = "isDefault"
    values = ["true"] 
  }
}

data "aws_subnets" "main_subnets" { 
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.main.id] 
  }
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer_key" {
  key_name   = "swarm-key"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_sensitive_file" "private_key" {
  filename        = var.private_key_path
  content         = tls_private_key.rsa.private_key_pem
  file_permission = "0400"
}

data "aws_ami" "amazon_linux_docker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-linux-docker*"]
  }
  # owners = ["AWS_ACC_ID_UNSET"]
  # find with aws cli: aws sts get-caller-identity
  owners = ["447130666878"]
}

resource "aws_security_group" "swarm_sg" {
  description    = "launch-wizard-2 created 2024-04-17T22:18:12.426Z"
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    },
  ]
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 4000
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 4000
    },
  ]
  tags        = {}
  tags_all    = {}
  # vpc_id    = "vpc-0021bbe35d223bc80"
  vpc_id      = data.aws_vpc.main.id
}

resource "aws_instance" "belly_swarm" {
  # ami               = "ami-0d421d84814b7d51c"
  ami               = data.aws_ami.amazon_linux_docker.id
  availability_zone = "eu-west-1b"
  key_name          = aws_key_pair.deployer_key.key_name
  subnet_id         = data.aws_subnets.main_subnets.ids[1]
  user_data         = <<-EOF
              #!/bin/bash

              docker swarm init
              EOF
  instance_type     = "t2.micro"
  tags = {
    "Name" = "docker-swarm-manager"
  }
  vpc_security_group_ids  = [
    aws_security_group.swarm_sg.id,
  ]
}

output "ssh_command" {
  value       = "ssh -i ${var.private_key_path} ec2-user@${aws_instance.belly_swarm.public_ip}"
  description = "The SSH command to connect to the instance."
}