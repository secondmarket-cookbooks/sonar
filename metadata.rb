name             "sonar"
maintainer       "SecondMarket Labs, LLC"
maintainer_email "systems@secondmarket.com"
license          "All rights reserved"
description      "Installs and configures Sonar code coverage tool"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.0"

depends 'openssl'
depends 'postgresql'
depends 'database'
depends 'percona'
depends 'java'
