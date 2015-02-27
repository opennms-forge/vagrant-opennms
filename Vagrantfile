# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ###################
  ##  Base image
  ##############

  # Run with CentOS 7.0
  # config.vm.box = "centos-7.0"

  # Run with Ubuntu 14.04
  config.vm.box = "ubuntu-14.04"

  # Download URL CentOS 7.0
  # config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.0_chef-provisionerless.box"

  # Download URL Ubuntu 14.04
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box"

  ###################
  ## Network configuration
  ##############

  config.vm.network "forwarded_port", guest: 8980, host: 8980
  config.vm.network "forwarded_port", guest: 8001, host: 8001

  ###################
  ## VM system settings
  ##############

  config.vm.provider :virtualbox do |vb|
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    # vb.gui = true
  end

  ###################
  ## Install Chef client
  ##############

  config.vm.provision :shell do |shell|
    shell.inline = "which chef-client || wget -qO- https://www.opscode.com/chef/install.sh | bash"
  end

  ###################
  ## Provisioning settings
  ##############

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :"tz" => "Europe/Berlin",
      :"timezone" => {
        :"use_symlink" => true,
      },
      :"java" => {
        :"install_flavor" => "openjdk",
        :"jdk_version" => "7",
        :"oracle" => {
          "accept_oracle_download_terms" => false
        }
      },
      :"postgresql" => {
        :"password" => {
          :"postgres" => "opennms_pg"
        }
      },
      :"opennms" => {
        :"release" => "stable", #stable, testing, unstable, snapshot, bleeding
        :"jpda" => "false",
        :"home" => "/usr/share/opennms",
        :"java_heap_space" => "1024",
        :"repository" => {
          :"yum" => "yum.opennms.org",
          :"apt" => "debian.opennms.org"
        },
        :"library" => {
          :"jrrd" => "/usr/lib/jni/libjrrd.so"
        },
        :"rrd" => {
          :"strategyClass" => "org.opennms.netmgt.rrd.rrdtool.JniRrdStrategy",
          :"interfaceJar" => "/usr/share/java/jrrd.jar"
        },
        :"storeByGroup" => "false",
        :"storeByForeignSource" => "false"
      }
    }
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "timezone-ii"
    chef.add_recipe "opennms-light"
  end
end
