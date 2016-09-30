#
# AWS provider specific configs
#
variable "aws_access_key" {
  description = "Your AWS key (ex. $AWS_ACCESS_KEY_ID)"
}
variable "aws_flavor" {
  description = "AWS Instance type to deploy"
  default     = "c4.large"
}
variable "aws_key_name" {
  description = "Name of the key pair uploaded to AWS"
}
variable "aws_private_key_file" {
  description = "Full path to your local private key"
}
variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-west-2"
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

variable "load_average_warning" {
  description = "GitHub Enterprise load average threshold"
  default = "2"
}
variable "load_average_critical" {
  description = "GitHub Enterprise load average threshold"
  default = "4"
}
variable "load_average_warning" {
  description = "GitHub Enterprise load average warning threshold"
  default = "2"
}
variable "load_average_critical" {
  description = "GitHub Enterprise load average critical threshold"
  default = "4"
}
variable "memory_warning" {
  description = "GitHub Enterprise memory warning threshold"
  default = "50"
}
variable "memory_critical" {
  description = "GitHub Enterprise memory critical threshold"
  default = "70"
}
variable "diskspace_warning" {
  description = "GitHub Enterprise disk space warning threshold"
  default = "70"
}
variable "diskspace_critical" {
  description = "GitHub Enterprise disk space critical threshold"
  default = "90"
}
variable "backup_ami_map" {
  description = "AMI mapping for GHE backup server based on AWS region"
  default = {
    ap-northeast-1 = "ami-49d31328"
    ap-northeast-2 = "ami-5e429c3d"
    ap-southeast-1 = "ami-3966b75a"
    ap-southeast-2 = "ami-25f3c746"
    eu-central-1   = "ami-b1cf39de"
    eu-west-1      = "ami-55452e26"
    sa-east-1      = "ami-97980efb"
    us-east-1      = "ami-8e0b9499"
    us-west-1      = "ami-547b3834"
    us-west-2      = "ami-70b67d10"
    us-gov-west-1  = "ami-2a08b64b"
  }
}
variable "ami_user" {
  description = "AWS AMI default username"
  default = "ubuntu"
}
#
# specific configs
#
variable "allowed_admin_cidrs" {
  description = "List of CIDRs to allow admin access from"
  default = "199.85.96.0/23,66.194.13.160/27,50.58.125.128/25,168.215.186.224/27,152.101.38.249/32,113.108.131.227/32,50.19.204.37/32"
}
variable "hostname" {
  description = "Basename for AWS Name tag of GitHub backup server"
  default = "github-backup"
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
  default     = 80
}
variable "root_volume_type" {
  description = "Type of root volume"
  default     = "standard"
}
variable "data_volume_size" {
  description = "Size in GB of data device"
  default = 200
}
variable "server_count" {
  description = "Number of GitHub backup servers to provision"
  default = 1
}
variable "tag_description" {
  description = "AWS description tag text"
  default     = "GitHub Backup Utilities created using Terraform"
}
variable "tag_role" {
  description = "AWS role tag text"
  default = "Source Control"
}
variable "tag_application" {
  description = "AWS application tag text"
  default = "GitHub Enterprise Backup Utilities"
}
variable "tag_team" {
  description = "AWS team tag text"
  default = "Engineering Productivity"
}
variable "tag_environment" {
  description = "AWS environment tag text"
  default = "Production"
}
variable "dns_zone_id" {
  description = "Route53 zone id for the DNS zone"
}
variable "dns_name" {
  description = "User-friendly DNS name for GitHub Backup Utilities server"
}
