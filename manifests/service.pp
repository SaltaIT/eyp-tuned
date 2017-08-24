class tuned::service inherits tuned {

  #
  validate_bool($tuned::manage_docker_service)
  validate_bool($tuned::manage_service)
  validate_bool($tuned::service_enable)

  validate_re($tuned::service_ensure, [ '^running$', '^stopped$' ], "Not a valid daemon status: ${tuned::service_ensure}")

  $is_docker_container_var=getvar('::eyp_docker_iscontainer')
  $is_docker_container=str2bool($is_docker_container_var)

  if( $is_docker_container==false or
      $tuned::manage_docker_service)
  {
    if($tuned::manage_service)
    {
      service { $tuned::params::service_name_tuned:
        ensure => $tuned::service_ensure,
        enable => $tuned::service_enable,
      }

      if($tuned::params::service_name_ktune!=undef)
      {
        service { $tuned::params::service_name_ktune:
          ensure => $tuned::service_ensure,
          enable => $tuned::service_enable,
        }
      }
    }
  }
}
