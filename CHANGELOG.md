##2.0.0
* Install SonarQube 5.0.1
* Update sonar.properties for 5.x
* Added Percona DB support
* Rename local_database to postgresql recipe
* Migrated to Berks 3.x
* Install java runtime as part of Sonar server install
* Install Sonar using 'ark' cookbook
* Make data/temp & logs directories configureable

##1.0.3

Upgrade to Sonar 3.4.1. Foodcritic conformance. Permissions fixes so that not everything under /opt/sonar-3.4.1 has to be owned by 'sonar', just the directories it needs to write to.

##1.0.2

Upgrade to Sonar 3.4

##1.0.1

Upgrade to Sonar 3.3.1. Added recipe for managing the database with the 'database' cookbook.

##1.0.0

Initial release
