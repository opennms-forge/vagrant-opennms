#
# Cookbook Name:: remote-poller
# Recipe:: default
#
# Copyright 2014, The OpenNMS Group, Inc.
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'redhat', 'centos', 'fedora'
  execute 'Install OpenNMS yum repository' do
    command "rpm -Uvh http://yum.opennms.org/repofiles/opennms-repo-#{node['opennms']['release']}-rhel6.noarch.rpm"
    not_if { ::File.exist?('/etc/yum.repos.d/opennms-#{node[:opennms][:release]}-rhel6.repo') }
  end

  execute 'Update yum repostory' do
    command 'yum -y update'
  end
when 'debian', 'ubuntu'
  # add-apt-repository: This is for all Ubuntu >= 14.04
  package "software-properties-common" do
    action :install
  end

  # add-apt-repository: This is for all Ubuntu < 14.04
  package "python-software-properties" do
    action :install
  end

  execute "Install OpenNMS apt repository" do
    command "add-apt-repository 'deb http://debian.opennms.org #{node['opennms']['release']} main'"
    action :run
  end
  
  remote_file "#{Chef::Config[:file_cache_path]}/OPENNMS-GPG-KEY" do
    source "http://debian.opennms.org/OPENNMS-GPG-KEY"
  end
  
  execute 'Install OpenNMS apt GPG-key' do
    command "sudo apt-key add #{Chef::Config['file_cache_path']}/OPENNMS-GPG-KEY"
    action :run
  end

  execute "APT repository update" do
      command "apt-get update"
      action :run
  end
end

package 'opennms-remote-poller' do
  action :install
end

template "/etc/init.d/opennms-remote-poller" do
    source "opennms-remote-poller.erb"
    owner "root"
    group "root"
    mode "0755"
end

execute "Create java.conf" do
    command "mkdir -p #{node['opennms']['home']}/etc && echo $(which java) > #{node['opennms']['home']}/etc/java.conf"
    action :run
end


# Install opennms-remote-poller as service and set runlevel
service 'opennms-remote-poller' do
  action [:enable, :start]
end
