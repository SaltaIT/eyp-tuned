define tuned::profile::disk (
                              $profile_name = $name,
                              $elevator     = undef,
                            ) {

  include ::tuned

  if($elevator!=undef)
  {
    if($tuned::params::service_name_ktune==undef)
    {
      # centos 7 - disk plugin
      concat::fragment{ "tuned.conf ${profile_name} disk elevator=${elevator};":
        target  => "${tuned::params::tuned_profiles_basepath}/${profile_name}/tuned.conf",
        order   => '23disk0',
        content => template("${module_name}/diskplugin.erb"),
      }
    }
    else
    {
      # ktune mode / centos6
      # ktune.sysconfig
      file { "${tuned::params::tuned_profiles_basepath}/${profile_name}/ktune.sysconfig":
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/ktune-sysconfig.erb"),
        notify  => Class['::tuned::service'],
      }
    }

  }
}
