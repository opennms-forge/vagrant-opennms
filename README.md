vagrant-opennms
===============
Vagrant provides a good environment for testing, debugging OpenNMS. It can also provide you an environment to migrate your configuration to newer versions or test new functionalities from feature branches and future versions. The Vagrant box of OpenNMS requires the following:
- VirtualBox 4.2+ http://www.virtualbox.org
- Vagrant 1.4+ http://www.vagrantup.com
- Git http://www.git-scm.com
- *NIX based operating system

*Hint*: If you want to use Microsoft based operating system, please make sure you use Git under cygwin like http://msysgit.github.io. You will have issues with different line break handling between *NIX and Windows.

By default the virtual machine uses a no-worry-NAT network interface. To give you access to the virtual machine there is some preconfigured port forwarding:
- TCP guest 8980 to your host 8980 for the OpenNMS WebUI
- TCP guest 8001 to your host 8001 JPDA debugging support
- TCP guest 22 to your host 2222 for SSH access you can also just run `vagrant ssh`

Usage
-----
1. Install VirtualBox and Vagrant on your computer
2. Checkout this repository with `git clone https://github.com/opennms-forge/vagrant-opennms.git`
3. Change into vagrant-opennms
4. Run `vagrant up` to start the virtual machine
5. Connect in your browser to http://localhost:8980
6. Username is `vagrant` with password `vagrant` you can get root access with `sudo -i`

Under the hood
--------------
The Vagrantfile allows you to control the behavior of your virtual machine. On first run Vagrant will download a Vagrant basebox based on a minimal Centos 6.5. from the following location: http://mirror.informatik.hs-fulda.de/pub/vagrant/CentOS-6-x86_64-minimal.box

Based on this machine a setup of OpenNMS will be executed through Chef recipes. In detail:

**recipe:postgresql::server**:
- Install the PostgreSQL server

**recipe:yumrepo::opennms-common and yumrepo::opennms-rhel6**:
- Install the OpenNMS YUM repository for OpenNMS

**recipe:opennms**:
- Installing OpenJDK 7
- Install a preconfigured opennms-datasources.xml with authentication
- Install preconfigured opennms.conf
- Configure Java environment for OpenNMS with `runjava -s`
- Install OpenNMS database schema and libraries with `install -dis`
- Start opennms and add to runlevel for automatic start on boot
- Install iptables which allows SSH, TCP/8980 and TCP/8001

Customization through Vagrantfile
---------------------------------
It is possible to change some parameter through the Vagrantfile.
- `postgresql.password.postgres`: initialize the password by default to `opennms_pg`. If you change the password, the opennms-datasources.xml will also be changed
- `opennms.release`: Install OpenNMS as current stable release. You can change to `testing`,`snapshot`, `unstable`, `bleeding` or branches/{branchname}. With branches you can install feature branches which can be find in http://yum.opennms.org/branches
- `opennms.jpda`: allows to open the Java Remote debugging port to the JVM. You can connect with your IDE for example debugging issues

            chef.json = {
              :postgresql => {
                :password => {
                  :postgres => "opennms_pg"
                }
              },
              :opennms => {
                :release => "stable", #stable, testing, unstable, snapshot, bleeding
                :jpda => false
              }
            }
