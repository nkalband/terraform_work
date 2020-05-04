provider "openstack" {
}



variable "user"{
}

resource "random_password" "password" {
  length           = 8
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
  special          = true
  override_special = "!#$%&"
}
output "cred_details" {
  value = "Hi ${var.user}, your password ${random_password.password.result}"

}

