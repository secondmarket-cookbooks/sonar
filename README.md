Description
===========

Installs [SonarQube](http://www.sonarqube.org), an open source platform for Continuous Inspection of code quality.

Requirements
============

## Platforms

* CentOS 6/7
* RedHat Enterprise Linux 6/7
* Ubuntu 12.04/14.04

## Dependencies

* java
* database
* postgresql
* percona
* openssl
* ark
* nginx

Attributes
==========

Path options:
* `node['sonar']['install_root']` - Sonar's root installation directory '/opt' by default.
* `node['sonar']['path']['data']` - Sonar's embedded database data directory
* `node['sonar']['path']['temp']` - Sonar's temp data directory
* `node['sonar']['path']['logs']` - Sonar's log directory, default /var/log/sonar.

Web host options:
* `node['sonar']['web']['host']` - The ip on which Sonar's Jetty should listen.
* `node['sonar']['web']['port']` - The port on which Sonar's Jetty should listen.
* `node['sonar']['web']['context']` - The web context under which to serve Sonar. '/sonar' is the default, but '/' could work too.

Sonar requires the use of an SQL database. If you use either the postgresql or percona recipes (below),
these variables will be set for you:

* `node['sonar']['jdbc_url']` - JDBC URL at which Sonar's database can be found.
* `node['sonar']['jdbc_username']` - JDBC username for the aforementioned database

Recipes
=======

## default

Download and unpack SonarQube into /opt, set up filesystem permissions, write out a Sonar config file,
start it up as a service, with an embedded H2 database.

## postgresql

Sets up a local PostgreSQL database for SonarQube to talk to.

## percona

Sets up a local Percona database for SonarQube to talk to.

##proxy

Sets up a nginx reverse proxy in front of SonarQube.

Roadmap
=======

* Support databases on machines other than "localhost".

License and Author
==================

- Author:: Antek S. Baranski <antek.baranski@gmail.com>
- Author:: Julian C. Dunn <jdunn@secondmarket.com>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
