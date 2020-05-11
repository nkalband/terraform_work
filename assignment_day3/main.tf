#Setting up aws provider  credentials
provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

#Create random 4 byte log hex suffix
resource "random_id" "hex_suffix" {
  byte_length = 4
}

#create aws key pair using sshe key
resource "aws_key_pair" "deployer" {
  key_name     = "deployer_key"
  public_key   = "${file("~/.ssh/id_rsa.pub")}"
}

#create security group to enable ssh and http
resource "aws_security_group" "enable-ssh-http" {
  name        = "enable-ssh-http"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

#Create ec2 server instance
resource "aws_instance" "server" {
  ami               = var.image
  availability_zone = var.availability_zone
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.deployer.key_name
  security_groups   = ["${aws_security_group.enable-ssh-http.name}"]

  tags = {
    Name = "server-${random_id.hex_suffix.hex}"
  }
}

#Create volume
resource "aws_ebs_volume" "new_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  tags = {
    Name = "${var.prefix}-volume"
  }
}

#attatch volume to server instance
resource "aws_volume_attachment" "ebs_vol_att" {
  device_name  = "/dev/sdh"
  volume_id    = aws_ebs_volume.new_volume.id
  instance_id  = aws_instance.server.id
}