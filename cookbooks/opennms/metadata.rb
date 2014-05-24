name             'opennms'
maintainer       'OpenNMS Community'
maintainer_email 'ronny@opennms.org'
license          'GPLv3+'
description      'Installs/Configures opennms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.4'

recipe 'opennms', 'Installs open source enterprise network management platform OpenNMS'

depends 'java'
depends 'postgresql'

%w(ubuntu debian redhat centos fedora).each do |os|
  supports os
end
