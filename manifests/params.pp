class tuned::params {

  $package_name = [ 'tuned', 'tuned-utils' ]
  

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
