#
# Cookbook Name:: one
# Recipe:: setup
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

package "bridge-utils"

execute "Create the host" do
  command "su - oneadmin -c 'onehost create #{node['fqdn']} -i kvm -v kvm -n ebtables'"
  not_if "su - oneadmin -c 'onehost show 0'"
  action :run
end

directory "#{node['one']['oneadmin']['home']}/setup" do
  owner "oneadmin"
  group "oneadmin"
  mode 00755
  action :create
end

cookbook_file "#{node['one']['oneadmin']['home']}/setup/image_ttylinux.one" do
  source "image_ttylinux.one"
  owner "oneadmin"
  group "oneadmin"
  mode 00644
end

execute "Download and install the ttylinux image" do
  command "su - oneadmin -c 'oneimage create #{node['one']['oneadmin']['home']}/setup/market_ttylinux.one --datastore default'"
  not_if "su - oneadmin -c 'oneimage show 0'"
  action :run
end

cookbook_file "#{node['one']['oneadmin']['home']}/setup/vnet_bluelan.one" do
  source "vnet_bluelan.one"
  owner "oneadmin"
  group "oneadmin"
  mode 00644
end

execute "Create the vnet" do
  command "su - oneadmin -c 'onevnet create #{node['one']['oneadmin']['home']}/setup/vnet_bluelan.one'"
  not_if "su - oneadmin -c 'onevnet show 0'"
  action :run
end

cookbook_file "#{node['one']['oneadmin']['home']}/setup/template_ttylinux.one" do
  source "template_ttylinux.one"
  owner "oneadmin"
  group "oneadmin"
  mode 00644
end

execute "Create the vnet" do
  command "su - oneadmin -c 'onetemplate create #{node['one']['oneadmin']['home']}/setup/template_ttylinux.one'"
  not_if "su - oneadmin -c 'onetemplate show 0'"
  action :run
end
