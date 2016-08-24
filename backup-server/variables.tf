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
variable "domain" {
  description = "Domain name of the server created"
  default = "localdomain"
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
variable "dns_zone_id" {
  description = "Route53 zone id for the DNS zone"
}
variable "dns_name" {
  description = "User-friendly DNS name for GitHub Backup Utilities server"
}
