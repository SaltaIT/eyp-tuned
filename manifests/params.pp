class tuned::params {

  $package_name = [ 'tuned', 'tuned-utils' ]
  $service_name_tuned = 'tuned'
  $service_name_ktuned = 'ktuned'

  case $::osfamily
  {
    'redhat' :
    {
      case $::operatingsystemrelease
      {
        /^[67].*$/:
        {
        }
        default: { fail('Unsupported RHEL/CentOS version!')  }
      }
    }
    default  : { fail('Unsupported OS!') }
  }
}
