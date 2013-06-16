require File.expand_path('../support/helpers', __FILE__)
require File.expand_path('../../apache2/support/helpers', __FILE__)

describe "one::proxy" do
  include Helpers::One
  include Helpers::Apache
  
  it "Enables and starts the httpd daemon" do
    service("httpd").must_be_running
    service("httpd").must_be_enabled
  end

  # verify that mod_proxy is installed for apache
  it "Enables mod_proxy" do
    apache_enabled_modules.must_include "proxy_module"
  end

  it "configures apache proxy for sunstone" do
    link("#{node['apache']['dir']}/sites-enabled/sunstone.conf").must_exist.with(
      :link_type,
      :symbolic
    ).and(
      :to,
      "#{node['apache']['dir']}/sites-available/sunstone.conf"
    )
  end

  it "configures apache proxy for occi" do
    link("#{node['apache']['dir']}/sites-enabled/api.conf").must_exist.with(
      :link_type,
      :symbolic
    ).and(
      :to,
      "#{node['apache']['dir']}/sites-available/api.conf"
    )
  end
end