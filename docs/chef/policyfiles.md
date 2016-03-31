# Policyfiles and Releasing Cookbooks

The Restaurant relies on the new Policyfiles feature of Chef, which simplifies cookbook versioning,
development and releasing. It also makes it easier to use a single repo where all Cookbooks are
kept.

Full details on Policyfiles can be found at https://github.com/chef/chef-dk/blob/master/POLICYFILE_README.md

Each Role cookbook has its own Policyfile which specifies the Policy name, run list, and cookbook
dependencies. So releasing an update to a Role is a simple matter of updating the Policyfile.lock
and pushing the change to the policy group you want to apply the change to, using:

```bash
thor chef push ROLE ENVIRONMENT
```

Each server belongs to a policy as defined by the Policy name (eg. "webserver"), and is part of a
Policy group, which is the environment (eg. "production").


## Versioning

While each cookbook still has a version number defined in its `metadata.rb`, this need no longer be
incremented every time you wish to release a change to a cookbook.

This is because Policyfiles version cookbooks with a hash that is based on the content of the
cookbook. You can liken this hash to a Git commit or ref.

Each time you run `chef update`, the cookbook and it's dependencies are given a new hash which is
saved back to `Policyfile.lock`. It is this lock file that locks the policy to a specific set of
Cookbooks.

So while version numbers can still be used, they don't need to be. Right now, the only reason to
bump a version number, is so you can specific that version in the Policyfile. Which would be used
to prevent updates to that Cookbook.


## Pushing Changes

Pushing changes to a cookbook and applying those changes to one or more servers, involves updating
the Policy lock file, and pushing the updated cookbooks to the Chef Server. The Chef Client will
then apply the updates when it next runs on each affected server.

From within a Role cookbook, run `thor chef push ROLE ENVIRONMENT` to update and push the Cookbook's
dependencies. This will regenerate the Policy lock file (Policyfile.lock), which is then pushed to
the Chef server.

### As an example...

Let's say you wish to make a change to the Upstart config for Underdome. The underdome Application
cookbook contains the Upstart config file, so you edit that file.

Now you want to test that on staging before pushing to production.

Underdome runs on the workers, so you need to update the worker Role cookbook so it will use the
updated Upstart config you changed in the underdome Application cookbook.

```bash
thor chef push worker staging
```

Now you can wait for the Chef client to run on each worker, or SSH in and run `sudo chef-client`
manually.

Once you have done that and verified that your change was successful, you can promote it to
production with:

```bash
thor chef push worker production
```
