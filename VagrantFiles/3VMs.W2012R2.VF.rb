# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile which:
#	creates 3 VMs as ubuntu/precise32, and gives them 1MB of RAM
#	the nic changes are in an effort to get around some hanging at the point the VM was allegedly
#	being brought up
Vagrant.configure("2") do |config|
  
	boxes = {
		'vm1' => 'web1',
		'vm2' => 'web2',
		'vm3' => 'db1'
	}
  
	boxes.each do | key, value | 
	  config.vm.define "#{value}" do |node|
		node.vm.box = "ubuntu/precise32"
		node.vm.hostname = "#{value}"
		node.vm.box_url = "ubuntu/precise32"
		node.vm.boot_timeout = 999
	  end
	end

	config.vm.provider "virtualbox" do |vb|
        # https://www.virtualbox.org/manual/ch08.html
		vb.customize ["modifyvm", :id, "--nictype1", "Am79C973"]
		vb.customize ["modifyvm", :id, "--nictype2", "Am79C973"]
		vb.memory = "1024"
   end
end
