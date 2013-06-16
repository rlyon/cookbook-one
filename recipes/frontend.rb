#
# Cookbook Name:: one
# Recipe:: frontend
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
include_recipe "one::repos"
include_recipe "one::oneadmin"
include_recipe "one::database"

# Install the packages
node['one']['frontend']['packages'].each do |pkg|
  p = package pkg do
    version node['one']['version']
    action :nothing
  end
  p.action(:install)
end

template "/etc/one/oned.conf" do
  source "oned.conf.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
  notifies :restart, 'service[opennebula]'
end

template "/etc/one/occi-server.conf" do
  source "occi-server.conf.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
  notifies :restart, 'service[opennebula-occi]'
end

# template "/etc/oned/econe.conf" do
#   source "econe.conf.erb"
#   owner "oneadmin"
#   group "oneadmin"
#   mode 0644
#   # notifies :restart, 'service[opennebula-econe]'
# end

template "/etc/one/sunstone-server.conf" do
  source "sunstone-server.conf.erb"
  owner "oneadmin"
  group "oneadmin"
  mode 0644
  notifies :restart, 'service[opennebula-sunstone]'
end

service 'opennebula' do
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end

service 'opennebula-occi' do
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end

service 'opennebula-sunstone' do
  supports :status => true, :restart => true, :reload => false
  action [ :enable, :start ]
end