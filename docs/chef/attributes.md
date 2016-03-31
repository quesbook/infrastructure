# Attributes

Chef has a very complex and very powerful system to define attributes, which provides several
different precedence levels. This can make it very hard to reason and to know what attributes are
defined and at what level.

To minimise confusion, we only allow attributes to be set within cookbooks or nodes. Usually setting
attributes within cookbooks is good enough, but sometimes you need to override an attribute on the
node.

For example: a node or environment may require a different attribute value that should be specific
only to a node or environment.

**Check the [Chef docs](https://docs.chef.io/attributes.html) for all the details about attributes.**


## Cookbook Attributes

Cookbook attributes are usually defined in attribute files (the `attributes` directory in a
cookbook). They can also be defined or redefined within recipes.

You should ensure to define cookbook attributes with the
[`default` type](https://docs.chef.io/attributes.html#attribute-types), and avoid using other types.


## Node Attributes

Attributes that are defined on a node will take precedent over those that are defined within
cookbooks.

To set an attribute on a node, you use the `knife` CLI tool:

```bash
knife node edit NODE_NAME
```

This will open up your default editor with a JSON object that describes the node - looking something
like this:

```json
{
  "name": "web-staging",
  "chef_environment": "_default",
  "normal": {
    "tags": []
  },
  "run_list": [
    "recipe[cr_webserver::default]"
  ]
}
```

You can now add/edit/remove attributes within the `normal` attributes object. For example, to add
the `qb_base.environment` attribute, I would add this JSON object to the node:

```json
"qb_base": {
  "environment": "staging"
}
```

My node object now looks like this:

```json
{
  "name": "web-staging",
  "chef_environment": "_default",
  "normal": {
    "tags": [],
    "qb_base": {
      "environment": "staging"
    }
  },
  "run_list": [
    "recipe[cr_webserver::default]"
  ]
}
```