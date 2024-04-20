# in modules/cloud/aws/compute/swarm/main.tf

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


data "aws_ami" "amazon_linux_docker" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amazon-linux-docker*"]
  }
  # find with aws cli: aws sts get-caller-identity
  owners = ["447130666878"]
}

resource "tls_private_key" "rsa" { 
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "private_key" {
  content         = tls_private_key.rsa.private_key_pem
  filename        = var.private_key_path
  file_permission = "0400"
}

resource "aws_key_pair" "deployer_key" {
  key_name = "swarm-key-us-west"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "aws_instance" "belly_swarm" {
  ami                                 = data.aws_ami.amazon_linux_docker.id
  key_name                            = aws_key_pair.deployer_key.key_name
  subnet_id                           = data.aws_subnets.main_subnets.ids[1]
  instance_type                       = "t2.micro"
  availability_zone                   = "us-west-1c"
  tags                                = {
    "Name" = "docker-swarm-manager"
  }
  associate_public_ip_address          = true
  vpc_security_group_ids               = [
      aws_security_group.swarm_sg.id,
  ]
  user_data                             = <<-EOF
    #!/bin/bash
    docker swarm init
  EOF
}

resource "aws_security_group" "swarm_sg" {
  description            = "launch-wizard-3 created 2024-04-20T01:34:25.804Z"
  name                   = "launch-wizard-3"
  tags                   = {}
  tags_all               = {}
  vpc_id                = data.aws_vpc.main.id
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
}