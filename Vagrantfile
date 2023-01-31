# -*- mode: ruby -*- 
# vi: set ft=ruby : 

Vagrant.configure(2) do |config| 
  config.vm.box = "centos/stream8" 
  config.vm.box_version = "20210210.0" 
  config.vm.provider "virtualbox" do |v| 
  v.memory = 256 
  v.cpus = 1
   
 end 
 config.vm.define "rmp" do |rmp| 
  rmp.vm.network "private_network", ip: "192.168.50.10",  virtualbox__intnet: "net1" 
  rmp.vm.hostname = "centos8" 
  rmp.vm.provision "shell", path: "create.sh" 
  end
end 
 
