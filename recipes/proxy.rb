#
# Cookbook Name:: one
# Recipe:: proxy
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

node.default['apache']['default_site_enabled'] = false
include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_headers"

template "#{node['apache']['dir']}/sites-available/sunstone.conf" do
  source "proxy-sunstone.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[apache2]'
  variables({:frontend => node['one']['proxy']['frontend_ip']})
end

template "#{node['apache']['dir']}/sites-available/api.conf" do
  source "proxy-api.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :restart, 'service[apache2]'
  variables({:frontend => node['one']['proxy']['frontend_ip']})
end

apache_site "sunstone.conf" do
  enable true
  notifies :restart, 'service[apache2]'
end

apache_site "api.conf" do
  enable true
  notifies :restart, 'service[apache2]'
end