# tf_ghe_server
Terraform GitHub Enterprise plan

## Assumptions

* Requires:
  * AWS (duh!)
  * AWS subnet id
  * AWS VPC id
  * SSL certificate/key for created instance
  * Terraform >= 0.6.14
* Uses a public IP and public DNS
* Creates default security group as follows:
  * 22/tcp: SSH
  * 122/tcp: Git via SSH
  * 443/tcp: HTTPS
  * 8443/tcp: HTTPS
  * 80/tcp: HTTP
  * 8080/tcp: HTTP
  * 9418/tcp: GIT
  * 1194/udp: VPN
  * 123/udp: NTP
  * 161/udp: SNMP
  * 25/tcp: SMTP
* Understand Terraform and ability to read the source

## Usage

### Module

In your terraform plan:
```
module "module_name_here" {
  source = "github.com/mengesb/tf_ghe_server"
  aws_access_key = "<key>"
  ...
}
```

### Directly

1. Clone this repo: `git clone https://github.com/mengesb/tf_ghe_server.git`
2. Get dependencies: `terraform get`
3. Generate and poulate a local `terraform.tfvars` to not be prompted for all inputs
4. Test the plan: `terraform plan`
5. Apply the plan: `terraform apply`

## Supported OSes

GitHub Enterprise deploys on custom Ubuntu images.

## AWS

These resources will incur charges on your AWS bill. It is your responsibility to delete the resources.

## Input variables

### AWS variables

* `aws_access_key`: Your AWS key, usually referred to as `AWS_ACCESS_KEY_ID`
* `aws_flavor`: The AWS instance type. Default: `c3.xlarge`
* `aws_key_name`: The private key pair name on AWS to use (String)
* `aws_private_key_file`: The full path to the private kye matching `aws_key_name` public key on AWS
* `aws_region`: AWS region you want to deploy to. Default: `us-west-1`
* `aws_secret_key`: Your secret for your AWS key, usually referred to as `AWS_SECRET_ACCESS_KEY`
* `aws_subnet_id`: The AWS id of the subnet to use. Example: `subnet-ffffffff`
* `aws_vpc_id`: The AWS id of the VPC to use. Example: `vpc-ffffffff`

### tf_ghe_server variables

* `allowed_cidrs`: The comma seperated list of addresses in CIDR format to allow SSH access. Default: `0.0.0.0/0`
* `allowed_commit_cidrs`: The comma seperated list of addresses in CIDR format to allow GIT over 22/tcp access. Default: `0.0.0.0/0`
* `chef_fqdn`: Fully qualified domain name of the Chef Server
* `chef_org`: Short name of the Chef organization
* `chef_org_validator`: Orginazation validator file for Chef organziation `chef_org`
* `client_version`: Chef client version. Default: `12.8.1`
* `domain`: Server's basename. Default: `localhost`
* `ghe_license`: File for GitHub Enterprise license file
* `ghe_settings`: File for GitHub Entperise settings
* `hostname`: Server's basename. Default: `localdomain`
* `log_to_file`: Log chef-client to file. Default: `true`
* `public_ip`: Associate public IP to instance. Default `true`
* `root_delete_termination`: Delete root device on VM termination. Default: `true`
* `root_volume_size`: Size of the root volume in GB. Default: `20`
* `root_volume_type`: Type of root volume. Supports `gp2` and `standard`. Default `standard`
* `server_count`: Server count. Default: `1`; DO NOT CHANGE!
* `sgrule_ntp`: Boolean to create security group rule allowing NTP. Default: `0`
* `sgrule_smtp`: Boolean to create security group rule allowing SMTP. Default: `0`
* `sgrule_snmp`: Boolean to create security group rule allowing SNMP. Default: `0`
* `tag_description`: Text field tag 'Description'

### Map variables

The below mapping variables construct selection criteria

* `ami_map`: AMI selection map comprised of `aws_region` and `ghe_version`
* `ami_user`: Default username for GHE is `admin`

```
ami_map.<aws_region>-<ghe_version> = "value"
```

Variable `ghe_version` should be one of the following:

* 2.6.0 (default)
* 2.5.4
* 2.5.3
* 2.5.2
* 2.5.1
* 2.5.0

Variable `aws_region` should be one of the following:

* us-east-1
* us-west-2
* us-west-1 (default)
* eu-central-1
* eu-west-1
* ap-southeast-1
* ap-southeast-2
* ap-northeast-1
* ap-northeast-2
* sa-east-1
* Custom (must be an AWS region, requires setting `ami_map` and setting AMI value)

Map `ami_usermap` uses `ami_os` to look the default username for interracting with the instance. To override this pre-declared user, define

```
ami_usermap.<ami_os> = "value"
```

## Outputs

* `credentials`: Formatted text output with details about this instance
* `fqdn`: The fully qualified domain name of the server
* `private_ip`: The private IP address of the instance
* `public_ip`: The public IP address of the instance
* `security_group_id`: The AWS security group id for this instance

## Contributors

* [Brian Menges](https://github.com/mengesb)

## Runtime sample

Example runtime not yet available

## Contributing

Please understand that this is a work in progress and is subject to change rapidly. Please be sure to keep up to date with the repo should you fork, and feel free to contact me regarding development and suggested direction

## `CHANGELOG`

Please refer to the [CHANGELOG.md](CHANGELOG.md)

## License

This is licensed under [the Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0).

