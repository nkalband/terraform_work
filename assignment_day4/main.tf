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

#---------------------------------
#Day 4 Assignment code additions

#null resource to copy index.html file and setup http service
resource "null_resource" "setup_http" {
  connection {
    host = aws_instance.server.public_ip
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("~/.ssh/id_rsa")}"
  }
  
  provisioner "file" {
    source      = "index.html"
    destination = "/tmp/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo cp /tmp/index.html /var/www/html/index.html",
    ]
  }
}

#To print html out from index.html
data "http" "index_output" {
  depends_on = [
    null_resource.setup_http,
  ]
  url = "http://${aws_instance.server.public_ip}:80"   
}
