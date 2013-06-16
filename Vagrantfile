# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Bringing up the host
  config.vm.define :host do |config|
    config.vm.hostname = "one-berkshelf"
    config.vm.box = "opscode-centos-6.4"
    config.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-6.4_chef-11.4.4.box"
    config.vm.network :private_network, ip: "33.33.33.10"
    config.vm.provider :virtualbox do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    end
    config.ssh.max_tries = 40
    config.ssh.timeout   = 120
    config.berkshelf.enabled = true
    config.vm.provision :chef_solo do |chef|
      chef.data_bags_path = "data_bags"
      chef.json = {
        :mysql => {
          :server_root_password => 'extendedrootpass',
          :server_debian_password => 'extendeddebpass',
          :server_repl_password => 'extendedreplpass'
        }
      }
      chef.run_list = [
          "recipe[minitest-handler::default]",
          "recipe[one::vagrant]"
      ]
    end
  end
end