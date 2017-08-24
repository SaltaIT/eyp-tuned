define tuned::profile::sysctlrule (
                                    $key,
                                    $value,
                                    $profile_name = $name,
                                  ) {

  include ::tuned

  concat::fragment{ "tuned.conf ${profile_name} sysctl data set ${name} ${key} ${value}":
    target  => "${tuned::params::tuned_profiles_basepath}/${profile_name}/tuned.conf",
    order   => '22',
    content => "${key}=${value}\n",
  }

}
