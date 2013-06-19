name             "one"
maintainer       "Rob Lyon"
maintainer_email "rlyon@uidaho.edu"
license          "All rights reserved"
description      "Installs/Configures one"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.3"

depends "yum"
depends "sudo"
depends "mysql"
depends "database"
depends "apache2"
