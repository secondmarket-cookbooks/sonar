#
# Cookbook Name:: sonar
# Attributes:: default
#
# Copyright 2015, Antek S. Baranski
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

include_attribute 'java'

default['sonar']['version'] = '5.0.1'

default['sonar']['username'] = 'sonar'
default['sonar']['groupname'] = 'sonar'

default['sonar']['dist_file'] = "sonarqube-#{node['sonar']['version']}.zip"
default['sonar']['dist_uri'] = "http://dist.sonar.codehaus.org/#{node['sonar']['dist_file']}"
default['sonar']['dist_checksum'] = 'cbc4ea2f6c00e3af9659a2d4aa548fb85887c153ca1e6086ebe4e33a6d538112'

default['sonar']['install_root'] = '/opt'
default['sonar']['install_dir'] = "#{node['sonar']['install_root']}/sonarqube-#{node['sonar']['version']}"
default['sonar']['pid_dir'] = '/var/run/sonar'
default['sonar']['path']['data'] = "#{node['sonar']['install_dir']}/data"
default['sonar']['path']['temp'] = "#{node['sonar']['install_dir']}/temp"
default['sonar']['path']['logs'] = '/var/log/sonar'

default['sonar']['web']['host'] = '0.0.0.0'
default['sonar']['web']['port'] = 8000
default['sonar']['web']['context'] = 'sonar'

default['sonar']['db']['server'] = 'localhost'
default['sonar']['db']['port'] = 9002

# Attributes for local database. These are the defaults (for an embedded H2 database)
default['sonar']['jdbc_url'] = "jdbc:h2:tcp://#{node['sonar']['db']['server']}:#{node['sonar']['db']['port']}/sonar"
default['sonar']['jdbc_username'] = 'sonar'

#----- Embedded Database (default)
# It does not accept connections from remote hosts, so the
# server and the analyzers must be executed on the same host.
#sonar.jdbc.url=jdbc:h2:tcp://localhost:9092/sonar

# H2 embedded database server listening port, defaults to 9092
#sonar.embeddedDatabase.port=9092


#----- MySQL 5.x
#default['sonar']['jdbc_url']="jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance"


#----- Oracle 10g/11g
# - Only thin client is supported
# - Only versions 11.2.* of Oracle JDBC driver are supported, even if connecting to lower Oracle versions.
# - The JDBC driver must be copied into the directory extensions/jdbc-driver/oracle/
# - If you need to set the schema, please refer to http://jira.codehaus.org/browse/SONAR-5000
#sonar.jdbc.url=jdbc:oracle:thin:@localhost/XE


#----- PostgreSQL 8.x/9.x
# If you don't use the schema named "public", please refer to http://jira.codehaus.org/browse/SONAR-5000
#sonar.jdbc.url=jdbc:postgresql://localhost/sonar


#----- Microsoft SQLServer 2005/2008
# Only the distributed jTDS driver is supported.
#sonar.jdbc.url=jdbc:jtds:sqlserver://localhost/sonar;SelectMethod=Cursor

default['java']['jdk_version'] = 7
