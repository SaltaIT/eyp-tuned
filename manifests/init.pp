class tuned (
              $manage_package = true,
              $package_ensure = 'installed',
            ) inherits tuned::params {

  package { 'tuned':
    ensure => $ensure,
  }

}
