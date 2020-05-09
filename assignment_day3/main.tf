provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "random_id" "hex_suffix" {
  byte_length = 4
}

resource "aws_instance" "server" {
  ami               = var.image
  availability_zone = var.availability_zone
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.deployer.key_name

  tags = {
    Name = "server-${random_id.hex_suffix.hex}"
  }
}

resource "aws_ebs_volume" "new_volume" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  tags = {
    Name = "${var.prefix}-volume"
  }
}

resource "aws_volume_attachment" "ebs_vol_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.new_volume.id
  instance_id = aws_instance.server.id
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer_key"
  public_key = var.public_key
}
