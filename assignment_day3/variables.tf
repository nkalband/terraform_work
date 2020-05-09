variable "prefix"{
  type        = string
  description = "prefix string to use"
  default     = "Nikhil"
}

variable "region"{
  type        = string
  default     = "us-east-2"
  description = "The region for aws cloud"
}

variable "availability_zone"{
  type        = string
  default     = "us-east-2b"
  description = "The availability zone for aws cloud"
}

variable "volume_size"{
  type        = number
  default     = "1"
  description = "The size of volume to be created"
}

variable "image"{
  type        = string
  default     = "ami-07c1207a9d40bc3bd"
  description = "The aws image id to created ec2 instance"
}

variable "access_key"{
  type        = string
  default     = ""
  description = "The access key for aws cloud"
}

variable "secret_key"{
  type        = string
  default     = ""
  description = "The secret key for aws cloud"
}

variable "public_key"{
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDd9pYTxQdFzjq8W/Ez/RFB6WxI49IWFzNMQ5T/vUhD5P0OgkznsG1nW2cYUjS4eEeeYge72yPgSyjgdO8u6/vLFHUoJyMeVT2tQ0OS1pugOyXbghzIYoHrKJVcdDbE48GpQVIvS7573WDq03OVwLajwAcL+CPtjN0TFka0kNIobS1UiBGa/96uytbUGZ17ciBJjHazStnnBtKfjjP8b5Rk+9rTa9xPIIFH+Gzjj6yfRMJ/FOtplPRTvW3yRd9G/mAcEwd4gOnnK2BOavhT642w1V49cwyPanYZFWNO7/N4wlYJTLfySNUT87Cm0bmS3AjdLEUOjnIDXXb2HHpBCw0v ubuntu@ip-172-31-46-28"
  description = "The ssh public key to generate key pair"
}
