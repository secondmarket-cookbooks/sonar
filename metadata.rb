name             "sonarqube"
maintainer       "Antek S. Baranski"
maintainer_email "antek.baranski@gmail.com"
license          "All rights reserved"
description      "Installs and configures Sonar code coverage tool"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends 'openssl'
depends 'postgresql'
depends 'database'
depends 'percona'
depends 'java'
depends 'ark'
depends 'nginx'
