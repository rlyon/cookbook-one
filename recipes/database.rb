#
# Cookbook Name:: one
# Recipe:: database
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

if node['one']['oned']['database']['backend'] == "mysql"
  include_recipe "mysql::server"
  include_recipe "mysql::ruby"

  mysql_connection_info = {
    :host => node['one']['oned']['database']['server'],
    :username => 'root',
    :password => node['mysql']['server_root_password'],
    :port => node['one']['oned']['database']['port']
  }

  mysql_database node['one']['oned']['database']['name'] do
    connection mysql_connection_info
    action :create
  end

  mysql_database_user node['one']['oned']['database']['user'] do
    connection mysql_connection_info
    password node['one']['oned']['database']['password']
    database_name node['one']['oned']['database']['name']
    action :grant
  end
else
  log.info "Using sqlite to store data.  Nothing to do."
end
