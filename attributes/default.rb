#
# Cookbook Name:: sonar
# Attributes:: default
#
# Copyright 2012, SecondMarket Labs, LLC
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

default['sonar']['version'] = '3.4.1'

default['sonar']['username'] = 'sonar'
default['sonar']['groupname'] = 'sonar'

default['sonar']['dist_file'] = "sonar-#{node['sonar']['version']}.zip"
default['sonar']['dist_uri'] = "http://dist.sonar.codehaus.org/#{node['sonar']['dist_file']}"
default['sonar']['dist_checksum'] = 'bb626c8346f4b20bef0cb13cc531a41496a9dc9ae13ae5075d3cc0a641d9f966'

default['sonar']['install_dir'] = "/opt/sonar-#{node['sonar']['version']}"
default['sonar']['pid_dir'] = '/var/run/sonar'

default['sonar']['web_port'] = 9000
default['sonar']['web_context'] = '/sonar'

# Attributes for local database. These are the defaults (for an embedded H2 database)
default['sonar']['jdbc_url'] = 'jdbc:h2:tcp://localhost:9092/sonar'
default['sonar']['jdbc_username'] = 'sonar'
default['sonar']['jdbc_password'] = 'sonar'
default['sonar']['jdbc_driver'] = 'org.h2.Driver'
