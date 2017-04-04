#
# Provision failover server
#
resource "aws_instance" "ghe-failover-server" {
  ami = "${lookup(var.ami_map, "${var.aws_region}-${var.ghe_version}")}"
  count = "${var.server_count}"
  instance_type = "${var.aws_flavor}"
  associate_public_ip_address = "${var.public_ip}"
  availability_zone = "${var.failover_az}"
  subnet_id = "${var.aws_failover_subnet_id}"
  vpc_security_group_ids = ["${aws_security_group.ghe-server.id}"]
  key_name = "${var.aws_key_name}"
  user_data = "${file("userdata.sh")}"
  iam_instance_profile = "github_instance_profile2"
  tags = {
    Name = "${var.failover_dns_name}"
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

# failover server EIP
resource "aws_eip" "failover_eip" {
  instance = "${aws_instance.ghe-failover-server.id}"
  vpc = true
}

# DNS entry in route53
resource "aws_route53_record" "failover-server-dns" {
  zone_id         = "${var.dns_zone_id}"
  name            = "${var.failover_dns_name}"
  type            = "A"
  ttl             = "300"
  records         = ["${aws_eip.failover_eip.public_ip}"]
}