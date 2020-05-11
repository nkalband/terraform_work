#To print public of create ec2 instance
output "instance_ip" {
  depends_on = [
    aws_volume_attachment.ebs_vol_att,
  ]
  value        = "Hi your instance ip is ${aws_instance.server.public_ip}"  
  description  = "print public ip of server instance"
}

#Day 4 Assignment code additions
#To print index.html content
output "html_output" {
  depends_on = [
    http.index_output,
  ]
  value        = "Html page content  is ${data.http.index_output.body}" 
  description  = "print index.html content"
}