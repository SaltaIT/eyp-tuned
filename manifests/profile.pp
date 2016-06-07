define tuned::profile (
                        $profile_name   = $name,
                        $includeprofile = undef,
                        $vm             = undef,
                        $sysctl         = undef,
                        $enable         = false,
                      ) {

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  if($profile_name!='virtual-guest')
  {
    if($vm!=undef)
    {
          validate_hash($vm)
    }

    if($sysctl!=undef)
    {
      validate_hash($sysctl)
    }

    file { "/etc/tuned/${profile_name}":
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }

    concat { "/etc/tuned/${profile_name}/tuned.conf":
      ensure  => 'present',
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      require => File["/etc/tuned/${profile_name}"],
    }

    #content => template("${module_name}/profile.erb"),
    concat::fragment{ "tuned.conf ${profile_name} header":
      target  => "/etc/tuned/${profile_name}/tuned.conf",
      order   => '00',
      content => template("${module_name}/profile.erb"),
    }

    if($vm!=undef)
    {
      if(!defined(Concat::Fragment["tuned.conf ${profile_name} vm header"]))
      {
        concat::fragment{ "tuned.conf ${profile_name} vm header":
          target  => "/etc/tuned/${profile_name}/tuned.conf",
          order   => '10',
          content => "\n\n[vm]\n",
        }
      }

      concat::fragment{ "tuned.conf ${profile_name} vm data main profile":
        target  => "/etc/tuned/${profile_name}/tuned.conf",
        order   => '11',
        content => template("${module_name}/vm.erb"),
      }
    }

    if($sysctl!=undef)
    {
      if(!defined(Concat::Fragment["tuned.conf ${profile_name} sysctl header"]))
      {
        concat::fragment{ "tuned.conf ${profile_name} sysctl header":
          target  => "/etc/tuned/${profile_name}/tuned.conf",
          order   => '20',
          content => "\n\n[sysctl]\n",
        }
      }

      concat::fragment{ "tuned.conf ${profile_name} sysctl data main profile":
        target  => "/etc/tuned/${profile_name}/tuned.conf",
        order   => '21',
        content => template("${module_name}/sysctl.erb"),
      }
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
