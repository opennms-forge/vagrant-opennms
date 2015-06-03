# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
Vagrant.configure(2) do |config|

  ##  Base image
  config.vm.box = "ubuntu/trusty64"

  ## OpenNMS WebUI and debug port
  config.vm.network "forwarded_port", guest: 8980, host: 8980
  config.vm.network "forwarded_port", guest: 8001, host: 8001

  config.vm.provider :virtualbox do |vb|
    vb.name = "Vagrant-OpenNMS"
    vb.customize ["modifyvm", :id, "--memory", "2048"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    # vb.gui = true
  end

  config.vm.provision :shell do |shell|
    shell.inline = "which chef-client || wget -qO- https://www.opscode.com/chef/install.sh | bash"
  end

  ## Provisioning settings
  config.vm.provision :chef_solo do |chef|
    chef.json = {
      :"ubuntu" => {
        :"archive_url" => "http://us.archive.ubuntu.com/ubuntu"
      },
      :"java" => {
        :"install_flavor" => "oracle",
        :"jdk_version" => "8",
        :"oracle" => {
          "accept_oracle_download_terms" => true
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
        :"storeByForeignSource" => "true"
      }
    }
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "postgresql::server"
    chef.add_recipe "opennms-light"
  end
end
