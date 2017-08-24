class tuned (
              $manage_package        = true,
              $package_ensure        = 'installed',
              $manage_service        = true,
              $manage_docker_service = true,
              $service_ensure        = 'running',
              $service_enable        = true,
            ) inherits tuned::params {

  class { '::tuned::install': }
  -> class { '::tuned::config': }
  ~> class { '::tuned::service': }
  -> Class['::tuned']

}
