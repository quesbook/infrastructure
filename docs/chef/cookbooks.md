# Cookbooks

All Quesbook proprietary and private Chef Cookbooks are kept in the `cookbooks` directory, along with
all the policy files for each Role. A Quesbook cookbook is either a Role or an Application, with Role
cookbooks in `cookbooks/roles` and Application cookbooks in `cookbooks/applications`.

Additionally, there is a Base cookbook at `cookbooks/base` that all Role cookbooks require, and must
include as it's first recipe.


## Role Cookbooks

A Role cookbook describes a single role in the Quesbook infrastructure. This will match up to a single
server, but may run several applications and services provides by one or more Application cookbooks.
It may also depend on one or more community cookbooks.

A Role cookbook should be named after the role it is responsible for, and is prefixed with "qr_"
(qr == quesbook role). For example: `qr_webserver`.


## Application Cookbooks

An Application cookbook covers pretty much any other type of cookbook that is proprietary or private
to Quesbook. Usually, such a cookbook will be responsible for a single application or service. It may
also depend on one or more Application and/or community cookbooks.

An Application cookbook should be named after the application or service it is responsible for, and
is prefixed with "qb_". For example: `qb_myapp`.


## Base Cookbook

The Base Cookbook is used and required by all Role cookbooks, and sometimes Application cookbooks.
It contains common and shared recipes.

At the very least, and as a requirement, the Base cookbook's default recipe should be included in
all Role cookbooks and must include it as it's first recipe.