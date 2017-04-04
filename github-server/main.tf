resource "aws_iam_instance_profile" "github_instance_profile" {
  name = "github_instance_profile2"
  roles = ["${aws_iam_role.github_base.name}"]
}

resource "aws_iam_role" "github_base" {
  name = "github_base"
  assume_role_policy = <<-EOF
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Action": "sts:AssumeRole",
              "Principal": {"Service": "ec2.amazonaws.com"},
              "Effect": "Allow",
              "Sid": "AllowAssumeRole"
          }
      ]
  }
  EOF
}

resource "aws_iam_role_policy" "github_role_policy" {
  name = "github_role_policy"
  role = "${aws_iam_role.github_base.id}"
  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": "${aws_iam_role.github_base.arn}"
    }
    ]
  }
  EOF
}

resource "aws_iam_policy_attachment" "iam_ecr_attach" {
  name = "iam_ecr_attach"
  roles = ["${aws_iam_role.github_base.name}"]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}

# GHE Server security group - https://help.github.com/enterprise/2.5/admin/guides/installation/network-ports-to-open/
resource "aws_security_group" "ghe-server" {
  name = "${var.primary_dns_name} sg"
  description = "GitHub Enterprise"
  vpc_id = "${var.aws_vpc_id}"
  tags = {
    Name = "${var.primary_dns_name} sg"
    Description = "${var.tag_description}"
    Role = "${var.tag_role}"
    Team = "${var.tag_team}"
    Application = "${var.tag_application}"
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
  cidr_blocks = ["${split(",", var.allowed_admin_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTP
resource "aws_security_group_rule" "ghe-server_allow_80_tcp" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTP @ 8080
resource "aws_security_group_rule" "ghe-server_allow_8080_tcp" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTPS
resource "aws_security_group_rule" "ghe-server_allow_443_tcp" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# HTTPS @ 8443
resource "aws_security_group_rule" "ghe-server_allow_8443_tcp" {
  type = "ingress"
  from_port = 8443
  to_port = 8443
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_admin_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# GIT
resource "aws_security_group_rule" "ghe-server_allow_9418_tcp" {
  type = "ingress"
  from_port = 9418
  to_port = 9418
  protocol = "tcp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
# VPN
resource "aws_security_group_rule" "ghe-server_allow_1194_udp" {
  type = "ingress"
  from_port = 1194
  to_port = 1194
  protocol = "udp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
  security_group_id = "${aws_security_group.ghe-server.id}"
}
## NTP
resource "aws_security_group_rule" "ghe-server_allow_123_udp" {
  count = "${var.sgrule_ntp}"
  type = "ingress"
  from_port = 123
  to_port = 123
  protocol = "udp"
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
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
  cidr_blocks = ["${split(",", var.allowed_cidrs)}"]
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
data "template_file" "attributes-json" {
  template    = "${file("${path.module}/files/attributes-json.tpl")}"
  vars {
    host      = "${var.hostname}"
    domain    = "${var.domain}"
  }
}
#
# Provision server
#
resource "aws_instance" "ghe-server" {
  ami = "${lookup(var.ami_map, "${var.aws_region}-${var.ghe_version}")}"
  count = "${var.server_count}"
  instance_type = "${var.aws_flavor}"
  associate_public_ip_address = "${var.public_ip}"
  availability_zone = "${var.primary_az}"
  subnet_id = "${var.aws_primary_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ghe-server.id}"]
  key_name = "${var.aws_key_name}"
  user_data = "${file("userdata.sh")}"
  iam_instance_profile = "github_instance_profile2"
  tags = {
    Name = "${var.primary_dns_name}"
    Description = "${var.tag_description}"
    Role = "${var.tag_role}"
    Team = "${var.tag_team}"
    Application = "${var.tag_application}"
    Environment = "${var.tag_environment}"
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
    volume_size = "${var.data_volume_size}"
    delete_on_termination = true
    encrypted = true
  }
  connection {
    host = "${self.public_ip}"
    user = "${var.ami_user}"
    private_key = "${file("~/Downloads/github-enterprise.pem")}"
    port = 122
  }
  # Setup directories
  provisioner "remote-exec" {
    inline = [
      "mkdir -p ~/.ghe"
    ]
  }
  
}
data "template_file" "ghe-server-creds" {
  template = "${file("${path.module}/files/ghe-server-creds.tpl")}"
  vars {
    pass = "${base64sha256(aws_instance.ghe-server.id)}"
    fqdn = "${aws_instance.ghe-server.tags.Name}"
  }
}
