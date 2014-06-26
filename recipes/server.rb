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

include_recipe "java::default"

# unzip into /opt
package "unzip" do
  action :install
end

execute "unzip-sonar" do
  cwd "/opt"
  command "unzip #{Chef::Config[:file_cache_path]}/#{node['sonar']['dist_file']}"
  creates node['sonar']['install_dir']
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/#{node['sonar']['dist_file']}" do
  source node['sonar']['dist_uri']
  checksum node['sonar']['dist_checksum']
  action :create
  notifies :run, "execute[unzip-sonar]", :immediately
end

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

# Make sure PID directory is writable
directory node['sonar']['pid_dir'] do
  owner node['sonar']['username']
  group node['sonar']['groupname']
  mode 00755
  action :create
end

# Certain of Sonar's directories need to be writable by it
%w{data logs temp war/sonar-server/deploy}.each do |d|
  directory "#{node['sonar']['install_dir']}/#{d}" do
    owner node['sonar']['username']
    group node['sonar']['groupname']
    mode 00755
    action :create
  end
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
  owner "root"
  group "root"
  mode 00644
  action :create
end

#Fix permissions for Sonar installation directory. Without this, sonar does not start. 
bash "Fix permissions for #{node['sonar']['install_dir']}" do
  code "chown -R #{node['sonar']['username']}:#{node['sonar']['groupname']} #{node['sonar']['install_dir']}"
end

service "sonar" do
  action :start
end
