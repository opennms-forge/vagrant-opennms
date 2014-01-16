name              "opennms"
maintainer        "Mike Huot"
maintainer_email  "mhuot@opennms.org"
license           "GPL v3"
description       "Installs OpenNMS and configures Postgres for use with OpenNMS"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1"

recipe "opennms", "Installs OpenNMS"

%w{
    debian
    ubuntu
    centos
    redhat
    scientific
    fedora
    amazon
    arch
    oracle
}.each do |os|
  supports os
end

depends "apt"
depends "postgresql"