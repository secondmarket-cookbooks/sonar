#
# Cookbook Name:: sonar
# Recipe:: proxy
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

user node['nginx']['user'] do
  system true
  action :create
end

group node['nginx']['group'] do
  action :create
  members node['nginx']['user']
end

directory "#{node['nginx']['default_root']}/#{node['sonar']['web']['context']}" do
  owner node['nginx']['user']
  group node['nginx']['group']
  mode 0755
  recursive true
  action :create
end

directory "#{node['nginx']['log_dir']}/#{node['sonar']['web']['context']}" do
  owner node['nginx']['user']
  group node['nginx']['group']
  mode 0755
  recursive true
  action :create
end

include_recipe 'nginx::openssl_source'
include_recipe 'nginx::http_ssl_module'
include_recipe 'nginx::source'

node.set['sonar']['web']['host'] = '127.0.0.1' if node['sonar']['web']['host'] == '0.0.0.0'

template "#{node['nginx']['dir']}/sites-available/#{node['sonar']['web']['context']}_proxy" do
  source 'proxy.erb'
  owner  'root'
  group  'root'
  mode   '0644'
  notifies :reload, 'service[nginx]'
end

nginx_site("#{node['sonar']['web']['context']}_proxy")
