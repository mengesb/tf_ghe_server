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
  description = "AMI mapping for GHE 2.x.y installation based on AWS region"
  default = {
    ap-northeast-1-2.6.3 = "ami-b83ed2d9"
    ap-northeast-2-2.6.3 = "ami-b3c60ddd"
    ap-southeast-1-2.6.3 = "ami-3966b75a"
    ap-southeast-2-2.6.3 = "ami-df0729bc"
    eu-central-1-2.6.3   = "ami-557b943a"
    eu-west-1-2.6.3      = "ami-d4f063a7"
    sa-east-1-2.6.3      = "ami-7eba3112"
    us-east-1-2.6.3      = "ami-595daf34"
    us-west-1-2.6.3      = "ami-c5d9a2a5"
    us-west-2-2.6.3      = "ami-7754ad17"
    us-gov-west-1-2.6.3  = "ami-e71fa086"

    ap-northeast-1-2.6.2 = "ami-2529c844"
    ap-northeast-2-2.6.2 = "ami-d0854ebe"
    ap-southeast-1-2.6.2 = "ami-7955831a"
    ap-southeast-2-2.6.2 = "ami-bf341bdc"
    eu-central-1-2.6.2   = "ami-05e10d6a"
    eu-west-1-2.6.2      = "ami-6d6bff1e"
    sa-east-1-2.6.2      = "ami-255fd749"
    us-east-1-2.6.2      = "ami-3fa24952"
    us-west-1-2.6.2      = "ami-54433b34"
    us-west-2-2.6.2      = "ami-5cba453c"
    us-gov-west-1-2.6.2  = "ami-aa4cf3cb"

    ap-northeast-1-2.6.1 = "ami-57b9a339"
    ap-northeast-2-2.6.1 = "ami-40448c2e"
    ap-southeast-1-2.6.1 = "ami-ca3deaa9"
    ap-southeast-2-2.6.1 = "ami-e2391581"
    eu-central-1-2.6.1   = "ami-ee779581"
    eu-west-1-2.6.1      = "ami-7264ec01"
    sa-east-1-2.6.1      = "ami-f545cc99"
    us-east-1-2.6.1      = "ami-8fc525e2"
    us-west-1-2.6.1      = "ami-7f146d1f"
    us-west-2-2.6.1      = "ami-9e897bfe"
    us-gov-west-1-2.6.1  = "ami-879d22e6"

    ap-northeast-1-2.6.0 = "ami-6eacb500"
    ap-northeast-2-2.6.0 = "ami-1a22ea74"
    ap-southeast-1-2.6.0 = "ami-516cb832"
    ap-southeast-2-2.6.0 = "ami-71fbd612"
    eu-central-1-2.6.0   = "ami-b97f9cd6"
    eu-west-1-2.6.0      = "ami-038b0570"
    sa-east-1-2.6.0      = "ami-db33bdb7"
    us-east-1-2.6.0      = "ami-74acb61e"
    us-west-1-2.6.0      = "ami-085f2168"
    us-west-2-2.6.0      = "ami-d3d525b3"
    us-gov-west-1-2.6.0  = "ami-b1b609d0"

    ap-northeast-1-2.5.8 = "ami-3939d558"
    ap-northeast-2-2.5.8 = "ami-6cdb1002"
    ap-southeast-1-2.5.8 = "ami-8166b7e2"
    ap-southeast-2-2.5.8 = "ami-b1022cd2"
    eu-central-1-2.5.8   = "ami-4a7b9425"
    eu-west-1-2.5.8      = "ami-aaf360d9"
    sa-east-1-2.5.8      = "ami-a7b833cb"
    us-east-1-2.5.8      = "ami-b75fadda"
    us-west-1-2.5.8      = "ami-49dfa429"
    us-west-2-2.5.8      = "ami-2c52ab4c"
    us-gov-west-1-2.5.8  = "ami-2f1ba44e"

    ap-northeast-1-2.5.7 = "ami-8225c4e3"
    ap-northeast-2-2.5.7 = "ami-ae874cc0"
    ap-southeast-1-2.5.7 = "ami-f857819b"
    ap-southeast-2-2.5.7 = "ami-ba341bd9"
    eu-central-1-2.5.7   = "ami-70e30f1f"
    eu-west-1-2.5.7      = "ami-6d15811e"
    sa-east-1-2.5.7      = "ami-0257df6e"
    us-east-1-2.5.7      = "ami-25a74c48"
    us-west-1-2.5.7      = "ami-a8423ac8"
    us-west-2-2.5.7      = "ami-5cb9463c"
    us-gov-west-1-2.5.7  = "ami-d44df2b5"

    ap-northeast-1-2.5.6 = "ami-adbea4c3"
    ap-northeast-2-2.5.6 = "ami-c84e86a6"
    ap-southeast-1-2.5.6 = "ami-303dea53"
    ap-southeast-2-2.5.6 = "ami-b53814d6"
    eu-central-1-2.5.6   = "ami-917193fe"
    eu-west-1-2.5.6      = "ami-7161e902"
    sa-east-1-2.5.6      = "ami-da4dc4b6"
    us-east-1-2.5.6      = "ami-cecb2ba3"
    us-west-1-2.5.6      = "ami-b5136ad5"
    us-west-2-2.5.6      = "ami-9a897bfa"
    us-gov-west-1-2.5.6  = "ami-659b2404"

    ap-northeast-1-2.5.5 = "ami-04b3aa6a"
    ap-northeast-2-2.5.5 = "ami-6b25ed05"
    ap-southeast-1-2.5.5 = "ami-bb64b0d8"
    ap-southeast-2-2.5.5 = "ami-2bfbd648"
    eu-central-1-2.5.5   = "ami-7f7e9d10"
    eu-west-1-2.5.5      = "ami-03f57b70"
    sa-east-1-2.5.5      = "ami-5c37b930"
    us-east-1-2.5.5      = "ami-17b2a87d"
    us-west-1-2.5.5      = "ami-ff5d239f"
    us-west-2-2.5.5      = "ami-cfef1faf"
    us-gov-west-1-2.5.5  = "ami-6bb7080a"

    ap-northeast-1-2.5.4 = "ami-daecfab4"
    ap-northeast-2-2.5.4 = "ami-05fb326b"
    ap-southeast-1-2.5.4 = "ami-64458f07"
    ap-southeast-2-2.5.4 = "ami-c3f0d3a0"
    eu-central-1-2.5.4   = "ami-858564ea"
    eu-west-1-2.5.4      = "ami-4bc94838"
    sa-east-1-2.5.4      = "ami-8be669e7"
    us-east-1-2.5.4      = "ami-e76b618d"
    us-west-1-2.5.4      = "ami-96fb86f6"
    us-west-2-2.5.4      = "ami-c57a90a5"
    us-gov-west-1-2.5.4  = "ami-13219d72"

    ap-northeast-1-2.5.3 = "ami-71edfa1f"
    ap-northeast-2-2.5.3 = "ami-c8c50ca6"
    ap-southeast-1-2.5.3 = "ami-8419d3e7"
    ap-southeast-2-2.5.3 = "ami-532c0f30"
    eu-central-1-2.5.3   = "ami-f16a8c9e"
    eu-west-1-2.5.3      = "ami-7f8d0b0c"
    sa-east-1-2.5.3      = "ami-981e92f4"
    us-east-1-2.5.3      = "ami-19d4dc73"
    us-west-1-2.5.3      = "ami-6a403d0a"
    us-west-2-2.5.3      = "ami-93ea00f3"
    us-gov-west-1-2.5.3  = "ami-d43b87b5"

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
variable "chef_env" {
  description = "Chef environment to join on provisioning"
  default     = "_default"
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
variable "client_version" {
  description = "Version of the chef-client software to install"
  default     = "12.8.1"
}
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
variable "ghe_version" {
  description = "GitHub Enterprise version (https://enterprise.github.com/releases)"
  default = "2.6.3"
}
variable "hostname" {
  description = "Basename for AWS Name tag of CHEF Server"
  default = "github"
}
variable "knife_rb" {
  description = "Path to your knife.rb configuration"
  default     = ".chef/knife.rb"
}
variable "log_to_file" {
  description = "Output chef-client runtime to logfiles/"
  default     = true
}
variable "public_ip" {
  description = "Associate a public IP to the instance"
  default     = true
}
variable "root_delete_termination" {
  description = "Delete server root block device on termination"
  default     = true
}
variable "root_volume_size" {
  description = "Size in GB of root device"
  default     = 60
}
variable "root_volume_type" {
  description = "Type of root volume"
  default     = "standard"
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
variable "tag_description" {
  description = "AWS description tag text"
  default     = "Created using Terraform (tf_chef_server)"
}
variable "wait_on" {
  description = "Variable to hold outputs of other moudles to force waiting"
  default     = "Nothing"
}

