require File.expand_path('../support/helpers', __FILE__)

describe 'one::database' do
  include Helpers::One

  it "enables and starts the mysql daemon" do
    service("mysqld").must_be_running
    service("mysqld").must_be_enabled
  end

  it "should have the opennebula database" do
    opennebula_db.must_include node['one']['oned']['database']['name']
  end
end