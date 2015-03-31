#
# Cookbook Name:: sonar
# Recipe:: server
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

include_recipe 'java::default'

# create user
user node['sonar']['username'] do
  system true
  comment "Sonar Code Coverage Analysis Tool"
  action :create
end

group node['sonar']['groupname'] do
  system true
  action :create
end

ark "sonarqube-#{node['sonar']['version']}" do
  url node['sonar']['dist_uri']
  checksum node['sonar']['dist_checksum']
  path node['sonar']['install_root']
  owner node['sonar']['username']
  action :put
end

# Make sure PID directory is writable
directory node['sonar']['pid_dir'] do
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00755
  action :create
end

# create init script
template "/etc/init.d/sonar" do
  source "sonar.init.erb"
  owner "root"
  group "root"
  mode 00755
  action :create
end

service "sonar" do
  action :enable
end

template "#{node['sonar']['install_dir']}/conf/sonar.properties" do
  source "sonar.properties.erb"
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00744
  action :create
end

directory node['sonar']['path']['data'] do
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00744
  action :create
  recursive true
end

directory node['sonar']['path']['temp'] do
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00744
  action :create
  recursive true
end

directory node['sonar']['path']['logs'] do
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00744
  action :create
  recursive true
end

#Fix permissions for Sonar installation directory. Without this, sonar does not start. 
bash "Fix permissions for #{node['sonar']['install_dir']}" do
  code "chown -R #{node['sonar']['username']}:#{node['sonar']['groupname']} #{node['sonar']['install_dir']}"
end

service "sonar" do
  action :start
end
