# Quesbook's Infrastrucure as Code

This repo is the central place for Quesbook's devops and infrastructure tooling, including Chef and
Terraform.


## Thor

While Chef and Terraform have their own CLI tools, we work with these in a fairly specific way. So
[Thor](http://whatisthor.com/) is used as a friendly and safety wrapper around the `chef` and
`terraform` CLI tools.

Thor is a Ruby Gem, so install it with `gem install thor`.

We have two main Thor classes - chef and terraform - which are used as follows:

```bash
thor chef
```

or

```bash
thor terraform
```

Run either of the above to see help.


## Chef

All Chef management is performed right here. This includes cookbook development, testing and
releasing.

 - [Getting Started](docs/chef/getting_started.md)
 - [Cookbooks](docs/chef/cookbooks.md)
 - [Policyfiles and Releasing Cookbooks](docs/chef/policyfiles.md)
 - [Attributes](docs/chef/attributes.md)


## Terraform

[Terraform](https://www.terraform.io/) is a tool for creating and managing infrastructure, including
EC2 instances, DNS records and loads more. Quesbook uses it to do exactly that, while still allowing
Chef to manage configuration of the resources that Terraform creates.

- [Getting Started](docs/terraform/getting_started.md)
- [Usage](docs/terraform/usage.md)
- [Security Group Rule Naming Conventions](docs/terraform/security_group_naming.md)
