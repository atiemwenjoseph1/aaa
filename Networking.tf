######## Networking ##########
resource "aws_vpc" "enoch" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "ENOCH"
  }
}

######## Public Subnet #####################
resource "aws_subnet" "epublic" {
  vpc_id                  = aws_vpc.enoch.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Enoch's Public subnet"
  }
}

######## Private Subnet #####################
resource "aws_subnet" "eprivate" {
  vpc_id                  = aws_vpc.enoch.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-west-2b"
  map_public_ip_on_launch = false
  tags = {
    Name = "Enoch's Private Subnet"
  }
}

resource "aws_security_group" "esecurity" {
  name        = "Enoch Security Group"
  description = "Example of security group"
  vpc_id      = aws_vpc.enoch.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

######### IGW ###########
resource "aws_internet_gateway" "eigw" {
  vpc_id = aws_vpc.enoch.id
}


output "vpc_name" {
  value = aws_vpc.enoch.id
}

output "vpc_igw" {
  value = aws_internet_gateway.eigw.id
}

output "vpc_sg" {
  value = aws_security_group.esecurity.id
}

resource "aws_instance" "Enoch" {
  ami           = "ami-095413544ce52437d"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.esecurity.id]
  subnet_id = aws_subnet.epublic.id
  tags = {
    Name = "Enoch Instance"
  }
  user_data = <<EOF
  #!/bin/bash
  sudo apt update && sudo apt upgrade -y
EOF
}

output "instance_name" {
  value = aws_instance.Enoch.id
}