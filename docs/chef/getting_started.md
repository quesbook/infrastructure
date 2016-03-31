# Getting Started

Before you can do anything with Chef, you will need to setup your workstation with the tools
required to interface with Chef and the Quesbook Chef Server, as well as authentication.

## Create Chef Server User

You will need a user account on the Chef Server that is a part of the Quesbook organization. SSH into
the Chef Server at chef.int.quesbook.com and run the following commands:

```bash
sudo chef-server-ctl user-create USERNAME FIRST_NAME LAST_NAME EMAIL PASSWORD -f /tmp/new-chef-user.key
sudo chef-server-ctl org-user-add quesbook USERNAME -a
```

The above will create a new user and assign it to the Quesbook organization on the Chef Server. The new
users' private key will be saved in `/tmp/new-chef-user.key`. We will use this key later.

## Setup Your Workstation

First off, you will need to install the ChefDK from https://downloads.chef.io/chef-dk/. Once that is
done, run `chef verify` to verify that everything is ready and working.

Now you will need to configure your workstation. First create the `.chef` directory. This is where
you will keep your Chef configuration and key files.

```bash
mkdir .chef
```

Now create the file `.chef/knife.rb` with the following contents (replacing `USERNAME` with the
user created above):

```ruby
log_location    STDOUT
node_name       "USERNAME"
chef_server_url "https://chef.quesbook.com/organizations/quesbook"
```

Now you need to grab the private key that you created earlier to `/tmp/new-chef-user.key` on the
Chef Server and save it to `.chef/client.pem`.

## Is it Working?

Now all should be working. Verify this by running a knife command that will return a list of all
clients on the chef server:

```bash
knife client list
```

If that returns a list of Chef clients, you're all done!