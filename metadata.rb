name             "sonar"
maintainer       "SecondMarket Labs, LLC"
maintainer_email "systems@secondmarket.com"
license          "All rights reserved"
description      "Installs and configures Sonar code coverage tool"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.3"

%w{database openssl postgresql java}.each do |d|
  depends d
end
