#
# AWS provider specific configs
#
variable "aws_access_key" {
  description = "Your AWS key (ex. $AWS_ACCESS_KEY_ID)"
}
variable "aws_flavor" {
  description = "AWS Instance type to deploy"
  default     = "r3.large"
}
variable "aws_key_name" {
  description = "Name of the key pair uploaded to AWS"
}
variable "aws_private_key_file" {
  description = "Full path to your local private key"
}
variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-west-1"
}
variable "aws_secret_key" {
  description = "Your AWS secret (ex. $AWS_SECRET_ACCESS_KEY)"
}
variable "aws_subnet_id" {
  description = "AWS Subnet id (ex. subnet-ffffffff)"
}
variable "aws_vpc_id" {
  description = "AWS VPC id (ex. vpc-ffffffff)"
}
#
# AMI mapping
#
variable "ami_map" {
  description = "AMI mapping for GHE 2.5.1 installation based on AWS region"
  default = {
    ap-northeast-1-2.5.2 = "ami-4fe8e021"
    ap-northeast-2-2.5.2 = "ami-7c804912"
    ap-southeast-1-2.5.2 = "ami-b7d912d4"
    ap-southeast-2-2.5.2 = "ami-e4795987"
    eu-central-1-2.5.2   = "ami-dc9c7bb3"
    eu-west-1-2.5.2      = "ami-f6bc0685"
    sa-east-1-2.5.2      = "ami-6c6be600"
    us-east-1-2.5.2      = "ami-f41f1e9e"
    us-west-1-2.5.2      = "ami-5e3d4f3e"
    us-west-2-2.5.2      = "ami-feb25b9e"
    us-gov-west-1-2.5.2  = "ami-a866dac9"
    ap-northeast-1-2.5.1 = "ami-eb5d5e85"
    ap-northeast-2-2.5.1 = "-1"
    ap-southeast-1-2.5.1 = "ami-7f00c91c"
    ap-southeast-2-2.5.1 = "ami-2b331548"
    eu-central-1-2.5.1   = "ami-d5e3f9b9"
    eu-west-1-2.5.1      = "ami-dad06ca9"
    sa-east-1-2.5.1      = "ami-dae765b6"
    us-east-1-2.5.1      = "ami-905361fa"
    us-west-1-2.5.1      = "ami-63245403"
    us-west-2-2.5.1      = "ami-7828ca18"
    us-gov-west-1-2.5.1  = "ami-8ba71bea"
    ap-northeast-1-2.5.0 = "ami-43292d2d"
    ap-northeast-2-2.5.0 = "-1"
    ap-southeast-1-2.5.0 = "ami-bee729dd"
    ap-southeast-2-2.5.0 = "ami-7c25021f"
    eu-central-1-2.5.0   = "ami-0d110a61"
    eu-west-1-2.5.0      = "ami-3f81314c"
    sa-east-1-2.5.0      = "ami-c9e261a5"
    us-east-1-2.5.0      = "ami-298ba043"
    us-west-1-2.5.0      = "ami-e79ee887"
    us-west-2-2.5.0      = "ami-4b62832b"
    us-gov-west-1-2.5.0  = "ami-04e15d65"
  }
}
variable "ami_user" {
  description = "AWS AMI default username"
  default = "admin"
}
variable "ghe_version" {
  description = "GitHub Enterprise version (https://enterprise.github.com/releases)"
  default = "2.5.2"
}
#
# specific configs
#
variable "allowed_cidrs" {
  description = "List of CIDRs to allow access from"
  default = "0.0.0.0/0"
}
variable "allowed_commit_cidrs" {
  description = "List of CIDRs to allow commit access from"
  default = "0.0.0.0/0"
}
variable "chef_fqdn" {
  description = "Fully qualified DNS address of the Chef Server"
}
variable "chef_org" {
  description = "Chef Server organization short name (lowercase alphanumeric characters only)"
}
variable "chef_org_validator" {
  descirption = "Path to validation pem for ${var.chef_org}"
}
#variable "chef_sg" {
#  description = "Chef Server security group id"
#}
variable "domain" {
  description = "Domain name of the server created"
  default = "localdomain"
}
variable "ghe_license" {
  description = "Path to GHE license file (.ghl)"
}
variable "ghe_settings" {
  description = "GitHub Enterprise settings file (JSON)"
}
variable "hostname" {
  description = "Basename for AWS Name tag of CHEF Server"
  default = "ghe-01"
}
variable "r53" {
  description = "Boolean: Use Route53?"
  default = 0
}
variable "r53_ttl" {
  description = "Route53 A record TTL (Default: 180)"
  default     = 180
}
variable "r53_zone_internal_id" {
  description = "Route53 zone id for internal DNS"
  default     = 0
}
variable "r53_zone_id" {
  description = "Route53 Zone ID"
  default = 0
}
variable "server_count" {
  description = "Number of CHEF Servers to provision. DO NOT CHANGE!"
  default = 1
}
variable "sgrule_ntp" {
  description = "Boolean: Allow NTP server security group rule"
  default     = 0
}
variable "sgrule_smtp" {
  description = "Boolean: Allow SMTP server security group rule"
  default     = 0
}
variable "sgrule_snmp" {
  description = "Boolean: Allow SNMP server security group rule"
  default     = 0
}
#variable "ssl_cert" {
#  description = "SSL Certificate in PEM format"
#}
#variable "ssl_key" {
#  description = "Key for SSL Certificate"
#}
variable "tag_description" {
  description = "AWS description tag text"
  default     = "Created using Terraform (tf_chef_server)"
}

