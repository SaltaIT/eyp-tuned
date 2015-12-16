# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class tuned($ensure='installed') inherits tuned::params {

  package { 'tuned':
    ensure => $ensure,
  }


}
