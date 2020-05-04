#resource to generate random passowrd for user
resource "random_password" "password" {
  length           = 8
  min_upper        = 1
  min_lower        = 1
  min_special      = 1
  special          = true
  override_special = "!#$%&"
}
