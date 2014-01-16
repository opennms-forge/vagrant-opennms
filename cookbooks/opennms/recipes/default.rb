
# Platform dependend install from OpenNMS repository
if platform?("redhat", "centos", "fedora")

  execute "install #{node[:opennms][:jdk_package]}" do
    command "yum -y install #{node[:opennms][:jdk_package]}"
    action :run
  end

  # code for only redhat family systems.
  execute "install opennms" do
    command "yum -y install opennms"
    action :run
  end
end

# Install preconfigured configuration files for database connection
# and OpenNMS
template "#{node[:opennms][:opennms_home]}/etc/opennms-datasources.xml" do
  source "opennms-datasources.xml.erb"
  owner "root"
  group "root"
  mode "0640"
  variables({
    :postgres_pass => node['postgresql']['password']['postgres']
  })
end

# Configure start timeout and Java heap size
cookbook_file "#{node[:opennms][:opennms_home]}/etc/opennms.conf" do
  source "opennms.conf"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

# Configure OpenNMS for Java environment
execute "setup opennms java" do
  command "#{node[:opennms][:opennms_home]}/bin/runjava -s"
  action :run
end

# Install OpenNMS database schema
execute "install opennms database schema" do
  command "#{node[:opennms][:opennms_home]}/bin/install -dis"
  action :run
end

# Install opennms as service and set runlevel
service "opennms" do
  supports :status => true, :restart => true, :reload => true
  if node[:opennms][:jpda]
    start_command "service opennms -t start"
  end
  action [ :enable, :start ]
end

# Install firewall policy to allow access to TCP 8980
cookbook_file "/etc/sysconfig/iptables" do
  source "iptables"
  owner "root"
  group "root"
  mode "0644"
  action :create
end

service "iptables" do
  supports :status => true, :restart => true, :reload => true
  action [ :restart ]
end

