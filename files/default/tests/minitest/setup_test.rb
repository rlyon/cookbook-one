require File.expand_path('../support/helpers', __FILE__)

describe 'one::default' do
  include Helpers::One

  it "should have created the host" do
    result = assert_sh(run_as_oneadmin("onehost show 0"))
    assert_includes result, node['fqdn']
  end

  it "should download the ttylinux image from the marketplace" do
    result = assert_sh(run_as_oneadmin("oneimage list"))
    assert_includes result, "ttylinux"
  end

  it "should create the 'Blue LAN' network" do
    result = assert_sh(run_as_oneadmin("onevnet list"))
    assert_includes result, "Blue LAN"
  end

  it "should create the ttylinux template" do
    result = assert_sh(run_as_oneadmin("onetemplate list"))
    assert_includes result, "ttylinux"
  end
end