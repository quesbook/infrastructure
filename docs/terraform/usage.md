### Usage

You should read Terraform's [Getting Started](https://www.terraform.io/intro/getting-started/install.html)
guide to get yourself familiar with Terraform. But as a summary...

To see your execution plan which details what has changed (if anything), and what Terraform will do
when you apply...

```bash
thor terraform:plan ENVIRONMENT
```

And to apply the changes:

```bash
thor terraform:apply ENVIRONMENT
```

**ALWAYS** run `plan` before you run `apply`! This will show you what has changed and is your safety
net. Sometimes a change could result in a resource being destroyed and re-created. And in most
cases, you do not want that.
