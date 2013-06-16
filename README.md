# one cookbook

# Requirements
CentOS 6+
Chef 11+

# Usage
Create a databag containing the the oneadmin password and ssh keys (only for the frontend and host) and include the appropriate recipes:

For an opennebula frontend

For an opennebula host

For an opennebula proxy

For an opennebula API portal

# Attributes

## default.rb

* `default['one']['version']` - The version to be installed
* `default['one']['vagrantup']` - Specify if this is a vagrant run
* `default['one']['oneadmin']['home']` - Home for the oneadmin user

## repos.rb

* `default['one']['repos']['url']` - The repo where your opennebula rpms live



# Recipes

## default.rb

* Create the oneadmin user and appropriate files
* Add the oneadmin user to the sudoers file

## repos.rb

* Add the yum repository

## frontend.rb

* Install the server packages

# Author

Author:: Rob Lyon (rlyon@uidaho.edu)
