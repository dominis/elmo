node_hostname = File.open(File.join(File.dirname(__FILE__), "puppet-node"), File::RDONLY).read.strip

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|


	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
	end

	config.ssh.forward_agent = true

	config.vm.define "puppetmaster" do |master_config|

	    master_config.vm.box = "puppetlabs/centos-7.0-64-puppet"
	    #https://github.com/mitchellh/vagrant/issues/6128
	    master_config.vm.box_version = "1.0.1"

		master_config.vm.hostname = "puppet.local"
		master_config.vm.network "private_network", ip: "192.168.80.2"

		master_config.vm.network "forwarded_port", guest: 8140 ,host: 8140

		# your puppet repo mount under puppetmaster
		master_config.vm.synced_folder "../", "/etc/puppet"

		master_config.vm.provision :puppet do |p|
		   p.manifests_path = "./elmo-puppet/manifests"
		   p.module_path = "./elmo-puppet/modules"
		   p.manifest_file  = "master.pp"
		end
	end

	config.vm.define "node" do |node_config|

	    node_config.vm.box = "puppetlabs/centos-7.0-64-puppet"
	    #https://github.com/mitchellh/vagrant/issues/6128
	    node_config.vm.box_version = "1.0.1"

		node_config.vm.hostname = node_hostname
		node_config.vm.network "private_network", ip: "192.168.80.3"

		node_config.vm.provision :puppet do |p|
		   p.manifests_path = "./elmo-puppet/manifests"
		   p.module_path = "./elmo-puppet/modules"
		   p.manifest_file  = "node.pp"
		end

		node_config.vm.provision "shell", inline: "puppet agent -tv"

		node_config.vm.provider :virtualbox do |vb|
    		vb.customize ["modifyvm", :id, "--memory", "8192"]
    		vb.customize ["modifyvm", :id, "--cpuexecutioncap", "80"]
    		vb.cpus = 4
  		end
	end

end
