# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "salt/roots/", "/srv/salt/"
  config.vm.synced_folder "pillar/", "/srv/pillar/"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "2"]
  end

  config.vm.define "pycon" do |machine|
    machine.vm.network "forwarded_port", guest: 80, host: 8081
    machine.vm.hostname = "in.pycon.org"
  end

  config.vm.define "pycon-new" do |machine|
    config.vm.box = "ubuntu/xenial64"
    machine.vm.network "forwarded_port", guest: 80, host: 8083
    machine.vm.hostname = "in.pycon.org"
  end

  config.vm.define "wye" do |machine|
    machine.vm.network "forwarded_port", guest: 80, host: 8082
    machine.vm.hostname = "pythonexpress.in"
  end

  config.vm.provision "shell",
                      inline: "curl -L https://bootstrap.saltstack.com | sudo sh -s -- -X stable"
  config.vm.provision "shell",
                      inline: "salt-call --local state.highstate -l debug --no-color"

  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"
end
