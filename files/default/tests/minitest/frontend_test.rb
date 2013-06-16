require File.expand_path('../support/helpers', __FILE__)

describe 'one::default' do
  include Helpers::One

  it "enables and starts the oned daemon" do
    service("opennebula").must_be_running
    service("opennebula").must_be_enabled
  end

  it "enables and starts the sunstone daemon" do
    service("opennebula-sunstone").must_be_running
    service("opennebula-sunstone").must_be_enabled
  end

  it "enables and starts the occi daemon" do
    service("opennebula-occi").must_be_running
    service("opennebula-occi").must_be_enabled
  end
end