define tuned::profile::sysctlrule($profile_name=$name, $key, $value) {

  include ::tuned

  concat::fragment{ "tuned.conf ${profile_name} sysctl data set ${name} ${key} ${value}":
    target  => "${tuned_profiles_basepath}/${profile_name}/tuned.conf",
    order   => '22',
    content => "${key}=${value}\n",
  }

}
