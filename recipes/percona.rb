#
# Cookbook Name:: sonar
# Recipe:: percona
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

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)

# randomly generate Sonar DB password
node.set_unless['sonar']['local_database']['password'] = secure_password

include_recipe 'percona::server'
include_recipe 'percona::toolkit'
include_recipe 'percona::monitoring'

sql_command = "/etc/mysql/mysql.sql"

template sql_command do
  source "mysql.sql.erb"
  owner "root"
  group "root"
  mode "0600"
end

execute "mysql-create-schema" do
  command "/usr/bin/mysql < #{sql_command}"
  action :nothing
  subscribes :run, resources("template[#{sql_command}]"), :immediately
end

node.set['sonar']['jdbc_url']="jdbc:mysql://localhost:3306/sonar?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance"
node.set['sonar']['jdbc_password'] = node['sonar']['local_database']['password']
