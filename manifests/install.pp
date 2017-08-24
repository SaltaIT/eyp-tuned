class tuned::install inherits tuned {

  if($tuned::manage_package)
  {
    package { $tuned::params::package_name:
      ensure => $tuned::package_ensure,
    }
  }
}
