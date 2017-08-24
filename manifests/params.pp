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
            $service_name_ktuned = 'ktuned'
        }
        /^7.*$/:
        {
            $service_name_ktuned = undef
        }

        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
