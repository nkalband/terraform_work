#output to dispaly details of user creds
output "cred_details" {
  value = "Hi ${var.user}, your password is ${random_password.password.result}"
}
