# Security Group Rule Naming Conventions

The format of security group rule names should be clear and concise, but without being overly
descriptive. For example, there is no need to mention the environment or role, because we already
know that from the Terraform module we are in.

If the service name is known, that should be used instead of the port number(s). This makes it
easier to identify the resource, and the port(s) are already specified in the resource.

Hyphens should be used as separators and not underscores, and all strings should be camelCased.

    [source or role]-[direction(IN|OUT)]-[port or service name]

example:

    `app-IN-postgres`

If no "from" is mentioned, for example we allow all...

    all-[direction(IN|OUT)]-[port or service name]

example:

    `all-IN-ssh`
