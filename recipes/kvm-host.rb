#
# Cookbook Name:: one
# Recipe:: kvm-host
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

node['one']['host']['packages'].each do |pkg|
  p = package pkg do
    version node['one']['version']
    action :install
  end
end

# link "/usr/bin/kvm" do
#   to "/usr/libexec/qemu-kvm"
# end

template "/etc/polkit-1/localauthority/50-local.d/50-org.libvirt.unix.manage-opennebula.pkla" do
  source "50-org.libvirt.unix.manage-opennebula.pkla.erb"
  owner "root"
  group "root"
  mode 0644
end

service 'libvirtd' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

template "/etc/libvirt/libvirtd.conf" do
  source "libvirtd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[libvirtd]', :immediately
end

template "/etc/libvirt/qemu.conf" do
  source "qemu.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies :reload, 'service[libvirtd]', :immediately
end
