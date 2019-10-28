# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 2.0"

$script = <<-SCRIPT
sudo wget -qO /usr/local/bin/stern https://github.com/wercker/stern/releases/download/1.7.0/stern_linux_amd64 && \
       sudo chmod +x /usr/local/bin/stern

sudo apt-get update
sudo apt-get install -y unzip docker-compose

# https://github.com/docker/compose/issues/6023
chmod -x /usr/bin/docker-credential-secretservice

# add vagrant to docker group
sudo usermod -a -G docker vagrant

# add buildah and podman
sudo apt-get update -qq
sudo apt-get install -qq -y software-properties-common
sudo add-apt-repository -y ppa:projectatomic/ppa
sudo apt-get update -qq
sudo apt-get -qq -y install buildah podman

# configure default registry for buildah
cat << EOF >> /etc/containers/registries.conf
[registries.search]
registries = ['docker.io']
EOF

echo '10.30.30.10 vagrant.example.com vagrant' >> /etc/hosts
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # use global directory
  config.vm.synced_folder '.', '/vagrant'

  config.vm.box = "ubuntu/bionic64"

  # SHELL PROVISIONING
  # config.vm.provision :shell, :path => "provision.sh"
  config.vm.provision "shell", inline: $script

  config.vm.provision "docker"

  config.vm.define "server", autostart: true do |host|
      host.vm.network "forwarded_port", guest: 8080, host: 8080
      host.vm.network "forwarded_port", guest: 8081, host: 8081
      host.vm.network "forwarded_port", guest: 8082, host: 8082
      host.vm.network "forwarded_port", guest: 8083, host: 8083
      host.vm.network "forwarded_port", guest: 8084, host: 8084

      host.vm.network "private_network", ip: "10.30.30.10"
      host.vm.hostname = "vagrant.example.com"
      host.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 1
      end
  end
end
