opennms Cookbook
================
[![Build Status](https://travis-ci.org/indigo423/chef-opennms.svg)](https://travis-ci.org/indigo423/chef-opennms)

[travis]: https://travis-ci.org/indigo423/chef-opennms

This cookbook allows to configure  an install the enterprise network management platform OpenNMS. The cookbook supports Linux distribution from Red Hat and Debian family.

The cookbook can be tested using `kitchen` and `Vagrant` is preconfigured with a minimal Ubuntu Server 14.04 LTS and Centos 6.5 image. See:
- `kitchen list`
- `kitchen converge [INSTANCE|REGEXP|all]`

Requirements
------------
- `java`Oracle or OpenJDK in version 7
- `postgresql`
- `VirtualBox` and `Chef DK` if you want to contribute and/or test the cookbook.

Hints:
------------
- If run on Ubuntu >= 14.04 LTS please set postgres version manually to '9.3'.
- CentOS 6.5 installs the default PostgreSQL server 8.4.

Dependencies
------------
The OpenNMS cookbook depends on the cookbook `java` and `postgresql`. The  cookbook dependencies are handled by `Berkshelf`.  The  Java and Postgres cookbooks are preconfigured to met the requirements for running OpenNMS. The following default attributes are set:

### java
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['java']['install_flavor']</tt></td>
    <td>String</td>
    <td>Set the Java environment used for OpenNMS. Please check the Java cookbook README to see which flavors are valid.</td>
    <td><tt>openjdk</tt></td>
  </tr>
  <tr>
    <td><tt>['java']['jdk_version']</tt></td>
    <td>Integer</td>
    <td>Set the Java version used for OpenNMS. Please check the Java cookbook README to see which flavors are valid.</td>
    <td><tt>7</tt></td>
  </tr>
</table>

### postgresql
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['postgresql']['password']['postgres']</tt></td>
    <td>String</td>
    <td>Set a password for the Postgres user</td>
    <td><tt>opennms_pg</tt></td>
  </tr>
  <tr>
    <td><tt>['postgresql']['pg_hba']</tt></td>
    <td>Array</td>
    <td>Configure access to Postgres using MD5 password authentication</td>
    <td>
      <tt>
        [{:type => 'host', :db => 'all', :user => 'all', :addr => '127.0.0.1/32', :method => 'md5'},
        {:type => 'host', :db => 'all', :user => 'all', :addr => '::1/128', :method => 'md5'}]
      </tt>
  </td>
  </tr>
</table>

Attributes
----------
The default configuration installs latest OpenNMS stable from official OpenNMS repositories with a default configuration. The following attributes can be modified to configure OpenNMS through Chef.

#### Database configuration: opennms::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['java_heap_space']</tt></td>
    <td>Integer</td>
    <td>Size for Java heap size in mega bytes.</td>
    <td><tt>1024</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['start_timeout'']</tt></td>
    <td>Integer</td>
    <td>Wait time interval in seconds used in OpenNMS init script to evaluate the OpenNMS service status during start and stop OpenNMS.</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['release']</tt></td>
    <td>String</td>
    <td>Which version of OpenNMS should be installed: <tt>stable</tt>, <tt>testing</tt>,<tt>unstable</tt>,<tt>snapshot</tt></td>
    <td><tt>stable</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['postgres']['admin']</tt></td>
    <td>String</td>
    <td>Postgres user name which has the permission to create and initialize the OpenNMS database scheme.</td>
    <td><tt>postgres</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['dbhost']</tt></td>
    <td>String</td>
    <td>Host or IP address for the Postgres database server</td>
    <td><tt>localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['dbport']</tt></td>
    <td>Integer</td>
    <td>TCP port where Postgres database is listening</td>
    <td><tt>5432</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['dbname']</tt></td>
    <td>String</td>
    <td>Postgres OpenNMS database name.</td>
    <td><tt>opennms</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['dbuser']</tt></td>
    <td>String</td>
    <td>Postgres user which allows access to the OpenNMS database.</td>
    <td><tt>opennms</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['dbpass']</tt></td>
    <td>String</td>
    <td>Postgres password for OpenNMS database user.</td>
    <td><tt>opennms</tt></td>
  </tr>
</table>

#### Configure RRD time series data technology: opennms::default
In OpenNMS you can choose between two RRD technologies `JRobin` and `RRDtool`. The given attributes allow to switch between the both technologies.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['library']['jrrd']</tt></td>
    <td>String</td>
    <td>Full path to <tt>libjrrd.so</tt>. On 32bit machines it is by default installed to <tt>/usr/lib/libjrrd.so</tt></td>
    <td><tt>/usr/lib64/libjrrd.so</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['strategyClass']</tt></td>
    <td>String</td>
    <td>Set the implementation for the RRD technology. <tt>JRobinRrdStrategy</tt> is for Java RRD implementation <tt>JRobin</tt>. If you want to use <tt>RRDtool</tt> you have to change it to <tt>JniRrdStrategy</tt>.</td>
    <td><tt>org.opennms.netmgt.rrd.jrobin.JRobinRrdStrategy</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['interfaceJar']</tt></td>
    <td>String</td>
    <td>The interface jar is necessary running OpenNMS with <tt>RRDtool</tt>. Configure the path <tt>jrrd.jar</tt>.</td>
    <td><tt>/usr/share/java/jrrd.jar</tt></td>
  </tr>
</table>

#### Configure RRD time series tuning parameters: opennms::default
In OpenNMS you can choose between two RRD technologies `JRobin` and `RRDtool`. The given attributes allow to switch between the both technologies.

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['usequeue']</tt></td>
    <td>Boolean</td>
    <td>Using write queueing system for create and update operations due slow I/O performance.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['writethreads']</tt></td>
    <td>Integer</td>
    <td>Amount of threads to process the queue and write to the disk.</td>
    <td><tt>2</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['queuecreates']</tt></td>
    <td>Boolean</td>
    <td>Defines whether RRD creates should be processed immediately or enqueued. Please don't change this from default. See issue NMS-6550 in issues.opennms.org</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['prioritizeSignificantUpdates']</tt></td>
    <td>Boolean</td>
    <td>Zero-values are flagged as *insignificant* and non-zero value as *significant*. In heavily-loaded sytems you can define how zero-values and non-zero values for RRD persistence are handled. By setting `true` insignificant updates are pushed down in priority compared to `significant` updates.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['maxInsigUpdateSeconds']</tt></td>
    <td>Integer</td>
    <td>Number of secons which on average all insignificant files will be promoted to the significant list to ensure all files will eventually get written. Setting the value to <tt>0</tt> means don't promote insignificant files at all.</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['modulus']</tt></td>
    <td>Integer</td>
    <td>Modulus defines how often statistics from queuing system are printed. <tt>(updateCount % modulus == 0 ) then printStats;</tt></td>
    <td><tt>10000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['inSigHighWaterMark']</tt></td>
    <td>Integer</td>
    <td>On some very large installations it is possible to overwhelm the I/O system of the NMS and continue queuing data until all of the JVM memory is used up. The next three properties indicated high water marks beyond which collected data will be thrown away because it is not possible to continue queuing collected data. The best mix of values for these will need to be experimentally determined based on your data collection requirements and I/O subsystem capabilities. When the totalOperationsPending value reaches or is higher than the value of the below high water mark, any newly enqueued insignificant operations will be discarded.  This will allow for the loss of only zero valued data and may be sufficient to keep your system from becoming overwhelmed. The default value is 0L (don't discard insignificant operations)</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['sigHighWaterMark']</tt></td>
    <td>Integer</td>
    <td> When the totalOpsPending value reaches or is higher than the value of the below high water mark, any newly enqueue signficant operations will be discarded.  This will allow the system to 'catch up' by writing a higher percentage of high throughput insignificant operations. The default value is 0L (don't discard significant operations</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['queueHighWaterMark']</tt></td>
    <td>Integer</td>
    <td>When the totalOpsPending value reaches or is higher than the value of the below high water mark, any newly enqueued operations or any sort will be discarded, this will prevent the queue from using up all the memory of the system and eventually crashing the JVM. The default value is 0L (don't discard operations)</td>
    <td><tt>0</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['writethread']['sleepTime']</tt></td>
    <td>Integer</td>
    <td>The following constants are related to how long a write thread lingers before it exits.  You probably don't need to change these.</td>
    <td><tt>50</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['queuing']['writethread']['exitDelay']</tt></td>
    <td>Integer</td>
    <td>The following constants are related to how long a write thread lingers before it exits.  You probably don't need to change these.</td>
    <td><tt>60000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['jrobin']['rrdBackendFactory']</tt></td>
    <td>String</td>
    <td>The following property sets the default JRobin backend Factory. Acceptable values are: 
    - <tt>FILE</tt>: Standard RRD algorithm, cache when possible and no locking
    - <tt>SAFE</tt>: Aggressive locking and low levels of caching. Untested
    - <tt>NIO</tt>: MMAPped RRDs, using NIO
    - <tt>MNIO</tt>: NIO ByteBuffer RRD implementation. This will become the default in future OpenNMS releases. Note that this will use more memory than <tt>FILE</tt>. The additional memory usage is nominal, but can be can be computed with: <tt>additinal memory = (jrb file size) * (number of queued write threads)</tt>. When queuing is disabled, the number of write threads becomes the number of Collectd threads since it is these threads that with then do the persisting.
    - <tt>MEMORY</tt>: In-memory only
    </td>
    <td><tt>FILE</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['usetcp']</tt></td>
    <td>Boolean</td>
    <td> If you would like to export performance data to an external system over a TCP port, please set org.opennms.rrd.usetcp to <tt>true</tt> and fill in your values for the external listener.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['tcp']['host']</tt></td>
    <td>String</td>
    <td>The IPv4 address or hostname of the target system.</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rrd']['tcp']['port']</tt></td>
    <td>Integer</td>
    <td>The TCP port where the target system is listening for performance data.</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms']['storeByGroup']</tt></td>
    <td>Boolean</td>
    <td>On very large systems the OpenNMS default mechanism of storing one data source per RRD file can be very I/O Intensive.  Many I/O subsystems fail to keep up with the vast amounts of data that OpenNMS can collect in this situation.  We have found that in those situations having fewer large files with multiple data sources in each performs better than many smaller files, each with a single data source. This option enables all of the data sources belonging to a single collection group to be stored together in a single file. To enable this setting uncomment the below line and change it to <tt>true</tt>.
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['storeByForeignSource']</tt></td>
    <td>Boolean</td>
    <td>By default, data collected for a node with nodeId n is stored in the directory <tt>${rrd.base.dir}/snmp/n</tt> . If the node is deleted and re-added, it will receive a new *nodeId*, and subsequent data will be stored in a new directory. This can create problems in data continuity if a large number of nodes get deleted and re-added either accidentally or intentionally. This option enables an alternate storage location for nodes that are provisioned (i.e. they have a *foreignSource* and *foreignId* defined) If *storeByForeignSource* is set to <tt>true</tt>, a provisioned node will have its data stored by *foreignSource/ForeignId* rather than *nodeId*. For example, a node with *foreignSource/foreignId* *mysource/12345* will have its data stored in <tt>${rrd.base.dir}/snmp/fs/mysource/12345</tt>. With this option enabled, data collection will continue to use the same storage location as long as the *foreignSource/foreignId* is not redefined, regardless of how many times the node may be deleted and re-added.
    </td>
    <td><tt>false</tt></td>
  </tr>
</table>

#### Configure Jetty application container: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['jetty']['port']</tt></td>
    <td>Integer</td>
    <td>TCP port for Jetty running the OpenNMS web application.</td>
    <td><tt>8980</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['web']['baseurl']</tt></td>
    <td>String</td>
    <td>URL schema accessing the OpenNMS web application. If you have OpenNMS running behind a SSL reverse proxy, change this value, e.g. <tt>https://%x%c</tt>.</td>
    <td><tt>http://%x%c/</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['jetty']['requestHeaderSize']</tt></td>
    <td>Integer</td>
    <td>This sets the request header size for jetty. The default value is 4000 bytes.</td>
    <td><tt>4000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['jetty']['maxFormKeys']</tt></td>
    <td>Integer</td>
    <td>This sets the maximum number of items that can be in web forms (like the Provisioning web UI)</td>
    <td><tt>2000</tt></td>
  </tr>
</table>

#### Configure OpenNMS web application: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['propertiesCache']['enableCheckFileModified']</tt></td>
    <td>Boolean</td>
    <td>Enable an aggresive validation against the last modification time of the strings. properties files. This is useful only if the OpenNMS WebUI is running on a different server.Check NMS-5806 for more details.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['webaclsEnabled']</tt></td>
    <td>Boolean</td>
    <td>This property is for enabling acl support in the webapp.  With ACLs enabled then Nodes, Alarms, Events etc. are filtered according to the authorized groups list on onms categories.  In other words. For a user to set the events, outages etc for a particular node then that user has to be authorized for a category that the node belongs to</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['assets']['allowHtmlFields']</tt></td>
    <td>String</td>
    <td>By default, all scripts and HTML markup are stripped from the values submitted for node asset information. This measure is to protect against cross-site scripting and other types of attacks on the web UI. To allow markup (but still not scripts) in certain asset fields, set this property's value to a comma-separated list of asset field names. A full list of field names can be obtained by exporting all asset data to a CSV file from the web UI.</td>
    <td><tt>comments, description</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['eventlist']['acknowledge']</tt></td>
    <td>Boolean</td>
    <td>This value allows you to show or hide the Acknowledge event button. This is only here for those who still acknowledge events. We are moving away from this and towards acknowledging alarms instead of events.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['eventlist']['showCount']</tt></td>
    <td>Boolean</td>
    <td>This value allows you to configure whether or not the total event count is shown in the event list in the web UI. Setting this to <tt>true</tt> can cause severe performance issues for larger installations.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['nodesWithOutages']['count']</tt></td>
    <td>Integer</td>
    <td>This value allows you to set the number of nodes with outages to display on the front page in the OpenNMS web UI.</td>
    <td><tt>12</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['nodesWithOutages']['show']</tt></td>
    <td>Boolean</td>
    <td>This value allows you to enable/disable the nodes with outages box on the front page in the OpenNMS web UI.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['nodesWithProblems']['count']</tt></td>
    <td>Integer</td>
    <td>This value allows you to set the number of nodes with problems to display on the front page in the OpenNMS web UI.</td>
    <td><tt>16</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['nodesWithProblems']['show']</tt></td>
    <td>Boolean</td>
    <td>This value allows you to enable/disable the nodes with problems box on the front page in the OpenNMS web UI.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['nodeStatusBar']['show']</tt></td>
    <td>Boolean</td>
    <td>This value allows you to enable/disable the status bar resume at the top of the node page in the OpenNMS web UI.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['disableLoginSuccessEvent']</tt></td>
    <td>Boolean</td>
    <td>This value disables the sending of successful login events. The default is to send the event. Change this value to true to disable the publishing of this event.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['ksc']['graphsPerLine']</tt></td>
    <td>Integer</td>
    <td>Define default amount of graphs for KSC reports per line.</td>
    <td><tt>1</tt></td>
  </tr>
</table>

#### Configure geographical map implementation: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['maptype']</tt></td>
    <td>String</td>
    <td>Map implementation to use current choices are: <tt>GoogleMaps</tt>, <tt>Mapquest</tt>, <tt>OpenLayers</tt></td>
    <td><tt>OpenLayers</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['apikey']</tt></td>
    <td>String</td>
    <td>The API key to use for the remote monitor map</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms']['geocoder']['class']</tt></td>
    <td>String</td>
    <td>- Google maps API: <tt>gwt.geocoder.class=org.opennms.features.poller.remote.gwt.server.geocoding.GoogleMapsGeocoder</tt>
    - Mapquest API: <tt>gwt.geocoder.class=org.opennms.features.poller.remote.gwt.server.geocoding.MapquestGeocoder</tt>
    - OpenStreetMaps API: <tt>gwt.geocoder.class=org.opennms.features.poller.remote.gwt.server.geocoding.NominatimGeocoder</tt>
    - OpenNMS World HQ: <tt>org.opennms.features.poller.remote.gwt.server.geocoding.NullGeocoder</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['geocoder']['rate']</tt></td>
    <td>Integer</td>
    <td>The rate at which to make requests, for geocoders that support it.</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['geocoder']['referer']</tt></td>
    <td>String</td>
    <td>The referer to use when making geocoding requests, for geocoders that support it. For MapQuest, the value you set here will need to be allowed in your AppKeys manager: http://developer.mapquest.com/web/info/account/app-keys</td>
    <td><tt>http://localhost</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['geocoder']['minimumQuality']</tt></td>
    <td>String</td>
    <td>The minimum quality level to require before rejecting a geocoding request. This is currently only used by MapQuest. Choices are (least to most specific): <tt>COUNTRY</tt>, <tt>STATE</tt>, <tt>ZIP</tt>, <tt>COUNTY</tt>, <tt>ZIP_EXTENDED</tt>, <tt>CITY</tt>, <tt>STREET</tt>, <tt>INTERSECTION</tt>, <tt>ADDRESS</tt>, <tt>POINT</tt></td>
    <td><tt>ZIP</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['geocoder']['nominatimEmail']</tt></td>
    <td>String</td>
    <td>The email address to report as when making geocoding requests. This is currently only used by Nominatim, and MUST be set!</td>
    <td></td>
  </tr>
  <tr>
    <td><tt>['opennms']['openlayersUrl']</tt></td>
    <td>String</td>
    <td>Open MapQuest tile server</td>
    <td><tt>http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png</tt></td>
  </tr>
</table>

#### Configure RTC for Eventd and geographical map: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['event']['proxyHost']</tt></td>
    <td>String</td>
    <td>The hostname or IP address of the OpenNMS server where events should be sent.</td>
    <td><tt>127.0.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['event']['proxyPort']</tt></td>
    <td>Integer</td>
    <td>The TCP port for the eventd TCP receiver where events should be sent.</td>
    <td><tt>5817</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['event']['proxyTimeout']</tt></td>
    <td>Integer</td>
    <td>The timeout in milliseconds the proxy will wait to complete a TCP connection.</td>
    <td><tt>2000</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['client']['httpPostBaseUrl']</tt></td>
    <td>String</td>
    <td>The base of a URL that RTC clients use when creating a RTC subscription URL. If you are using Tomcat instead of the built-in Jetty, change this in WEB-INF/configuration.properties instead.</td>
    <td><tt>http://localhost:8980/opennms/rtc/post</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['client']['httpPostUsername']</tt></td>
    <td>String</td>
    <td>The username the RTC uses when authenticating itself in an HTTP POST.</td>
    <td><tt>rtc</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['rtc']['client']['httpPostPassword']</tt></td>
    <td>String</td>
    <td>The password the RTC uses when authenticating itself in an HTTP POST.</td>
    <td><tt>rtc</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['map']['client']['httpPostBaseUrl']</tt></td>
    <td>String</td>
    <td>The base of a URL that Map System clients use when creating a Map subscription URL. If you are using Tomcat instead of the built-in Jetty, change this in WEB-INF/configuration.properties instead.</td>
    <td><tt>http://localhost:8980/opennms/map/post'</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['map']['client']['httpPostUsername']</tt></td>
    <td>String</td>
    <td>The username the Map System uses when authenticating itself in an HTTP POST.</td>
    <td><tt>map</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['map']['client']['httpPostPassword']</tt></td>
    <td>String</td>
    <td>The password the Map System uses when authenticating itself in an HTTP POST.</td>
    <td><tt>map</tt></td>
  </tr>
</table>

#### Configure SNMP implementation and Collectd: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['snmp']['strategyClass']</tt></td>
    <td>String</td>
    <td>OpenNMS provides two different SNMP implementations. JoeSNMP is the original OpenNMS SNMP Library and provides SNMP v1 and v2 support. SNMP4J is a new 100% Java SNMP library that provides support for SNMP v1, v2 and v3. To enable the JoeSnmp library set the strategy class to `org.opennms.snmp.strategyClass=org.opennms.netmgt.snmp.joesnmp.JoeSnmpStrategy`.</td>
    <td><tt>org.opennms.netmgt.snmp.snmp4j.Snmp4JStrategy</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['snmp4j']['forwardRuntimeExceptions']</tt></td>
    <td>Boolean</td>
    <td>When debugging SNMP problems when using the SNMP4J library, it may be helpful to receive runtime exceptions from SNMP4J. These exceptions almost always indicate a problem with an SNMP agent. Any that we don't catch will end up in output.log, so they're disabled by default, but they may provide more information (albeit without timestamps) than the messages that SNMP4J logs (see snmp4j.LogFactory)
    </td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['snmpCollector']['forceRescan']</tt></td>
    <td>Boolean</td>
    <td>Control sending force rescans from the SNMP Collector.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['snmpCollector']['limitCollectionToInstances']</tt></td>
    <td>Boolean</td>
    <td>For systems with very large numbers of interfaces we may be unable to collect all the data by scanning the entire table in the specified time interval. If only a few instances are being collected then we can limit the collection to only those instances and save collection time but possible *getting* confused by instance changes. Set this to <tt>true</tt> to enable instance limiting.</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['datacollection']['reloadCheckInterval']</tt></td>
    <td>Integer</td>
    <td>Specifies the amount of time to wait (expressed in milliseconds) until the reload container physically checks if the datacollection-config.xml file has been changed.</td>
    <td><tt>30000</tt></td>
  </tr>
</table>

#### Configure Provisiond: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['enableDiscovery']</tt></td>
    <td>Boolean</td>
    <td>This property is used to enable/disable the handling of new suspect events in provisiond along with periodic scanning of discovered nodes.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['enableDeletionOfRequisitionedEntities']</tt></td>
    <td>Boolean</td>
    <td>Prior to 1.10 it was possible to delete entities that have been provisioned as part of a provisioning group. In 1.10 we have disabled this so that in order to delete these entities you have to go back to the provisioning group and delete them from there. To reenable this deletion you can set this to true. NOTE: if you do this then the object will be recreated when the provisioning group is next imported/synchronized</td>
    <td><tt>false</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['scheduleRescanForExistingNodes']</tt></td>
    <td>Boolean</td>
    <td>This property is used to control the rescan scheduling existing nodes in the database when Provisiond starts. There are situations like distributed environments, where OpenNMS is deployed across multiple servers, on which this feature must be disabled to avoid continuity issues. In this scenario, most likely the inventory of nodes should not be managed by all OpenNMS instances.</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['scheduleRescanForUpdatedNodes']</tt></td>
    <td>Boolean</td>
    <td>Use this property to disable rescans of existing nodes following an import (synchronize) of a provisioning group (requistion).</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['importThreads']</tt></td>
    <td>Integer</td>
    <td>Amount of threads for importing systems into OpenNMS with Provisiond</td>
    <td><tt>8</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['scanThreads']</tt></td>
    <td>Integer</td>
    <td>Amount ot threads scanning new imported systems with Provisiond</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['rescanThreads']</tt></td>
    <td>Integer</td>
    <td>Amount of threads for rescan existing nodes with Provisiond.</td>
    <td><tt>10</tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['provisiond']['writeThreads']</tt></td>
    <td>Integer</td>
    <td>Amount of threads persisting scanned and discovered nodes with Provisiond</td>
    <td><tt>8</tt></td>
  </tr>
</table>

#### Configure remote poller: opennms::default

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['opennms']['minimumConfigurationReloadInterval']</tt></td>
    <td>Integer</td>
    <td>This setting is the minimum amount of time between reloads of a remote poller configuration in milliseconds because of global changes. This value should never be set less the 300000 (5 minutes) except to set it to zero which means never only reload the configuration if the location monitors status has been set to CONFIG_CHANGED.</td>
    <td><tt> 300000 </tt></td>
  </tr>
  <tr>
    <td><tt>['opennms']['excludeServiceMonitorsFromRemotePoller']</tt></td>
    <td>String</td>
    <td>This setting enables OpenNMS to exclude all references to certain services from the poller configuration that it sends to the remote location monitors. This is necessary when monitor classes are in use that are not included in the remote poller builds. Without this setting, the remote poller will crash on startup (see issue NMS-5777) even if none of the problematic services appears in any package. If you create custom services, you may need to add them to this list.</td>
    <td><tt>DHCP,NSClient,RadiusAuth,XMP</tt></td>
  </tr>
</table>

Usage
-----
#### opennms::default
This cookbook will install OpenNMS with all default settings. You have just include `opennms` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opennms]"
  ]
}
```

#### opennms::remote-poller
This cookbook will install OpenNMS with all default settings. You have just include `opennms` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[opennms:remote-poller]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors:
- Author: Ronny Trommer ronny@opennms.org
