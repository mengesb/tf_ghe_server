# Outputs
output "credentials" {
  value = "${template_file.ghe-server-creds.rendered}"
}
output "fqdn" {
  value = "${aws_instance.ghe-server.tags.Name}"
}
output "private_ip" {
  value = "${aws_instance.ghe-server.private_ip}"
}
output "public_ip" {
  value = "${aws_eip.ghe-server-ip.public_ip}"
}
output "security_group_id" {
  value = "${aws_security_group.ghe-server.id}"
}

