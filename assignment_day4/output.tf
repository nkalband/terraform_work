#output to dispaly details of ip
output "instance_ip" {
  depends_on = [
    aws_volume_attachment.ebs_vol_att,
  ]
  value = "Hi your instance ip is ${aws_instance.server.public_ip}"
}