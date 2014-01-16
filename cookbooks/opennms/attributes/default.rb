default[:opennms][:jpda] = false

case platform
  when "redhat", "centos", "scientific", "fedora", "suse", "amazon", "oracle"
    default[:opennms][:jdk_package] = 'java-1.7.0-openjdk-devel'
    default[:opennms][:opennms_home] = '/opt/opennms'
  when "debian", "ubuntu"
    default[:opennms][:jdk_package] = 'openjdk-7-jdk'
    default[:opennms][:opennms_home] = '/usr/share/opennms'
end
