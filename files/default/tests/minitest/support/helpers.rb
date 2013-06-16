module Helpers
  module One
    include MiniTest::Chef::Assertions
    include MiniTest::Chef::Context
    include MiniTest::Chef::Resources

    def opennebula_db
      require 'mysql'
      connection = ::Mysql.new 'localhost', 'root', node['mysql']['server_root_password']
      mfts = connection.list_dbs
    end

    def run_as_oneadmin(cmd)
      "su - oneadmin -c '#{cmd}'"
    end

  end
end