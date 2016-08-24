provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.aws_region}"
}

# EIP required since NetScaler rule must allow admin ssh access to backup server
resource "aws_eip" "backup-server-ip" {
  instance = "${aws_instance.ghe-backup-server.id}"
  vpc = true
}

# GHE Backup Utilities Server security group
resource "aws_security_group" "ghe-backup-server" {
  name = "${var.dns_name} sg"
  description = "GitHub Enterprise"
  vpc_id = "${var.aws_vpc_id}"
  tags = {
    Name = "${var.dns_name} sg"
    Description = "${var.tag_description}"
    Role = "${var.tag_role}"
    Team = "${var.tag_team}"
    Application = "${var.tag_application}"
  }
}
# SSH - for git
resource "aws_security_group_rule" "ghe-backup-server_allow_22_tcp" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_commit_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-backup-server.id}"
}

# Egress: ALL
resource "aws_security_group_rule" "ghe-backup-server_allow_all" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.ghe-backup-server.id}"
}

#
# Provision server
#
resource "aws_instance" "ghe-backup-server" {
  ami = "${lookup(var.backup_ami_map, "${var.aws_region}")}"
  count = "${var.server_count}"
  instance_type = "${var.aws_flavor}"
  associate_public_ip_address = "${var.public_ip}"
  subnet_id = "${var.aws_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ghe-backup-server.id}"]
  key_name = "${var.aws_key_name}"
  tags = {
    Name = "${var.dns_name}"
    Description = "${var.tag_description}"
    Role = "${var.tag_role}"
    Team = "${var.tag_team}"
    Application = "${var.tag_application}"
  }
  root_block_device = {
    delete_on_termination = "${var.root_delete_termination}"
    volume_size = "${var.root_volume_size}"
    volume_type = "${var.root_volume_type}"
  }
  # seperate device for GHE to use at /data
  ebs_block_device {
    device_name = "/dev/xvdg"
    volume_type = "gp2"
    volume_size = "${var.data_volume_size*5}"
    delete_on_termination = true
    encrypted = true
  }
  connection {
    host = "${self.public_ip}"
    user = "${var.ami_user}"
    private_key = "${var.aws_private_key_file}"
    port = 122
  }
}

resource "aws_route53_record" "github-backup" {
  zone_id = "${var.dns_zone_id}"
  name    = "${var.dns_name}"
  type    = "A"
  ttl     = "300"
  records = [ "${aws_instance.ghe-backup-server.public_ip}" ]
  depends_on = ["aws_instance.ghe-backup-server"]
}
