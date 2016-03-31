### Getting Started

Terraform can be downloaded [here](https://www.terraform.io/downloads.html).

If you are on a Mac and the awesome Homebrew, you have an easy life and can install Terraform with
a single command:

```bash
brew install terraform
```


#### Environments

Our Terraform configuration is split into isolated environments, to maintain safety, and allow
working with each environment independently of each other.

With the `terraform` directory, you will find a directory for each environment.


#### Remote State

Terraform maintains state with a state file which is updated every time `apply` is run. To avoid
conflicts and merging problems, we store the state file in an S3 bucket at
`quesbook-engineering/terraform`.

The first time you use Terraform for each environment, you must initialize and pull the remote state
with the following command:

```bash
thor terraform:init ENVIRONMENT
```

The above supports and honours your shared AWS credentials file located at `~/.aws/credentials` or
at `C:\Users\USERNAME\.aws\credentials` for Windows. Create this file if it does not exist, and put
your access key and secret as follows:

```
[quesbook]
aws_access_key_id = ?
aws_secret_access_key = ?
region = us-east-1
```

Request your credentials from Joel.
