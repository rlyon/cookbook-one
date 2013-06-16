#
# Cookbook Name:: one
# Recipe:: oneadmin
#
# Copyright 2013, Rob Lyon
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

oneadmin = data_bag_item('one', 'oneadmin')

# Add the cloud administrator and add to the disk group
user "oneadmin" do
  comment "Cloud Administrator"
  home node['one']['oneadmin']['home']
  shell "/bin/bash"
  supports Mash.new(:manage_home => true)
  action [:create, :manage]
end

group "disk" do
  action :modify
  members "oneadmin"
  append true
end

# group "kvm" do
#   action :modify
#   members "oneadmin"
#   append true
# end

directory "#{node['one']['oneadmin']['home']}/.one" do
  owner "oneadmin"
  group "oneadmin"
  mode 0700
end

template "#{node['one']['oneadmin']['home']}/.one/one_auth" do
  source "one_auth.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0600
  variables({
    :password => oneadmin['password']
  })
end

directory "#{node['one']['oneadmin']['home']}/.ssh" do
  owner "oneadmin"
  group "oneadmin"
  mode 0700
end

template "#{node['one']['oneadmin']['home']}/.ssh/config" do
  source "ssh.config.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
end

template "#{node['one']['oneadmin']['home']}/.ssh/id_rsa" do
  source "id_rsa.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0600
  variables({
    :private_key => oneadmin['private_key'].join("\n")
  })
end

template "#{node['one']['oneadmin']['home']}/.ssh/id_rsa.pub" do
  source "id_rsa.pub.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
  variables({
    :public_key => oneadmin['public_key']
  })
end

template "#{node['one']['oneadmin']['home']}/.ssh/authorized_keys" do
  source "authorized_keys.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
  variables({
    :public_key => oneadmin['public_key']
  })
end

node.default['authorization']['sudo']['sudoers_defaults'] = [
  '!requiretty',
  '!visiblepw',
  'env_reset',
  'env_keep =  "COLORS DISPLAY HOSTNAME HISTSIZE INPUTRC KDEDIR LS_COLORS"',
  'env_keep += "MAIL PS1 PS2 QTDIR USERNAME LANG LC_ADDRESS LC_CTYPE"',
  'env_keep += "LC_COLLATE LC_IDENTIFICATION LC_MEASUREMENT LC_MESSAGES"',
  'env_keep += "LC_MONETARY LC_NAME LC_NUMERIC LC_PAPER LC_TELEPHONE"',
  'env_keep += "LC_TIME LC_ALL LANGUAGE LINGUAS _XKB_CHARSET XAUTHORITY"',
  'env_keep += "HOME"',
  'always_set_home',
  'secure_path = /sbin:/bin:/usr/sbin:/usr/bin'
]
node.default['authorization']['sudo']['users'] = ['oneadmin']
node.default['authorization']['sudo']['users'] << 'vagrant' if node['one']['vagrantup']
node.default['authorization']['sudo']['passwordless'] = true
include_recipe "sudo"
