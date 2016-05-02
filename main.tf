# GHE Server security group - https://help.github.com/enterprise/2.5/admin/guides/installation/network-ports-to-open/
resource "aws_security_group" "ghe-server" {
  name = "${var.hostname}.${var.domain} sg"
  description = "GitHub Enterprise"
  vpc_id = "${var.aws_vpc_id}"
  tags = {
    Name = "${var.hostname}.${var.domain} sg"
  }
}
# SSH - for git
resource "aws_security_group_rule" "ghe-server_allow_22_tcp" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_commit_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# SSH - for instance
resource "aws_security_group_rule" "ghe-server_allow_122_tcp" {
  type = "ingress"
  from_port = 122
  to_port = 122
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTP
resource "aws_security_group_rule" "ghe-server_allow_80_tcp" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTP @ 8080
resource "aws_security_group_rule" "ghe-server_allow_8080_tcp" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTPS
resource "aws_security_group_rule" "ghe-server_allow_443_tcp" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTPS @ 8443
resource "aws_security_group_rule" "ghe-server_allow_8443_tcp" {
  type = "ingress"
  from_port = 8443
  to_port = 8443
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# GIT
resource "aws_security_group_rule" "ghe-server_allow_9418_tcp" {
  type = "ingress"
  from_port = 9418
  to_port = 9418
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# VPN
resource "aws_security_group_rule" "ghe-server_allow_1194_udp" {
  type = "ingress"
  from_port = 1194
  to_port = 1194
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
## NTP
resource "aws_security_group_rule" "ghe-server_allow_123_udp" {
  count = "${var.sgrule_ntp}"
  type = "ingress"
  from_port = 123
  to_port = 123
  protocol = "udp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# SNMP
resource "aws_security_group_rule" "ghe-server_allow_161_udp" {
  count = "${var.sgrule_snmp}"
  type = "ingress"
  from_port = 161
  to_port = 161
  protocol = "udp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# SMTP
resource "aws_security_group_rule" "ghe-server_allow_25_tcp" {
  count = "${var.sgrule_smtp}"
  type = "ingress"
  from_port = 25
  to_port = 25
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# Egress: ALL
resource "aws_security_group_rule" "ghe-server_allow_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}
resource "template_file" "attributes-json" {
  template    = "${file("${path.module}/files/attributes-json.tpl")}"
  vars {
    chef_fqdn = "${var.chef_fqdn}"
    chef_org  = "${var.chef_org}"
    host      = "${var.hostname}"
    domain    = "${var.domain}"
  }
}
#
# Wait on
#
resource "null_resource" "wait_on" {
  provisioner "local-exec" {
    command = "echo Waited on ${var.wait_on} before proceeding"
  }
}
#
# Provision server
#
resource "aws_instance" "ghe-server" {
  depends_on = ["null_resource.wait_on"]
  ami = "${lookup(var.ami_map, "${var.aws_region}-${var.ghe_version}")}"
  count = "${var.server_count}"
  instance_type = "${var.aws_flavor}"
  associate_public_ip_address = "${var.public_ip}"
  subnet_id = "${var.aws_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ghe-server.id}"]
  key_name = "${var.aws_key_name}"
  tags = {
    Name = "${var.hostname}.${var.domain}"
  }
  root_block_device = {
    delete_on_termination = "${var.root_delete_termination}"
    volume_size = "${var.root_volume_size}"
    volume_type = "${var.root_volume_type}"
    tags = {
      Name        = "${var.hostname}.${var.domain}"
      Description = "${var.tag_description}"
    }
  }
  # seperate device for GHE to use at /data
  ebs_block_device {
    device_name = "/dev/xvdg"
    volume_type = "gp2"
    volume_size = 10
    delete_on_termination = true
    encrypted = true
  }
  connection {
    host = "${self.public_ip}"
    user = "${var.ami_user}"
    private_key = "${var.aws_private_key_file}"
    port = 122
  }
  # Setup directories
  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ghe"
    ]
  }
  # Ensure previous invocations are dead to us
  provisioner "local-exec" {
    command = "knife node-delete   ${var.hostname}.${var.domain} -y -c ${var.knife_rb} ; echo OK"
  }
  provisioner "local-exec" {
    command = "knife client-delete ${var.hostname}.${var.domain} -y -c ${var.knife_rb} ; echo OK"
  }
  # Provision with Chef
  provisioner "chef" {
    attributes_json = "${template_file.attributes-json.rendered}"
    run_list        = ["system::default","recipe[chef-client::default]","recipe[chef-client::config]","recipe[chef-client::cron]","recipe[chef-client::delete_validation]"]
    log_to_file     = "${var.log_to_file}"
    node_name       = "${var.hostname}.${var.domain}"
    server_url      = "https://${var.chef_fqdn}/organizations/${var.chef_org}"
    validation_client_name = "${var.chef_org}-validator"
    validation_key  = "${file("${var.chef_org_validator}")}"
    version         = "${var.client_version}"
  }
  # Hostname issues... rebooting
  provisioner "remote-exec" {
    inline = [
      "sudo reboot"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sleep 10 && echo 'ready'"
    ]
  }
}
resource "template_file" "ghe-server-creds" {
  template = "${file("${path.module}/files/ghe-server-creds.tpl")}"
  vars {
    pass = "${base64sha256(aws_instance.ghe-server.id)}"
    fqdn = "${aws_instance.ghe-server.tags.Name}"
  }
}
resource "null_resource" "ghe-configure" {
  depends_on = ["aws_instance.ghe-server"]
  # Use the API to setup the rest from JSON file
  provisioner "local-exec" {
    command = "sleep 5 && curl -kLs --resolve ${aws_instance.ghe-server.tags.Name}:8443:${aws_instance.ghe-server.public_ip} -X POST 'https://${aws_instance.ghe-server.tags.Name}:8443/setup/api/start' -F license=@${var.ghe_license} -F 'password=${base64sha256(aws_instance.ghe-server.id)}' -F 'settings=<${var.ghe_settings}'"
  }
  # Tell GHE to start configuring
  provisioner "local-exec" {
    command = "sleep 2 && curl -kLs --resolve ${aws_instance.ghe-server.tags.Name}:8443:${aws_instance.ghe-server.public_ip} -X POST 'https://api_key:${replace(base64sha256(aws_instance.ghe-server.id), "/", "%2F")}@${aws_instance.ghe-server.tags.Name}:8443/setup/api/configure'"
  }
  # Check configuration status
  provisioner "local-exec" {
    command = "sleep 2 && curl -kLs --resolve ${aws_instance.ghe-server.tags.Name}:8443:${aws_instance.ghe-server.public_ip} -X GET 'https://api_key:${replace(base64sha256(aws_instance.ghe-server.id), "/", "%2F")}@${aws_instance.ghe-server.tags.Name}:8443/setup/api/configcheck'"
  }
}

