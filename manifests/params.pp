class tuned::params {

  $package_name = [ 'tuned', 'tuned-utils' ]
  $service_name_tuned = 'tuned'

  case $::osfamily
  {
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^6.*$/:
        {
            $service_name_ktune = 'ktune'
        }
        /^7.*$/:
        {
            $service_name_ktune = undef
        }

        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
