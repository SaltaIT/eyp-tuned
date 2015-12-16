define tuned::profile (
                        $profile_name=$name,
                        $includeprofile=undef,
                        $vm=undef,
                        $sysctl=undef,
                        $enable=false,
                      ) {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($profile_name!="virtual-guest")
  {
    validate_hash($vm)
    validate_hash($sysctl)

    file { "/etc/tuned/${profile_name}":
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }

    file { "/etc/tuned/${profile_name}/tuned.conf":
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/profile.erb"),
      require => File["/etc/tuned/${profile_name}"],
    }
  }

  if($enable)
  {
    #nomes vull que un profile pugui estar habilitat, pertant no port
    #incloure variables, si es declaren dos enable han de fer colisio
    exec { 'enable profile tuned':
      command => "tuned-adm profile ${profile_name}",
      unless => "tuned-adm active | grep -E '${profile_name}$'",
    }
  }

}
