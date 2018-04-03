# -*- mode: ruby -*-
# vi: set ft=ruby :


# http://stackoverflow.com/questions/19492738/demand-a-vagrant-plugin-within-the-vagrantfile
# not using 'vagrant-vbguest' vagrant plugin because now using bento images which has vbguestadditions preinstalled.
required_plugins = %w( vagrant-hosts vagrant-share vagrant-vbox-snapshot vagrant-host-shell vagrant-triggers vagrant-reload )
plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
if not plugins_to_install.empty?
  puts "Installing plugins: #{plugins_to_install.join(' ')}"
  if system "vagrant plugin install #{plugins_to_install.join(' ')}"
    exec "vagrant #{ARGV.join(' ')}"
  else
    abort "Installation of one or more plugins has failed. Aborting."
  end
end



Vagrant.configure(2) do |config|
  config.vm.define "client" do |client_config|
    client_config.vm.box = "bento/centos-7.4"
    client_config.vm.hostname = "client.local"
    # https://www.vagrantup.com/docs/virtualbox/networking.html
    client_config.vm.network "private_network", ip: "10.0.50.10", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    client_config.vm.provider "virtualbox" do |vb|
      vb.gui = false 
      vb.memory = "1024"
      vb.cpus = 2
      vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
      vb.name = "centos7_client"
    end

    client_config.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
    client_config.vm.provision :reload
  end

  config.vm.define "webserver" do |webserver_config|
    webserver_config.vm.box = "bento/centos-7.4"
    webserver_config.vm.hostname = "webserver.local"
    webserver_config.vm.network "private_network", ip: "10.0.50.11", :netmask => "255.255.255.0", virtualbox__intnet: "intnet2"

    webserver_config.vm.provider "virtualbox" do |vb|
      vb.gui = true
      vb.memory = "2048"
      vb.cpus = 2
      vb.name = "centos7_webserver"
    end

    webserver_config.vm.provision "shell", path: "scripts/install-rpms.sh", privileged: true
    webserver_config.vm.provision "shell", path: "scripts/webserver-setup.sh", privileged: true
    webserver_config.vm.provision "shell", path: "scripts/install-gnome-gui.sh", privileged: true
    webserver_config.vm.provision :reload
  end
  
  config.vm.provision :hosts do |provisioner|
    provisioner.add_host '10.0.50.10', ['client.local']
    provisioner.add_host '10.0.50.11', ['webserver.local']
  end

end
