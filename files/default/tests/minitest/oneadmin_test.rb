require File.expand_path('../support/helpers', __FILE__)

describe 'one::default' do
  include Helpers::One

  it "creates the disk group" do
      group("disk").must_exist
  end

  it "grants group membership to oneadmin" do
    group("disk").must_include('oneadmin')
  end

  it "should be able to use ssh without a password" do
    result = assert_sh(run_as_oneadmin("ssh oneadmin@localhost whoami"))
    assert_includes result, "oneadmin"
  end

  it "should be able to run sudo commands without a password" do
    result = assert_sh(run_as_oneadmin("sudo cat /root/anaconda-ks.cfg"))
    assert_includes result, "Kickstart"
  end
end