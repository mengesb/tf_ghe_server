# Outputs
output "credentials" {
  value = "${data.template_file.ghe-server-creds.rendered}"
}
output "fqdn" {
  value = "${aws_instance.ghe-server.tags.Name}"
}
output "primary_public_ip" {
	value = "${aws_instance.ghe-server.public_ip}"
}
output "primarcy_private_ip" {
  value = "${aws_instance.ghe-server.private_ip}"
}
output "security_group_id" {
  value = "${aws_security_group.ghe-server.id}"
}
output "failover_public_ip" {
  value = "${aws_instance.ghe-failover-server.public_ip}"
}
output "failover_private_ip" {
	value = "${aws_instance.ghe-failover-server.private_ip}"
}