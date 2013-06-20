#
# Cookbook Name:: one
# Attributes:: default
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

default['one']['version'] = "4.0.1-1"
default['one']['vagrantup'] = false
default['one']['oneadmin']['home'] = "/var/lib/one"
default['one']['proxy']['frontend_ip'] = "127.0.0.1"
default['one']['proxy']['sunstone_port'] = 80
default['one']['proxy']['mod_ssl'] = false
default['one']['repos']['url'] = "http://universe.ibest.uidaho.edu/opennebula/el#{node['platform_version'].to_i}/$basearch"
default['one']['frontend']['packages'] = %w{
  opennebula-common
  opennebula-ruby
  opennebula-java
  opennebula-ruby
  opennebula-server
  opennebula-sunstone
  opennebula-ozones
}
default['one']['host']['packages'] = %w{
  opennebula-node-kvm
}
default['one']['oned']['debug_level'] = 3
default['one']['oned']['monitoring_interval'] = 120
default['one']['oned']['port'] = 2633
default['one']['oned']['database']['backend'] = "mysql"
default['one']['oned']['database']['server'] = "localhost"
default['one']['oned']['database']['port'] = 3306
default['one']['oned']['database']['user'] = "oneadmin"
default['one']['oned']['database']['password'] = "oneadmin"
default['one']['oned']['database']['name'] = "opennebula"

default['one']['sunstone']['xmlrpc'] = "http://localhost:2633/RPC2"
default['one']['sunstone']['host'] = "127.0.0.1"
default['one']['sunstone']['port'] = "9869"
default['one']['sunstone']['debug_level'] = "3"
default['one']['sunstone']['auth'] = "sunstone"

default['one']['occi']['xmlrpc'] = "http://localhost:2633/RPC2"
default['one']['occi']['host'] = "127.0.0.1"
default['one']['occi']['port'] = "4568"
default['one']['occi']['debug_level'] = "3"