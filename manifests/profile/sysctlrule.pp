define tuned::profile::sysctlrule($profile_name=$name, $key, $value) {

  concat::fragment{ "tuned.conf ${profile_name} sysctl data set ${name} ${key} ${value}":
    target  => "/etc/tuned/${profile_name}/tuned.conf",
    order   => '22',
    content => "${key}=${value}\n",
  }

}
