tf_ghe_server CHANGELOG
========================

This file is used to list changes made in each version of the tf_ghe_server Terraform plan.

v1.0.2 (2016-04-21)
-------------------
- [Brian Menges] - Fix [CHANGELOG.md](CHANGELOG.md)
- [Brian Menges] - Apply explicit dependency

v1.0.1 (2016-04-20)
-------------------
- [Brian Menges] - Added chef-client::cron to run_list

v1.0.0 (2016-04-20)
-------------------
- [Brian Menges] - Code review
- [Brian Menges] - Add firewall rules resource link to comment
- [Brian Menges] - Release v1.0.0

v0.1.10 (2016-04-16)
-------------------
- [Brian Menges] - Using `wait_on` in `null_resource` to enforce waiting

v0.1.9 (2016-04-15)
-------------------
- [Brian Menges] - Added variable `knife_rb` to handle node deletes

v0.1.8 (2016-04-15)
-------------------
- [Brian Menges] - Added variable `wait_on` to allow this module to wait for another module's output

v0.1.7 (2016-04-15)
-------------------
- [Brian Menges] - Fix syntax error in `attributes-json.tpl`

v0.1.6 (2016-04-15)
-------------------
- [Brian Menges] - Update `attributes-json.tpl`, set `system` cookbook to restart network immediately on set
- [Brian Menges] - Alphabetize `attributes-json.tpl`, except for `fqdn`
- [Brian Menges] - Add attributes and run_list to setup chef-client as cron job with splay

v0.1.5 (2016-04-13)
-------------------
- [Brian Menges] - fix curl command

v0.1.4 (2016-04-13)
-------------------
- [Brian Menges] - add delay

v0.1.3 (2016-04-13)
-------------------
- [Brian Menges] - Add some delay in the cookbook to api call
- [Brian Menges] - Revise [README.md](README.md)

v0.1.2 (2016-04-13)
-------------------
- [Brian Menges] - Add `log_to_file` variable

v0.1.1 (2016-04-13)
-------------------
- [Brian Menges] - Add `root_delete_termination` variable

v0.1.0 (2016-04-13)
-------------------
- [Brian Menges] - Reformat [CHANGELOG.md](CHANGELOG.md)
- [Brian Menges] - Remove Route53 hooks
- [Brian Menges] - Add `client_version` variable for chef-client version control
- [Brian Menges] - Add `log_to_file` variable for chef-client runtime logging
- [Brian Menges] - Update `depends_on` instances
- [Brian Menges] - Added AMIs to map for GHE versions 2.5.3 and 2.5.4
- [Brian Menges] - Add `public_ip` input variable to indicate public IP association to AWS instance

v0.0.2 (2016-03-28)
-------------------
- [Brian Menges] - Syntax update to handle terraform [0.6.14](https://github.com/hashicorp/terraform/blob/master/CHANGELOG.md#0614-march-21-2016)

v0.0.1 (2016-03-23)
-------------------
- [Brian Menges] - initial commit

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
