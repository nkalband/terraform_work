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
  default     = "ami-0a54aef4ef3b5f881"
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